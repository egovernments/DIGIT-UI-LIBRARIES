import Axios from "axios";

/**
 * Custom Request to make all api calls
 *
 * @author jagankumar-egov
 *
 */

Axios.interceptors.response.use(
  (res) => res,
  (err) => {
    const isEmployee = window.location.pathname.split("/").includes("employee");
    if (err?.response?.data?.Errors) {
      for (const error of err.response.data.Errors) {
        /**
         * The IdP ID token is missing or expired (401, code "sso.id_token.missing").
         *
         * Matched on `code`, not `message`, because the message is prose the gateway may
         * reword, and checked first so an error carrying no `message` cannot throw on the
         * branches below before reaching here.
         *
         * The DIGIT access token can still be perfectly valid in this state, so none of the
         * existing branches matched and the request simply failed: the user stayed "logged
         * in" on a page where every call 401s, with nothing on screen to explain it. The ID
         * token's cookie carries Max-Age from the token's own `exp`, so this is the ordinary
         * end state of a session left open, not an edge case.
         *
         * Two deliberate differences from the InvalidAccessTokenException branch below:
         *   - the per-tenant language preferences are kept. They are meant to survive a
         *     logout, and a blanket localStorage.clear() would drop them.
         *   - the user is returned to the deployment they logged IN through. Where tenants
         *     are separate deployments on one origin, that is not this contextPath.
         */
        if (error?.code?.startsWith("sso.id_token.")) {
          const source = localStorage.getItem("login.source") || window?.contextPath;
          const preservedLanguages = {};
          try {
            for (let i = 0; i < localStorage.length; i++) {
              const key = localStorage.key(i);
              if (key && key.startsWith("Digit.locale.")) preservedLanguages[key] = localStorage.getItem(key);
            }
          } catch (e) {
            /* a lost preference just means the default is used next time */
          }
          localStorage.clear();
          sessionStorage.clear();
          try {
            Object.entries(preservedLanguages).forEach(([key, value]) => localStorage.setItem(key, value));
          } catch (e) {
            /* ignore */
          }
          window.location.href =
            (isEmployee ? `/${source}/employee/user/login` : `/${source}/citizen/login`) +
            `?from=${encodeURIComponent(window.location.pathname + window.location.search)}`;
        } else if (error.message.includes("InvalidAccessTokenException")) {
          localStorage.clear();
          sessionStorage.clear();
          window.location.href =
          (isEmployee ? `/${window?.contextPath}/employee/user/login` : `/${window?.contextPath}/citizen/login`) +
            `?from=${encodeURIComponent(window.location.pathname + window.location.search)}`;
        } else if (
          error?.message?.toLowerCase()?.includes("internal server error") ||
          error?.message?.toLowerCase()?.includes("some error occured")
        ) {
          window.location.href =
          (isEmployee ? `/${window?.contextPath}/employee/user/error` : `/${window?.contextPath}/citizen/error`) +
                      `?type=maintenance&from=${encodeURIComponent(window.location.pathname + window.location.search)}`;
        } else if (error.message.includes("ZuulRuntimeException")) {
          window.location.href =
          (isEmployee ? `/${window?.contextPath}/employee/user/error` : `/${window?.contextPath}/citizen/error`) +
                      `?type=notfound&from=${encodeURIComponent(window.location.pathname + window.location.search)}`;
        }
      }
    }
    throw err;
  }
);

const requestInfo = () => ({
  authToken: Digit.UserService.getUser()?.access_token || null,
});

const authHeaders = () => ({
  "auth-token": Digit.UserService.getUser()?.access_token || null,
});

const userServiceData = () => ({ userInfo: Digit.UserService.getUser()?.info });

window.Digit = window.Digit || {};
window.Digit = { ...window.Digit, RequestCache: window.Digit.RequestCache || {} };
export const Request = async ({
  method = "POST",
  url,
  data = {},
  headers = {},
  useCache = false,
  params = {},
  auth=true,
  urlParams = {},
  userService,
  locale = true,
  authHeader = false,
  setTimeParam = true,
  userDownload = false,
  noRequestInfo = false,
  multipartFormData = false,
  multipartData = {},
  reqTimestamp = false,
}) => {
  const ts = new Date().getTime();
  if (method.toUpperCase() === "POST") {
   
    data.RequestInfo = {
      apiId: "Rainmaker",
    };
    
    if (auth) {
      data.RequestInfo = { ...data.RequestInfo, ...requestInfo() };
    }
    if (userService) {
      data.RequestInfo = { ...data.RequestInfo, ...userServiceData() };
    }
    if (locale) {
      data.RequestInfo = { ...data.RequestInfo, msgId: `${ts}|${Digit.StoreData.getCurrentLanguage()}` };
    }
    
    if (noRequestInfo) {
      delete data.RequestInfo;
    }

    /* 
    Feature :: Privacy
    
    Desc :: To send additional field in HTTP Requests inside RequestInfo Object as plainAccessRequest
    */
    const privacy = Digit.Utils.getPrivacyObject();
    if (privacy && !url.includes("/edcr/rest/dcr/")) {
      if(!noRequestInfo){
      data.RequestInfo = { ...data.RequestInfo, plainAccessRequest: { ...privacy } };
      }
    }
  }

  const headers1 = {
    "Content-Type": "application/json",
    Accept: window?.globalConfigs?.getConfig("ENABLE_SINGLEINSTANCE") ? "application/pdf,application/json" : "application/pdf",
  };

  if (authHeader) headers = { ...headers, ...authHeaders() };

  if (userDownload) headers = { ...headers, ...headers1 };

  let key = "";
  if (useCache) {
    key = `${method.toUpperCase()}.${url}.${btoa(escape(JSON.stringify(params, null, 0)))}.${btoa(escape(JSON.stringify(data, null, 0)))}`;
    const value = window.Digit.RequestCache[key];
    if (value) {
      return value;
    }
  } else if (setTimeParam) {
    params._ = Date.now();
  }
  if (reqTimestamp) {
    data.RequestInfo = { ...data.RequestInfo, ts: Number(ts) };
  }

  let _url = url
    .split("/")
    .map((path) => {
      let key = path.split(":")?.[1];
      return urlParams[key] ? urlParams[key] : path;
    })
    .join("/");

  if (multipartFormData) {
    const multipartFormDataRes = await Axios({
      method,
      url: _url,
      data: multipartData.data,
      params,
      headers: { "Content-Type": "multipart/form-data", "auth-token": Digit.UserService.getUser()?.access_token || null },
    });
    return multipartFormDataRes;
  }
  /* 
  Feature :: Single Instance

  Desc :: Fix for central instance to send tenantID in all query params
  */
  const tenantInfo =
    Digit.SessionStorage.get("userType") === "citizen"
      ? Digit.ULBService.getStateId()
      : Digit.ULBService.getCurrentTenantId() || Digit.ULBService.getStateId();
  if (!params["tenantId"] && window?.globalConfigs?.getConfig("ENABLE_SINGLEINSTANCE")) {
    params["tenantId"] = tenantInfo;
  }

  const res = userDownload
    ? await Axios({ method, url: _url, data, params, headers, responseType: "arraybuffer" })
    : await Axios({ method, url: _url, data, params, headers });

  if (userDownload) return res;

  const returnData = res?.data || res?.response?.data || {};
  if (useCache && res?.data && Object.keys(returnData).length !== 0) {
    window.Digit.RequestCache[key] = returnData;
  }
  return returnData;
};

/**
 *
 * @param {*} serviceName
 *
 * preHook:
 * ({params, data}) => ({params, data})
 *
 * postHook:
 * ({resData}) => ({resData})
 *
 */

export const ServiceRequest = async ({
  serviceName,
  method = "POST",
  url,
  data = {},
  headers = {},
  useCache = false,
  params = {},
  auth,
  reqTimestamp,
  userService,
}) => {
  const preHookName = `${serviceName}Pre`;
  const postHookName = `${serviceName}Post`;

  let reqParams = params;
  let reqData = data;
  if (window[preHookName] && typeof window[preHookName] === "function") {
    let preHookRes = await window[preHookName]({ params, data });
    reqParams = preHookRes.params;
    reqData = preHookRes.data;
  }
  const resData = await Request({ method, url, data: reqData, headers, useCache, params: reqParams, auth, userService,reqTimestamp });

  if (window[postHookName] && typeof window[postHookName] === "function") {
    return await window[postHookName](resData);
  }
  return resData;
};
