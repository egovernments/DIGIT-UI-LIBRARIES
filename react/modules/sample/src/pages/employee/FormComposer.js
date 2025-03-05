import { FormComposerV2 } from "@egovernments/digit-ui-components";
import React, { useState } from "react";
import { useTranslation } from "react-i18next";
import { FormComposerConfig } from "../../configs/FormComposerConfig";
// import { formComposerConfig1 } from "../../configs/FormComposerConfig1";

const FormComposer = (props) => {
    const { t } = useTranslation();
    const [formData, setFormData] = useState({});
    const [state, setState] = useState({});
    // Dummy deepCompare function
    const deepCompare = (obj1, obj2) => JSON.stringify(obj1) === JSON.stringify(obj2);
    
    // Dummy functions to ensure execution
    const getFormAccessors = () => {
        console.log("Fetching form accessors");
        return {};
    };

    const handleSubmit = (value) => {
        console.log("Fetching form accessors",value);
        return {};
    };
    
    const onActionSelect = (data) => {
        console.log("Form submitted with data:", data);
    };
    
    
    const createState = {
        contractNumber: "CNT_12345",
        projectID: "PRJ_98765",
        musterRollNo: "MRN_56789",
        sanctionDate: "2025-03-05",
        projectName: "Smart City Road Construction",
        projectDesc: "Construction of a 5km road in downtown",
        projectLocation: "Downtown Area",
        measurementPeriod: "Q1 2025",
    };

    const measurement = {
        measurementNumber: "M123456",
    };
    const onFormValueChange = (setValue, formData, formState, reset, setError, clearErrors, trigger, getValues) => {
        console.log("Form value changed:", formData);
        if (deepCompare(formData, createState)) {
            setState({ ...createState, ...formData });
        }
    };

    // const config = FormComposerConfig({ defaultValue: createState, measurement }).CreateConfig[0]?.form;

    const config=FormComposerConfig;

    return (
        <div>
            <FormComposerV2
                label={t("MB_SUBMIT_BAR")}
                config={config}
                onSubmit={handleSubmit}
                onFormValueChange={onFormValueChange}
            />
        </div>
    );
};

export default FormComposer;
