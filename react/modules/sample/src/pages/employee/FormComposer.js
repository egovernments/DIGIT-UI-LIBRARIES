import { CloseSvg, DateRangeNew, FilterIcon, RefreshIcon } from "@egovernments/digit-ui-react-components";
import { FormComposerV2 } from "@egovernments/digit-ui-components";

import React from 'react';
import { useTranslation } from "react-i18next";


const FormComposer = () => {
    const {t}=useTranslation();
    const configs = [
        {
          head: "",
          body: [
            {
              type: "custom",
              isMandatory: false,
              withoutLabel: true,
              populators: {
                name: "musterRolldateRange",
                customProps: { t, optionKey: "i18nKey" },
              },
            },
          ],
        },
      ];
  return (
    <div>
        <FormComposerV2 configs={configs}/>
    </div>
  )
}

export default FormComposer