import React from "react";
import { useTranslation } from "react-i18next";
import { HeaderComponent } from "../../../../ui-components/src/atoms";

const SearchCard = ({ data }) => {
  const { t } = useTranslation();
  console.log("column", data);

  return (
    <div style={{ width: '100%', margin: 0, padding: 0 }}>
      <div className="flex justify-between">
        <div>
          <HeaderComponent>
            {t(data?.schemaCode)}
          </HeaderComponent>
          <p>Start: </p>
          <p>End: </p>
        </div>
        <div className="text-right">
          <p>Status: </p>
          <button className="bg-orange-600 text-white px-3 py-1 rounded mt-2">
            Edit
          </button>
        </div>
      </div>
    </div>
  );
};

export default SearchCard;
