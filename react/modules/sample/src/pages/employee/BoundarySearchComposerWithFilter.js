import React from "react";
import { InboxSearchComposer, Loader } from "@egovernments/digit-ui-components";
import boundarySearchWithFilterConfig from "../../configs/boundarySCFIlterConfig";

const BoundarySearchComposerWithFilter = () => {
    const config = boundarySearchWithFilterConfig();

    if(!config)  return <Loader variant={"PageLoader"}/>
    return (
        <React.Fragment>
            <div className="digit-inbox-search-wrapper">
                <InboxSearchComposer configs={config}></InboxSearchComposer>
            </div>
        </React.Fragment>
    )
}

export default BoundarySearchComposerWithFilter;