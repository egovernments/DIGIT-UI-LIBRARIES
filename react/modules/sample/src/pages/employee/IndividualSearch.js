import { Header } from '@egovernments/digit-ui-react-components';
import React, { useState, useEffect, useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { Button, InboxSearchComposer, PopUp } from '@egovernments/digit-ui-components';
import { searchconfig } from '../../configs/IndividualSearchConfig';

const defaultSearchValues = {
  individualName: '',
  mobileNumber: '',
  IndividualID: '',
};

const IndividualSearch = () => {
  const { t } = useTranslation();
  const [defaultValues, setDefaultValues] = useState(defaultSearchValues); // State to hold default values for search fields
  const [searchConfig,setSearchConfig] = useState(searchconfig());
  const [counter, updateCounter] = useState(0);
  const [showPopup, setShowPopup] = useState(false);

  useEffect(() => {
    // Set default values when component mounts
    setDefaultValues(defaultSearchValues);
  }, []);

  
  const handleButtonClick = () => {
    setSearchConfig(prev => {
      return {...prev}
    })
  }
  const customizers = useMemo(()=>({
    preProcess: (data) => {
      delete data.params.tenantId;
      delete data.params.limit;
      delete data.params.offset;
      delete data.body.apiOperation;
      delete data.body.Individual;
      data.body.MdmsCriteria = {
        tenantId: 'dev',
        filters: {},
        schemaCode: 'test.projectconfig',
        limit: data.state.tableForm.limit,
        offset: data.state.tableForm.offset,
      };
      return data;
    },
    additionalCustomizations: (row, key, column, value, t, searchResult) => {
      //here we can add multiple conditions
      //like if a cell is link then we return link
      //first we can identify which column it belongs to then we can return relevant result
      switch (key) {
        case 'Id':
          return (
            <button onClick={() => updateCounter((prev) => {
              console.log("cliked")
              return prev + 1
            })}>
              {`Update State ${value}`} 
            </button>
          );
        case 'Popup':
          return (
            <button onClick={() => setShowPopup(true)}>
              Show Popups
            </button>
          );
        case 'Edit':
          return(
            <Button
              variation="primary"
              label={"Edit Row"}
              type="button"
              icon="Edit"
              onClick={handleButtonClick}
            />
          )
        default:
          return t('ES_COMMON_NA');
      }
    },
    getMutationPayload:(formData,rowData) => {
      debugger
      const row = rowData.row;
      const {name,observationStrategy,uniqueIdentifier,isActive,code} = formData.row;
      return {
        body:{
          Mdms:{
            ...row,
            isActive:isActive.name,
            data:{...row.data,observationStrategy,name,code:code.code},
            uniqueIdentifier
          }
        },
        params:{}
      }
    }
  }),[])

  return (
    <React.Fragment>
      <div>{counter}</div>
      <Header styles={{ fontSize: '32px' }}>{t(searchConfig?.label)}</Header>
      <div className="digit-inbox-search-wrapper">
        {/* Pass defaultValues as props to InboxSearchComposer */}
        <InboxSearchComposer
          configs={searchConfig}
          defaultValues={defaultValues}
          customizers={customizers}
        ></InboxSearchComposer>
      </div>
      {showPopup && (
        <PopUp
          type={'default'}
          heading={t('ES_CAMPAIGN_TIMELINE')}
          onOverlayClick={() => setShowPopup(false)}
          onClose={() => setShowPopup(false)}
        ></PopUp>
      )}
    </React.Fragment>
  );
};
export default IndividualSearch;
