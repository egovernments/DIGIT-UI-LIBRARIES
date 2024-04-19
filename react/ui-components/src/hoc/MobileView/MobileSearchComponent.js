import React, { useContext, useEffect, useState } from "react";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { InboxContext } from "../InboxSearchComposerContext";
import { FilterIcon, SearchIcon, CloseSvg, RefreshIcon, DownloadImgIcon, SortSvg } from "../../atoms/svgindex";
import ActionBar from "../../atoms/ActionBar";
import SubmitBar from "../../atoms/SubmitBar";
import LinkLabel from "../../atoms/LinkLabel";
import RenderFormFields from "../../molecules/RenderFormFields";
import Toast from "../../atoms/Toast";
import _ from "lodash";
import Button from "../../atoms/Button";

const MobileSearchComponent = ({ uiConfig, modalType, header = "", screenType = "search", fullConfig, data, onClose, defaultValues, browserSession }) => {
    const { t } = useTranslation();
    const { state, dispatch } = useContext(InboxContext);
    const [showToast, setShowToast] = useState(null);
    let updatedFields = [];
    const { apiDetails } = fullConfig;
    const [session, setSession, clearSession] = browserSession || [];

    const defValuesFromSession = uiConfig?.typeMobile === "filter" ? session?.searchForm : session?.filterForm;

    const {
        register,
        setError,
        clearErrors,
        handleSubmit,
        control,
        watch,
        setValue,
        getValues,
        formState: { errors }
    } = useForm({
        defaultValues: { ...uiConfig?.defaultValues, ...defValuesFromSession }
    });

    const checkKeyDown = (e) => {
        const keyCode = e.keyCode ? e.keyCode : e.key ? e.key : e.which;
        if (keyCode === 13) {
            // Handle enter key press
        }
    };

    const onSubmit = (data) => {
        onClose?.();
    };

    const clearSearch = () => {
        reset(uiConfig?.defaultValues);
        dispatch({
            type: uiConfig?.type === "filter" ? "clearFilterForm" : "clearSearchForm",
            state: { ...uiConfig?.defaultValues }
        });
    };

    const renderHeader = () => {
        switch (uiConfig?.typeMobile) {
            case "filter": {
                return (
                    <div className="popup-label" style={{ display: "flex", paddingBottom: "20px" }}>
                        <span className="header" style={{ display: "flex" }}>
                            <span className="icon" style={{ marginRight: "12px", marginTop: "5px", paddingBottom: "3px" }}><FilterIcon /></span>
                            <span style={{ fontSize: "1.5rem", fontWeight: "700", marginRight: "12px" }}>{t(`${uiConfig?.headerLabel || "TQM_INBOX_SORTBY"}`)}</span>
                            <span className="clear-search refresh-icon-container" onClick={clearSearch}><RefreshIcon /></span>
                        </span>
                        <span onClick={onClose}>
                            <CloseSvg />
                        </span>
                    </div>
                );
            }
            case "sort": {
                return (
                    <div className="popup-label" style={{ display: "flex", paddingBottom: "20px" }}>
                        <span className="header" style={{ display: "flex" }}>
                            <span className="icon" style={{ marginRight: "12px", marginTop: "5px", paddingBottom: "3px" }}><SortSvg /></span>
                            <span style={{ fontSize: "1.5rem", fontWeight: "700", marginRight: "12px" }}>{t(`${uiConfig?.headerLabel || "TQM_INBOX_SORTBY"}`)}</span>
                            <span className="clear-search refresh-icon-container" onClick={clearSearch}><RefreshIcon /></span>
                        </span>
                        <span onClick={onClose}>
                            <CloseSvg />
                        </span>
                    </div>
                );
            }
            case "search": {
                return (
                    <div className="popup-label" style={{ display: "flex", paddingBottom: "20px" }}>
                        <span className="header" style={{ display: "flex" }}>
                            <span className="icon" style={{ marginRight: "12px", marginTop: "5px" }}><SearchIcon /></span>
                            <span style={{ fontSize: "large" }}>{t(`${uiConfig?.headerLabel || "TQM_INBOX_SORTBY"}`)}</span>
                        </span>
                        <span onClick={onClose}>
                            <CloseSvg />
                        </span>
                    </div>
                );
            }
            default:
                return null;
        }
    };

    return (
        <React.Fragment>
            <div className="search-wrapper">
                <div>{renderHeader()}</div>
                <form onSubmit={handleSubmit(onSubmit)} onKeyDown={(e) => checkKeyDown(e)}>
                    <div className={`search-field-wrapper ${screenType} ${uiConfig?.typeMobile} vertical-gap`}>
                        <RenderFormFields
                            fields={uiConfig?.fields}
                            control={control}
                            formData={formData}
                            errors={errors}
                            register={register}
                            setValue={setValue}
                            getValues={getValues}
                            setError={setError}
                            clearErrors={clearErrors}
                            labelStyle={{ fontSize: '16px' }}
                            apiDetails={apiDetails}
                            data={data}
                        />
                        <ActionBar className="clear-search-container">
                            <div className={`search-button-wrapper ${screenType} inbox ${uiConfig?.typeMobile}`}>
                                {uiConfig?.secondaryLabel && (
                                    <Button
                                        label={t(uiConfig?.secondaryLabel)}
                                        variation="secondary"
                                        onButtonClick={() => clearSearch()}
                                        type="button"
                                    />
                                )}
                                {uiConfig?.primaryLabel && (
                                    <SubmitBar
                                        label={t(uiConfig?.primaryLabel)}
                                        submit="submit"
                                        disabled={false}
                                    />
                                )}
                            </div>
                        </ActionBar>
                    </div>
                </form>
                {showToast && (
                    <Toast
                        error={showToast.error}
                        warning={showToast.warning}
                        label={t(showToast.label)}
                        isDleteBtn={true}
                        onClose={closeToast}
                    />
                )}
            </div>
        </React.Fragment>
    );
};

export default MobileSearchComponent;
