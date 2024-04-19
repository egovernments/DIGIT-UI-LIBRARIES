import React, { useContext, useEffect, useState, useMemo } from "react";
import { useForm, useWatch } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { InboxContext } from "../hoc/InboxSearchComposerContext";
import RenderFormFields from "../molecules/RenderFormFields";
import SubmitBar from "../atoms/SubmitBar";
import Toast from "../atoms/Toast";
import { FilterIcon, RefreshIcon } from "./svgindex";
import HorizontalNavV2 from "./HorizontalNavV2";

const setUIConf = (uiConfig) => {
  if (uiConfig.additionalTabs)
    return [{ uiConfig }, ...uiConfig?.additionalTabs];
  return [{ uiConfig }];
};

const SearchComponent = ({ uiConfig, header = "", screenType = "search", fullConfig, data, activeLink, setActiveLink, browserSession }) => {
  const [navConfig, setNavConfig] = useState(uiConfig?.configNavItems);
  const [allUiConfigs, setAllUiConfigs] = useState(setUIConf(uiConfig));
  const { t } = useTranslation();
  const { state, dispatch } = useContext(InboxContext);
  const [showToast, setShowToast] = useState(null);
  let updatedFields = [];
  const { apiDetails } = fullConfig;
  const [session, setSession, clearSession] = browserSession || [];

  if (fullConfig?.postProcessResult) {
    Digit?.Customizations?.[apiDetails?.masterName]?.[apiDetails?.moduleName]?.postProcess(data, uiConfig);
  }

  const defValuesFromSession = uiConfig?.type === "search" ? session?.searchForm : session?.filterForm;

  const { register, handleSubmit, unregister } = useForm({
    defaultValues: uiConfig?.defaultValues,
  });

  const formData = useWatch();

  const checkKeyDown = (e) => {
    const keyCode = e.keyCode ? e.keyCode : e.key ? e.key : e.which;
    if (keyCode === 13) {
      updatedFields = Object.values(formState?.dirtyFields);
    }
  };

  useEffect(() => {
    clearSearch();
  }, [activeLink]);

  const onSubmit = (data) => {
    const isAnyError = Digit?.Customizations?.[apiDetails?.masterName]?.[apiDetails?.moduleName]?.customValidationCheck ? Digit?.Customizations?.[apiDetails?.masterName]?.[apiDetails?.moduleName]?.customValidationCheck(data) : false;
    if (isAnyError) {
      setShowToast(isAnyError);
      setTimeout(closeToast, 3000);
      return;
    }
    if (updatedFields?.length >= (activeLink ? allUiConfigs?.filter(uiConf => activeLink?.name === uiConf.uiConfig.navLink)?.[0]?.uiConfig?.minReqFields : uiConfig?.minReqFields)) {
      dispatch({
        type: uiConfig?.type === "filter" ? "filterForm" : "searchForm",
        state: {
          ...data
        }
      });
      dispatch({
        type: "tableForm",
        state: { limit: 10, offset: 0 }
      });
    } else {
      setShowToast({ warning: true, label: t("ES_COMMON_MIN_SEARCH_CRITERIA_MSG") });
      setTimeout(closeToast, 3000);
    }
  };

  const clearSearch = () => {
    reset(uiConfig?.defaultValues);
    dispatch({
      type: uiConfig?.type === "filter" ? "clearFilterForm" : "clearSearchForm",
      state: { ...uiConfig?.defaultValues }
    });
    dispatch({
      type: "tableForm",
      state: { limit: 10, offset: 0 }
    });
  };

  const setDefaultValues = () => {
    reset({ ...uiConfig?.defaultValues, ...defValuesFromSession });
  };

  useEffect(() => {
    setDefaultValues();
  }, [session]);

  const closeToast = () => {
    setShowToast(null);
  };

  const renderHeader = () => {
    switch (uiConfig?.type) {
      case "filter": {
        return (
          <div className="filter-header-wrapper">
            <div className="icon-filter"><FilterIcon></FilterIcon></div>
          </div>
        );
      }
      default: {
        return <Header styles={uiConfig?.headerStyle}>{t(header)}</Header>;
      }
    }
  };

  return (
    <HorizontalNavV2 configNavItems={navConfig?.length > 0 ? navConfig : []} showNav={navConfig?.length > 0} activeLink={activeLink} setActiveLink={setActiveLink} fromSearchComp={true} horizontalLine={uiConfig?.horizontalLine}>
      <div className={'search-wrapper'}>
        {header && renderHeader()}
        <form onSubmit={handleSubmit(onSubmit)} onKeyDown={(e) => checkKeyDown(e)}>
          <div>
            {uiConfig?.showFormInstruction && <p className="search-instruction-header">{t(uiConfig?.showFormInstruction)}</p>}
            <div className={`search-field-wrapper ${screenType} ${uiConfig?.formClassName ? uiConfig?.formClassName : ""}`}>
              <RenderFormFields
                fields={activeLink ? allUiConfigs?.filter(uiConf => activeLink?.name === uiConf.uiConfig.navLink)?.[0]?.uiConfig?.fields : uiConfig?.fields}
                control={control}
                formData={formData}
                errors={errors}
                register={register}
                setValue={setValue}
                getValues={getValues}
                setError={setError}
                clearErrors={clearErrors}
                labelStyle={{ fontSize: "16px" }}
                apiDetails={apiDetails}
                data={data}
              />
              <div className={`search-button-wrapper ${screenType} ${uiConfig?.type} ${uiConfig?.searchWrapperClassName}`} style={uiConfig?.searchWrapperStyles}>
                {uiConfig?.secondaryLabel && <LinkLabel style={{ marginBottom: 0, whiteSpace: 'nowrap' }} onClick={clearSearch}>{t(uiConfig?.secondaryLabel)}</LinkLabel>}
                {uiConfig?.primaryLabel && <SubmitBar label={t(uiConfig?.primaryLabel)} submit="submit" disabled={false} />}
              </div>
            </div>
          </div>
        </form>
        {showToast && <Toast
          error={showToast.error}
          warning={showToast.warning}
          label={t(showToast.label)}
          isDleteBtn={true}
          onClose={closeToast} />
        }
      </div>
    </HorizontalNavV2>
  );
};

export default SearchComponent;
