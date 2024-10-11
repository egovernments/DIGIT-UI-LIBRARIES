import { CustomSVG } from "../atoms/CustomSVG";
import * as MaterialIcons from '@mui/icons-material';

export const iconRender = (iconReq, iconFill, width, height, className) => {
  try {
    const components = require("@egovernments/digit-ui-svg-components");
    const DynamicIcon = components?.[iconReq];
    const svgIcon = CustomSVG?.[iconReq];
    const MaterialIcon = MaterialIcons[iconReq];

    if (DynamicIcon) {
      const svgElement = DynamicIcon({
        width: width,
        height: height,
        fill: iconFill,
        className: className,
      });
      return svgElement;
    } else if (svgIcon) {
      const svgElement = svgIcon({
        width: width,
        height: height,
        fill: iconFill,
        className: className,
      });
      return svgElement;
    }else if (MaterialIcon) {
      // Render Material-UI icon
      return <MaterialIcon color={iconFill} className={className} />;
    }
    else {
      console.error("Icon not found");
      return null;
    }
  } catch (error) {
    console.error("Icon not found");
    return null;
  }
};
