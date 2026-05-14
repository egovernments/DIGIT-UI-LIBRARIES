import React from "react";
import PropTypes from "prop-types";
import { COLOR_FILL } from "./constants";

export const Devices = ({ className, height = "36", width = "45", style = {}, fill = COLOR_FILL, onClick = null }) => {
  return (
    <svg width={width} height={height} className={className} onClick={onClick} style={style} viewBox="0 0 45 36" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path
        d="M0 35.9993V31.4994H22.4995V35.9993H0ZM6.74984 29.2494C5.51234 29.2494 4.45303 28.8088 3.5718 27.9276C2.69057 27.0463 2.24995 25.987 2.24995 24.7495V4.49988C2.24995 3.26248 2.69057 2.20308 3.5718 1.32188C4.45303 0.440609 5.51234 0 6.74984 0H38.2492C39.4867 0 40.546 0.440609 41.4272 1.32188C42.3085 2.20308 42.7491 3.26248 42.7491 4.49988H6.74984V24.7495H22.4995V29.2494H6.74984ZM40.4991 31.4994V13.4997H31.4993V31.4994H40.4991ZM30.3743 35.9993C29.4369 35.9993 28.64 35.6712 27.9838 35.0149C27.3275 34.3587 26.9994 33.5618 26.9994 32.6244V12.3748C26.9994 11.4373 27.3275 10.6404 27.9838 9.98418C28.64 9.32798 29.4369 8.99978 30.3743 8.99978H41.6241C42.5616 8.99978 43.3585 9.32798 44.0147 9.98418C44.6709 10.6404 44.999 11.4373 44.999 12.3748V32.6244C44.999 33.5618 44.6709 34.3587 44.0147 35.0149C43.3585 35.6712 42.5616 35.9993 41.6241 35.9993H30.3743ZM35.9992 19.1246C36.4867 19.1246 36.8898 18.9559 37.2086 18.6184C37.5273 18.2809 37.6867 17.8872 37.6867 17.4372C37.6867 16.9497 37.5273 16.5466 37.2086 16.2278C36.8898 15.9091 36.4867 15.7497 35.9992 15.7497C35.5492 15.7497 35.1555 15.9091 34.818 16.2278C34.4805 16.5466 34.3118 16.9497 34.3118 17.4372C34.3118 17.8872 34.4805 18.2809 34.818 18.6184C35.1555 18.9559 35.5492 19.1246 35.9992 19.1246Z"
        fill={fill}
      />
    </svg>
  );
};


Devices.propTypes = {
  /** custom width of the svg icon */
  width: PropTypes.string,
  /** custom height of the svg icon */
  height: PropTypes.string,
  /** custom colour of the svg icon */
  fill: PropTypes.string,
  /** custom class of the svg icon */
  className: PropTypes.string,
  /** custom style of the svg icon */
  style: PropTypes.object,
  /** Click Event handler when icon is clicked */
  onClick: PropTypes.func,
};