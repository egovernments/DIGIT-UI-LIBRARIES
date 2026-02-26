import Urls from "../../atoms/urls";
import { PersistantStorage } from "../../atoms/Utils/Storage";
import i18next from "i18next";
import { Request } from "../../atoms/Utils/Request";
import { ApiCacheService } from "../../atoms/ApiCacheService";
import { IndexedDbStorage } from "../../atoms/Utils/IndexedDbStorage";

const LOCALE_LIST = (locale) => `Locale.${locale}.List`;
const LOCALE_ALL_LIST = () => `Locale.List`;
const LOCALE_MODULE = (locale, module) => `Locale.${locale}.${module}`;

const TransformArrayToObj = (traslationList) => {
  return traslationList.reduce(
    // eslint-disable-next-line
    (obj, item) => ((obj[item.code] = item.message), obj),
    {}
  );
  // return trasformedTraslation;
};

const getUnique = (arr) => {
  return arr.filter((value, index, self) => self.indexOf(value) === index);
};

const LocalizationStore = {
  getCacheData: async (key) => {    
    try {
      const idbValue = await IndexedDbStorage.get(key);
      return idbValue;    
    } catch (err) {
      console.error('Error getting cache data:', err);
      return null;
    }
  },

  setCacheData: async (key, value) => {
    try {
      const cacheSetting = ApiCacheService.getSettingByServiceUrl(Urls.localization);
      const ttl = cacheSetting?.cacheTimeInSecs || null;
      await IndexedDbStorage.set(key, value, ttl);
    } catch (err) {
      console.error('Error setting cache data:', err);
    }
  },

  getList: async (locale) => {
    const list = await LocalizationStore.getCacheData(LOCALE_LIST(locale));
    return list || [];
  },

  setList: async (locale, namespaces) => {
    await LocalizationStore.setCacheData(LOCALE_LIST(locale), namespaces);
  },

  getAllList: async () => {
    const list = await LocalizationStore.getCacheData(LOCALE_ALL_LIST());
    return list || [];
  },

  setAllList: async (namespaces) => {
    await LocalizationStore.setCacheData(LOCALE_ALL_LIST(), namespaces);
  },

  store: async (locale, modules, messages) => {
    try {
      const AllNamespaces = await LocalizationStore.getAllList();
      const Namespaces = await LocalizationStore.getList(locale);

      for (const module of modules) {
        if (!Namespaces.includes(module)) {
          Namespaces.push(module);
          const moduleMessages = messages.filter((message) => message.module === module);
          await LocalizationStore.setCacheData(LOCALE_MODULE(locale, module), moduleMessages);
        }
      }

      await LocalizationStore.setCacheData(LOCALE_LIST(locale), Namespaces);
      await LocalizationStore.setAllList(getUnique([...AllNamespaces, ...Namespaces]));
    } catch (err) {
      console.error('Error storing localization data:', err);
    }
  },

  get: async (locale, modules) => {
    try {
      const storedModules = await LocalizationStore.getList(locale);
      const newModules = modules.filter((module) => !storedModules.includes(module));

      if (Digit.Utils.getMultiRootTenant()) {
        if (!newModules.includes("digit-tenants")) {
          newModules.push("digit-tenants");
        }
      }

      const messages = [];
      for (const module of storedModules) {
        const moduleMsgs = await LocalizationStore.getCacheData(LOCALE_MODULE(locale, module));
        if (moduleMsgs && Array.isArray(moduleMsgs)) {
          messages.push(...moduleMsgs);
        }
      }

      return [newModules, messages];
    } catch (err) {
      console.error('Error getting localization data:', err);
      return [modules, []];
    }
  },

  updateResources: (locale, messages) => {
    if (messages && messages.length > 0) {
      let locales = TransformArrayToObj(messages);
      i18next.addResources(locale, "translations", locales);
    }
  },
};

function getUniqueData(data1, data2) {
  const data1Codes = new Set(data1.map(item => item.code));
  return data2.filter(item => !data1Codes.has(item.code));
}

export const LocalizationService = {
  getLocale: async ({ modules = [], locale = Digit.Utils.getDefaultLanguage(), tenantId }) => {
    try {
      if (locale.indexOf(Digit.Utils.getLocaleRegion()) === -1) {
        locale += Digit.Utils.getLocaleRegion();
      }

      const [newModules, messages] = await LocalizationStore.get(locale, modules);

      if (newModules.length > 0) {
        const data = await Request({
          url: Urls.localization,
          params: { module: newModules.join(","), locale, tenantId },
          useCache: false
        });

        if (data?.messages) {
          messages.push(...data.messages);
          LocalizationStore.store(locale, newModules, data.messages).catch(err => {
            console.error('Error storing localization:', err);
          });
        }
      }

      LocalizationStore.updateResources(locale, messages);
      return messages;
    } catch (err) {
      console.error('Error in getLocale:', err);
      return [];
    }
  },

  getUpdatedMessages: async ({ modules = [], locale = Digit.Utils.getDefaultLanguage(), tenantId }) => {
    try {
      const [, messages] = await LocalizationStore.get(locale, modules);
      const data = await Request({
        url: Urls.localization,
        params: { module: modules.join(","), locale, tenantId },
        useCache: false
      });

      if (data?.messages) {
        const uniques = getUniqueData(messages, data.messages);
        messages.push(...uniques);

        if (uniques.length > 0) {
          LocalizationStore.store(locale, modules, uniques).catch(err => {
            console.error('Error storing updated localization:', err);
          });
        }
      }

      LocalizationStore.updateResources(locale, messages);
      return messages;
    } catch (err) {
      console.error('Error in getUpdatedMessages:', err);
      return [];
    }
  },

  changeLanguage: async (locale, tenantId) => {
    try {
      const modules = await LocalizationStore.getList(locale);
      const allModules = await LocalizationStore.getAllList();
      const uniqueModules = allModules.filter((module) => !modules.includes(module));

      await LocalizationService.getLocale({ modules: uniqueModules, locale, tenantId });

      localStorage.setItem("Employee.locale", locale);
      localStorage.setItem("Citizen.locale", locale);
      Digit.SessionStorage.set("locale", locale);
      i18next.changeLanguage(locale);
    } catch (err) {
      console.error('Error in changeLanguage:', err);
    }
  },

  updateResources: (locale = Digit.Utils.getDefaultLanguage(), messages) => {
    if (locale.indexOf(Digit.Utils.getLocaleRegion()) === -1) {
      locale += Digit.Utils.getLocaleRegion();
    }
    LocalizationStore.updateResources(locale, messages);
  },

  getLocaleMessage: async ({ modules = [], locale = Digit.Utils.getDefaultLanguage(), tenantId, code }) => {
    try {
      const messages = [];
      if (modules.length > 0) {
        const data = await Request({
          url: Urls.localization,
          params: { module: modules.join(","), locale: locale, tenantId },
          useCache: false
        });

        if (data?.messages) {
          messages.push(...data.messages);
        }
      }
      return messages.find(item => item.code === code)?.message;
    } catch (err) {
      console.error('Error in getLocaleMessage:', err);
      return undefined;
    }
  },
};