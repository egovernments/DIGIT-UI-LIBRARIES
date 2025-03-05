import React from 'react'
import searchConfig1 from '../../configs/SearchConfig';
import { InboxSearchComposer } from '@egovernments/digit-ui-components';

const SearchScreen1 = () => {
  const config=searchConfig1;
  return (
    <div>
        <InboxSearchComposer configs={config}/>
    </div>
  )
}

export default SearchScreen1