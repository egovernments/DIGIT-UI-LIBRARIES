import React, { useEffect, useMemo, useState, Fragment, useCallback } from "react";
import { useForm, Controller } from "react-hook-form";
import { useTranslation } from "react-i18next";
import _ from "lodash";

// atoms need for initial setup
import BreakLine from "../atoms/BreakLine";
import Card from "../atoms/Card";
import HeaderComponent from "../atoms/HeaderComponent";
import ActionLinks from "../atoms/ActionLinks";
import Footer from "../atoms/Footer";
import LabelFieldPair from "../atoms/LabelFieldPair";
import HorizontalNav from "../atoms/HorizontalNav";
import { SubmitBar, Toast , Button } from "../atoms";

// import Fields from "./Fields";    //This is a field selector pickup from formcomposer
import FieldController from "./FieldController";
import { ButtonIdentificationProvider, SectionIdentificationProvider } from "./ButtonIdentificationContext";

const wrapperStyles = {
  display: "flex",
  flexDirection: "column",
  alignItems: "flex-start",
  border: "solid",
  borderRadius: "5px",
  padding: "10px",
  paddingTop: "20px",
  marginTop: "10px",
  borderColor: "#f3f3f3",
  background: "#FAFAFA",
  marginBottom: "20px",
};

/**
 *  formcomposer used to render forms
 *
 * @author jagankumar-egov
 *
 * @example
 *
 * refer this implementation of sample file
 * frontend/micro-ui/web/micro-ui-internals/packages/modules/AttendenceMgmt/src/pages/citizen/Sample.js
 *
 */

export const FormComposer = (props) => {
  const {
    register,
    handleSubmit,
    setValue,
    getValues,
    reset,
    watch,
    trigger,
    control,
    formState,
    errors,
    setError,
    clearErrors,
    unregister,
  } = useForm({
    defaultValues: props.defaultValues,
  });
  const { t } = useTranslation();
  const formData = watch();
  const selectedFormCategory = props?.currentFormCategory;
  const [showErrorToast, setShowErrorToast] = useState(false);
  const [customToast, setCustomToast] = useState(false); 
  //clear all errors if user has changed the form category.
  //This is done in case user first click on submit and have errors in cat 1, switches to cat 2 and hit submit with errors
  //So, he should not get error prompts from previous cat 1 on cat 2 submit.

  useEffect(() => {
    if (props?.defaultValues && Object.keys(props?.defaultValues).length > 0) {
      reset(props?.defaultValues);
    }
  }, [props?.defaultValues]);

  useEffect(() => {
    clearErrors();
  }, [selectedFormCategory]);

  useEffect(() => {
    if (Object.keys(formState?.errors).length > 0 && formState?.submitCount > 0) {
      setShowErrorToast(true);
    }
    else{
       setShowErrorToast(false);
    }
  }, [formState?.errors, formState?.submitCount]);

  useEffect(() =>{
    if(showErrorToast === true){
    setShowErrorToast(false);
    }
  },[props?.config])

  useEffect(() => {
    if (
      props?.appData &&
      Object.keys(props?.appData)?.length > 0 &&
      (!_.isEqual(props?.appData, formData) || !_.isEqual(props?.appData?.ConnectionHolderDetails?.[0], formData?.ConnectionHolderDetails?.[0]))
    ) {
      reset({ ...props?.appData });
    }
  }, [props?.appData, formData, props?.appData?.ConnectionHolderDetails]);

  useEffect(() => {
    props.getFormAccessors && props.getFormAccessors({ setValue, getValues });
  }, []);

  useEffect(()=>{
    setCustomToast(props?.customToast);
  },[props?.customToast])
  function onSubmit(data) {
    props.onSubmit(data);
  }

  function onSecondayActionClick(data) {
    props.onSecondayActionClick();
  }

  useEffect(() => {
    props.onFormValueChange && props.onFormValueChange(setValue, formData, formState, reset, setError, clearErrors, trigger, getValues);
  }, [formData]);

  const fieldSelector = (type, populators, isMandatory, disable = false, component, config, sectionFormCategory) =>
    // Calling field controller to render all label and fields
    FieldController({
      type: type,
      populators: populators,
      isMandatory: isMandatory,
      disable: disable,
      component: component,
      config: config,
      sectionFormCategory: sectionFormCategory,
      formData: formData,
      selectedFormCategory: selectedFormCategory,
      control: control,
      props: props,
      errors: errors,
      controllerProps: {
        register,
        handleSubmit,
        setValue,
        getValues,
        reset,
        watch,
        trigger,
        control,
        formState,
        errors,
        setError,
        clearErrors,
        unregister,
      },
    });

  const getCombinedStyle = (placementinBox) => {
    switch (placementinBox) {
      case 0:
        return {
          border: "solid",
          borderRadius: "5px",
          padding: "10px",
          paddingTop: "20px",
          marginTop: "10px",
          borderColor: "#f3f3f3",
          background: "#FAFAFA",
          marginBottom: "20px",
        };
      case 1:
        return {
          border: "solid",
          borderRadius: "5px",
          padding: "10px",
          paddingTop: "20px",
          marginTop: "-30px",
          borderColor: "#f3f3f3",
          background: "#FAFAFA",
          borderTop: "0px",
          borderBottom: "0px",
        };
      case 2:
        return {
          border: "solid",
          borderRadius: "5px",
          padding: "10px",
          paddingTop: "20px",
          marginTop: "-30px",
          borderColor: "#f3f3f3",
          background: "#FAFAFA",
          marginBottom: "20px",
          borderTop: "0px",
        };
    }
  };

  const getCombinedComponent = (section) => {
    if (section.head && section.subHead) {
      return (
        <>
          <HeaderComponent
            className={`digit-card-section-header titleStyle ${section?.sectionHeadClassName || ""}`}
            id={section.headId}
          >
            {t(section.head)}
          </HeaderComponent>
          <HeaderComponent 
          id={`${section.headId}_DES`}
          className={`sectionSubHeaderStyle ${section?.sectionSubHeadClassName || ""}`}
          >
            {t(section.subHead)}
          </HeaderComponent>
        </>
      );
    }

    if (section.head) {
      return (
        <HeaderComponent
          className={`digit-card-section-header titleStyle ${section?.sectionHeadClassName || ""}`}
          id={section.headId}
        >
          {t(section.head)}
        </HeaderComponent>
      );
    }

    return null; 
  };


  const closeToast = () => {
    setShowErrorToast(false);
    setCustomToast(false);
    props?.updateCustomToast&&props?.updateCustomToast(false);
  };


  const formFields = useCallback(
    (section, index, array, sectionFormCategory) => (
      <React.Fragment key={index}>
        {section && getCombinedComponent(section)}
        {section.body.map((field, index) => {
          if (field?.populators?.hideInForm) return null;
          if (props.inline)
            return (
              <React.Fragment key={index}>
                <div style={field.isInsideBox ? getCombinedStyle(field?.placementinbox) : field.inline ? { display: "flex" } : {}}>
                  {/* {!field.withoutLabel && (
                    <HeaderComponent
                      style={{ color: field.isSectionText ? "#505A5F" : "", marginBottom: props.inline ? "8px" : "revert" }}
                      className={` ${field?.disable ? `disabled ${props?.labelBold ? "bolder" : ""}` : `${props?.labelBold ? "bolder" : ""}`}`}
                    >
                      {t(field.label)}
                      {field.isMandatory ? " * " : null}
                      {field.labelChildren && field.labelChildren}
                    </HeaderComponent>
                  )} */}
                  {/* {errors && errors[field.populators?.name] && Object.keys(errors[field.populators?.name]).length ? (
                    <ErrorMessage>{t(field.populators.error || errors[field.populators?.name]?.message)}</ErrorMessage>
                  ) : null} */}
                  <div style={field.withoutLabel ? { width: "100%" } : {}} className="digit-field">
                    {fieldSelector(field.type, field.populators, field.isMandatory, field?.disable, field?.component, field, sectionFormCategory)}
                    {field?.description && (
                      <HeaderComponent
                        style={{
                          marginTop: "-24px",
                          fontSize: "16px",
                          fontWeight: "bold",
                          color: "#505A5F",
                          ...field?.descriptionStyles,
                        }}
                        className="bolder"
                      >
                        {t(field.description)}
                      </HeaderComponent>
                    )}
                  </div>
                </div>
              </React.Fragment>
            );
          return (
            <Fragment>
              <LabelFieldPair
                key={index}
                style={
                  props?.showWrapperContainers && !field.hideContainer
                    ? { ...wrapperStyles, ...field?.populators?.customStyle }
                    : { border: "none", background: "white", ...field?.populators?.customStyle }
                }
                vertical={props?.labelfielddirectionvertical}
              >
                {fieldSelector(field.type, field.populators, field.isMandatory, field?.disable, field?.component, field, sectionFormCategory)}

                {/* Commenting to initialize & check Field Controller and composer which render label and field Should remove later*/}
                {/*{!field.withoutLabel && (
                  <HeaderComponent
                    style={{
                      color: field.isSectionText ? "#505A5F" : "",
                      marginBottom: props.inline ? "8px" : "revert",
                      fontWeight: props.isDescriptionBold ? "600" : null,
                    }}
                    className="label"
                  >
                    {t(field.label)}
                    {field?.appendColon ? " : " : null}
                    {field.isMandatory ? " * " : null}
                  </HeaderComponent>
                )}
                <div style={field.withoutLabel ? { width: "100%", ...props?.fieldStyle } : { ...props?.fieldStyle }} className="digit-field">
                  {fieldSelector(field.type, field.populators, field.isMandatory, field?.disable, field?.component, field, sectionFormCategory)}
                  {field?.description && <CardText style={{ fontSize: "14px", marginTop: "-24px" }}>{t(field?.description)}</CardText>}
                  </div> */}
              </LabelFieldPair>

              {/* Migrating error message to field container as here it renders outside the field */}
              {/* {field?.populators?.name && errors && errors[field?.populators?.name] && Object.keys(errors[field?.populators?.name]).length ? (
                <ErrorMessage message={t(field?.populators?.error)} />
              ) : // {t(field?.populators?.error)}
              // </ErrorMessage>
              null} */}
            </Fragment>
          );
        })}
        {!props.noBreakLine && (array.length - 1 === index ? null : <BreakLine style={props?.breaklineStyle ? props?.breaklineStyle : {}} />)}
      </React.Fragment>
    ),
    [props.config, formData]
  );

  const getCardStyles = (shouldDisplay = true) => {
    let styles = props.cardStyle || {};
    if (props.noBoxShadow) styles = { ...styles, boxShadow: "none" };
    if (!shouldDisplay) styles = { ...styles, display: "none" };
    return styles;
  };

  const isDisabled = props.isDisabled || false;
  const checkKeyDown = (e) => {
    const keyCode = e.keyCode ? e.keyCode : e.key ? e.key : e.which;
    if (keyCode === 13) {
      // e.preventDefault();
    }
  };

  const setActiveNavByDefault = (configNav) => {
    let setActiveByDefaultRow = null;
    configNav?.forEach((row) => {
      if (row?.activeByDefault) {
        setActiveByDefaultRow = row;
      }
    });

    if (setActiveByDefaultRow) {
      return setActiveByDefaultRow?.name;
    }

    return configNav?.[0]?.name;
  };

  const [activeLink, setActiveLink] = useState(props.horizontalNavConfig ? setActiveNavByDefault(props.horizontalNavConfig) : null);

  useEffect(() => {
    setActiveLink(setActiveNavByDefault(props.horizontalNavConfig));
  }, [props.horizontalNavConfig]);

  const renderFormFields = (props, section, index, array, sectionFormCategory) => (
    <React.Fragment key={index}>
      {!props.childrenAtTheBottom && props.children}
      {props.heading && <HeaderComponent className={props?.cardSubHeaderClassName ? `digit-form-card-subheader ${props?.cardSubHeaderClassName}` : "digit-form-card-subheader"} styles={{ ...props.headingStyle }}> {props.heading} </HeaderComponent>}
      {props.description && <HeaderComponent className={props?.cardDescriptionClassName ? `digit-form-card-description ${props?.cardDescriptionClassName}` : "digit-form-card-description"} styles={{ ...props.descriptionStyles }}> {props.description} </HeaderComponent>}
      {props.text && <HeaderComponent className={props?.cardTextClassName ? `digit-form-card-text ${props?.cardTextClassName}` : "digit-form-card-text"}>{props.text}</HeaderComponent>}
      {formFields(section, index, array, sectionFormCategory)}
      {props.childrenAtTheBottom && props.children}
      {props.submitInForm && (
        <SubmitBar id={props?.primaryActionId || "formcomposer-submit-action"} label={t(props.label)} style={{ width:"100%",...props?.buttonStyle }} submit="submit" disabled={isDisabled} className="w-full"/>
      )}
      {props.submitInForm && (props.loginWithMicroSoft || (props.ssoConfigs?.length > 0)) && (
        <div style={{ display: "flex", alignItems: "center", margin: "20px 0" }}>
          <div style={{ flex: 1, height: "1px", backgroundColor: "#D6D5D4" }}></div>
          <span style={{ margin: "0 10px", color: "#505A5F", fontSize: "14px" }}>
            {props.ssoConfigs?.length > 1 ? t("CORE_COMMON_OR_SIGN_IN_WITH") : t("CORE_COMMON_OR")}
          </span>
          <div style={{ flex: 1, height: "1px", backgroundColor: "#D6D5D4" }}></div>
        </div>
      )}
      {props.loginWithMicroSoft && (
        <div
          className="microsoft-login-btn"
          style={{
            margin: "0 auto",
            cursor: "pointer",
            backgroundColor: "#f47738",
            border: "1px solid #f47738",
            color: "#FFF",
            height: "40px",
            fontWeight: "700",
            boxShadow: "0 2px 0 #0b0c0c",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            padding: "10px 12px",
            border: "1px solid #8A8886",
            borderRadius: "0px",
            width: "100%",
            maxWidth: "100%",
            fontFamily: '"Segoe UI", "Helvetica Neue", "Lucida Grande", Roboto, "Ebrima", "Nirmala UI", "Gadugi", "Segoe Xbox Symbol", "Segoe UI Symbol", "Meiryo UI", "Khmer UI", "Tunga", "Lao UI", "Raavi", "Iskoola Pota", "Latha", "Leelawadee", "Microsoft YaHei UI", "Microsoft JhengHei UI", "Malgun Gothic", "Estrangelo Edessa", "Microsoft Himalaya", "Microsoft New Tai Lue", "Microsoft PhagsPa", "Microsoft Tai Le", "Microsoft Yi Baiti", "Mongolian Baiti", "MV Boli", "Myanmar Text", "Cambria Math"',
            fontSize: "15px",
            fontWeight: "600"
          }}
          onClick={() => props.onSSOLogin({
            authStrategy: "MSAL",
            provider: "MICROSOFT",
            clientId: window?.globalConfigs?.getConfig?.("MICROSOFT_CLIENT_ID"),
            tenantId: window?.globalConfigs?.getConfig?.("MICROSOFT_TENANT_ID")
          })}
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" viewBox="0 0 21 21" style={{ marginRight: "12px" }}>
            <title>MS-SymbolLockup</title>
            <rect x="1" y="1" width="9" height="9" fill="#f25022" />
            <rect x="11" y="1" width="9" height="9" fill="#7fba00" />
            <rect x="1" y="11" width="9" height="9" fill="#00a4ef" />
            <rect x="11" y="11" width="9" height="9" fill="#ffb900" />
          </svg>
          {t(props.loginWithMicroSoft)}
        </div>
      )}
      {props.ssoConfigs && props.ssoConfigs.length > 1 ? (
        <div style={{ display: "flex", justifyContent: "center", gap: "24px", marginTop: "16px", flexWrap: "wrap" }}>
          {props.ssoConfigs.map((sso, index) => (
            <div
              key={index}
              className={`sso-login-icon ${sso.provider.toLowerCase()}-login-icon`}
              style={{
                cursor: "pointer",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                width: "48px",
                height: "48px",
                border: "1px solid #D6D5D4",
                borderRadius: "4px",
                backgroundColor: "#F7F8F9",
                transition: "all 0.2s ease",
                padding: "8px",
                ...sso.iconStyle
              }}
              onClick={() => sso.onLogin(sso)}
              title={t(sso.label)}
            >
              <div style={{ width: "24px", height: "24px", display: "flex", alignItems: "center", justifyContent: "center" }}>
                {sso.icon}
              </div>
            </div>
          ))}
        </div>
      ) : (
        props.ssoConfigs && props.ssoConfigs.map((sso, index) => (
          <div
            key={index}
            className={`sso-login-btn ${sso.provider.toLowerCase()}-login-btn`}
            style={{
              margin: "10px auto 0 auto",
              cursor: "pointer",
              backgroundColor: sso.backgroundColor || "#f47738",
              color: sso.color || "#FFF",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              padding: "10px 12px",
              border: "1px solid #f47738",
              borderRadius: sso.borderRadius || "0px",
              width: "100%",
              maxWidth: "100%",
              fontSize: "15px",
              fontWeight: "700",
              height: "40px",
              boxShadow: "0 2px 0 #0b0c0c",
              ...sso.style
            }}
            onClick={() => sso.onLogin(sso)}
          >
            <div style={{ width: "21px", height: "21px", marginRight: "12px", display: "flex", alignItems: "center", justifyContent: "center" }}>
              {sso.icon}
            </div>
            {t(sso.label)}
          </div>
        ))
      )}
      {props.secondaryActionLabel && (
        <div
          className="primary-label-btn"
          role="button"
          id={props?.secondaryActionId || "formcomposer-secondary-action"}
          tabIndex={0}
          style={{ margin: "20px auto 0 auto" }}
          onClick={onSecondayActionClick}
          onKeyDown={(e) => {
            if (e.key === "Enter" || e.key === " ") {
              onSecondayActionClick();
            }
          }}
        >
          {props.secondaryActionLabel}
        </div>
      )}
    </React.Fragment>
  );

  return (
    <ButtonIdentificationProvider
      composerType="formcomposer"
      composerId={props.formId || props.className || "form"}
    >
      <form onSubmit={handleSubmit(onSubmit)} onKeyDown={(e) => checkKeyDown(e)} id={props.formId} className={props.className}>
        {props?.showMultipleCardsWithoutNavs ? (
          props?.config?.map((section, index, array) => {
            return (
              !section.navLink && (
                <SectionIdentificationProvider key={index} sectionId={section?.headId || `section-${index}`}>
                  <Card style={getCardStyles()} noCardStyle={props.noCardStyle} className={props.cardClassName}>
                    {renderFormFields(props, section, index, array)}
                  </Card>
                </SectionIdentificationProvider>
              )
            );
          })
        ) : (
          <Card style={getCardStyles()} noCardStyle={props.noCardStyle} className={props.cardClassName}>
            {props?.config?.map((section, index, array) => {
              return !section.navLink && (
                <SectionIdentificationProvider key={index} sectionId={section?.headId || `section-${index}`}>
                  {renderFormFields(props, section, index, array)}
                </SectionIdentificationProvider>
              );
            })}
          </Card>
        )}
        {props?.showFormInNav && props.horizontalNavConfig && (
          <HorizontalNav
            configNavItems={props.horizontalNavConfig ? props.horizontalNavConfig : null}
            showNav={props?.showNavs}
            activeLink={activeLink}
            setActiveLink={setActiveLink}
          >
            {props?.showMultipleCardsInNavs ? (
              props?.config?.map((section, index, array) => {
                return section.navLink ? (
                  <SectionIdentificationProvider key={index} sectionId={section?.headId || section.navLink || `nav-section-${index}`}>
                    <Card style={section.navLink !== activeLink ? getCardStyles(false) : getCardStyles()} noCardStyle={props.noCardStyle}>
                      {renderFormFields(props, section, index, array, section?.sectionFormCategory)}
                    </Card>
                  </SectionIdentificationProvider>
                ) : null;
              })
            ) : (
              <Card style={getCardStyles()} noCardStyle={props.noCardStyle}>
                {props?.config?.map((section, index, array) => {
                  return section.navLink ? (
                    <SectionIdentificationProvider key={index} sectionId={section?.headId || section.navLink || `nav-section-${index}`}>
                      <div style={section.navLink !== activeLink ? { display: "none" } : {}}>
                        {renderFormFields(props, section, index, array, section?.sectionFormCategory)}
                      </div>
                    </SectionIdentificationProvider>
                  ) : null;
                })}
              </Card>
            )}
          </HorizontalNav>
        )}
        {!props.submitInForm && props.label && (
          <Footer className={props.actionClassName}>
            <SubmitBar name="primary-submit" label={t(props.label)} className="digit-formcomposer-submitbar" submit="submit" disabled={isDisabled} icon={props?.primaryActionIcon} isSuffix={props?.primaryActionIconAsSuffix} />
            {props?.secondaryLabel && props?.showSecondaryLabel && (
              <Button name="secondary-action" className="previous-button" variation="secondary" label={t(props?.secondaryLabel)} onClick={props?.onSecondayActionClick} icon={props?.secondaryActionIcon} isSuffix={props?.secondaryActionIconAsSuffix} />
            )}
            {props.onSkip && props.showSkip && <ActionLinks style={props?.skipStyle} label={t(`CS_SKIP_CONTINUE`)} onClick={props.onSkip} />}
          </Footer>
        )}
        {showErrorToast && props?.showFormLevelErrorToast !== false && <Toast type={"error"} label={t(props?.formLevelErrorMessage || "ES_COMMON_PLEASE_ENTER_ALL_MANDATORY_FIELDS")} isDleteBtn={true} onClose={closeToast} />}
        {customToast && <Toast type={customToast?.type} label={t(customToast?.label)} isDleteBtn={true} onClose={closeToast} />}
      </form>
    </ButtonIdentificationProvider>
  );
};