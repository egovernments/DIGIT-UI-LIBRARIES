  import React from "react";
  import PropTypes from "prop-types";
  import { COLOR_FILL } from "./constants";

  export const ServicePreviewIcon = ({ className, height = "48", width = "48", style = {}, viewBox = "0 0 48 48", fill = COLOR_FILL, onClick = null }) => {
    return (
      <svg width={width} height={height} className={className} viewBox={viewBox} onClick={onClick} style={style} fill="none" xmlns="http://www.w3.org/2000/svg">
        <mask id="mask_service_preview" style={{ maskType: "alpha" }} maskUnits="userSpaceOnUse" x="0" y="0" width="48" height="48">
          <rect width="48" height="48" fill="#D9D9D9" />
        </mask>
        <g mask="url(#mask_service_preview)">
          <path d="M3.99805 40V36H23.998V40H3.99805ZM9.99805 34C8.89805 34 7.95638 33.6083 7.17305 32.825C6.38971 32.0417 5.99805 31.1 5.99805 30V12C5.99805 10.9 6.38971 9.95833 7.17305 9.175C7.95638 
  8.39167 8.89805 8 9.99805 8H37.998C39.098 8 40.0397 8.39167 40.823 9.175C41.6064 9.95833 41.998 10.9 41.998 12H9.99805V30H23.998V34H9.99805ZM39.998 36V20H31.998V36H39.998ZM30.998 40C30.1647 40 29.4564 
  39.7083 28.873 39.125C28.2897 38.5417 27.998 37.8333 27.998 37V19C27.998 18.1667 28.2897 17.4583 28.873 16.875C29.4564 16.2917 30.1647 16 30.998 16H40.998C41.8314 16 42.5397 16.2917 43.123 
  16.875C43.7064 17.4583 43.998 18.1667 43.998 19V37C43.998 37.8333 43.7064 38.5417 43.123 39.125C42.5397 39.7083 41.8314 40 40.998 40H30.998ZM35.998 25C36.4314 25 36.7897 24.85 37.073 24.55C37.3564 24.25
   37.498 23.9 37.498 23.5C37.498 23.0667 37.3564 22.7083 37.073 22.425C36.7897 22.1417 36.4314 22 35.998 22C35.598 22 35.248 22.1417 34.948 22.425C34.648 22.7083 34.498 23.0667 34.498 23.5C34.498 23.9 
  34.648 24.25 34.948 24.55C35.248 24.85 35.598 25 35.998 25Z" fill={fill} />
        </g>
      </svg>
    );
  };

  ServicePreviewIcon.propTypes = {
    width: PropTypes.string,
    height: PropTypes.string,
    viewBox: PropTypes.string,
    fill: PropTypes.string,
    className: PropTypes.string,
    style: PropTypes.object,
    onClick: PropTypes.func,
  };
