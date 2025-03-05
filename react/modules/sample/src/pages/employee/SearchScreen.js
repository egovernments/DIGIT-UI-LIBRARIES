import React from 'react'
import searchConfig from '../../configs/SearchConfig';
import { InboxSearchComposer } from '@egovernments/digit-ui-components';

const SearchScreen = () => {
  const config=searchConfig;
  return (
    <div>
        <InboxSearchComposer configs={config}/>
    </div>
  )
}

export default SearchScreen