import { InboxSearchComposer } from "@egovernments/digit-ui-components";
import React from "react";
import { Config } from "../../configs/boundarySeachComposerConfig";

const BoundarySearchComposer = () => {

  return (
    <React.Fragment>
      <div className="digit-inbox-search-wrapper">
        <InboxSearchComposer configs={Config}></InboxSearchComposer>
      </div>
    </React.Fragment>
  );
};
export default BoundarySearchComposer;
