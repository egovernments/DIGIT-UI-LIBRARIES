import { Header } from '@egovernments/digit-ui-react-components';
import React, { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { InboxSearchComposer, PopUp } from '@egovernments/digit-ui-components';
import { searchconfig } from '../../configs/IndividualSearchCOnfig';

const defaultSearchValues = {
  individualName: '',
  mobileNumber: '',
  IndividualID: '',
};

const IndividualSearch = () => {
  const { t } = useTranslation();
  const [defaultValues, setDefaultValues] = useState(defaultSearchValues); // State to hold default values for search fields
  const indConfigs = searchconfig();
  const [counter, updateCounter] = useState(0);
  const [showPopup, setShowPopup] = useState(false);

  useEffect(() => {
    // Set default values when component mounts
    setDefaultValues(defaultSearchValues);
  }, []);

  const customizers = {
    preProcess: (data) => {
      delete data.params.tenantId;
      delete data.params.limit;
      delete data.params.offset;
      delete data.body.apiOperation;
      delete data.body.Individual;
      data.body.MdmsCriteria = {
        tenantId: 'dev',
        filters: {},
        schemaCode: 'ACCESSCONTROL-ACTIONS-TEST.actions-test',
        limit: 10,
        offset: 0,
      };
      return data;
    },
    additionalCustomizations: (row, key, column, value, t, searchResult) => {
      //here we can add multiple conditions
      //like if a cell is link then we return link
      //first we can identify which column it belongs to then we can return relevant result
      switch (key) {
        case 'IndividualID':
          return (
            <button onClick={() => updateCounter((prev) => {
              console.log("cliked")
              return prev + 1
            })}>
              {`Update State ${value}`} 
            </button>
          );
        case 'Name':
          return (
            <button onClick={() => setShowPopup(true)}>
              Show Popups
            </button>
          );
        default:
          return t('ES_COMMON_NA');
      }
    },
  };

  return (
    <React.Fragment>
      <div>{counter}</div>
      <Header styles={{ fontSize: '32px' }}>{t(indConfigs?.label)}</Header>
      <div className="digit-inbox-search-wrapper">
        {/* Pass defaultValues as props to InboxSearchComposer */}
        <InboxSearchComposer
          configs={indConfigs}
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
