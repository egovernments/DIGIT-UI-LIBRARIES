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
        const moduleMessages = messages.filter((message) => message.module === module);
        await LocalizationStore.setCacheData(LOCALE_MODULE(locale, module), moduleMessages);
        if (!Namespaces.includes(module)) {
          Namespaces.push(module);
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

      // Step 1: Serve cached translations instantly (so UI doesn't show raw keys)
      const [, cachedMessages] = await LocalizationStore.get(locale, modules);
      if (cachedMessages.length > 0) {
        LocalizationStore.updateResources(locale, cachedMessages);
      }

      // Step 2: Always fetch from API for all requested modules (fresh data)
      const allModules = [...modules];
      if (Digit.Utils.getMultiRootTenant() && !allModules.includes("digit-tenants")) {
        allModules.push("digit-tenants");
      }

      try {
        const data = await Request({
          url: Urls.localization,
          params: { module: allModules.join(","), locale, tenantId },
          useCache: false
        });

        if (data?.messages) {
          // Update cache with fresh data
          LocalizationStore.store(locale, allModules, data.messages).catch(err => {
            console.error('Error storing localization:', err);
          });
          // Update i18next with fresh translations
          LocalizationStore.updateResources(locale, data.messages);
          return data.messages;
        }
      } catch (apiErr) {
        console.error('API fetch failed, using cached translations:', apiErr);
      }

      // Step 3: If API failed, return whatever we had from cache
      return cachedMessages;
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
      const oldLocale = i18next.language;
      const oldLocaleModules = oldLocale ? await LocalizationStore.getList(oldLocale) : [];

      const modules = await LocalizationStore.getList(locale);
      const allModules = await LocalizationStore.getAllList();

      // A module can still be listed as cached even after its own cache entry
      // has expired independently: the list's TTL is refreshed every time any
      // module is (re)fetched for this locale, but existing modules' entries
      // are not touched, so they can expire while the list still claims them.
      // Verify the data actually exists before treating a listed module as covered.
      const staleModules = [];
      for (const module of modules) {
        const cached = await LocalizationStore.getCacheData(LOCALE_MODULE(locale, module));
        if (!cached) {
          staleModules.push(module);
        }
      }

      let uniqueModules = allModules.filter((module) => !modules.includes(module) || staleModules.includes(module));

      // Never call the API with an empty module list (e.g. when everything is
      // already cached and fresh for this locale) — fall back to the modules
      // the old (currently active) locale had loaded, so the request still
      // carries real module names instead of nothing.
      if (uniqueModules.length === 0) {
        uniqueModules = oldLocaleModules.length > 0 ? oldLocaleModules : allModules;
      }

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