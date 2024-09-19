import React, { useEffect, useRef, useState } from "react";
import PropTypes from "prop-types";

const LandingPageWrapper = ({ children, className, styles }) => {
  const wrapperRef = useRef(null);
  const [isMobileView, setIsMobileView] = React.useState(
    window.innerWidth / window.innerHeight <= 9 / 16
  );
  const onResize = () => {
    if (window.innerWidth / window.innerHeight <= 9 / 16) {
      if (!isMobileView) {
        setIsMobileView(true);
      }
    } else {
      if (isMobileView) {
        setIsMobileView(false);
      }
    }
  };
  React.useEffect(() => {
    window.addEventListener("resize", () => {
      onResize();
    });
    return () => {
      window.addEventListener("resize", () => {
        onResize();
      });
    };
  });
  const [maxWidth, setMaxWidth] = useState(0);
  const [maxHeight, setMaxHeight] = useState(0);

  useEffect(() => {
    if (wrapperRef.current) {
      // Getting all child card elements
      const cardElements = Array.from(wrapperRef.current.children);

      // Calculating the maximum width of the cards
      const maxCardWidth = Math.max(
        ...cardElements.map((child) => child.getBoundingClientRect().width)
      );

      // Calculating the maximum height of the cards
      const maxCardHeight = Math.max(
        ...cardElements.map((child) => child.getBoundingClientRect().height)
      );

      // Setting the maximum width to the state
      setMaxWidth(maxCardWidth);

      // Setting the maximum height to the state
      setMaxHeight(maxCardHeight);
    }
  }, [children]); // Recalculating when children change

  return (
    <div
      className={`digit-landing-page-wrapper ${className} ${isMobileView ? "mobile" : ""}`}
      style={styles}
      ref={wrapperRef}
    >
      {React.Children.map(children, (child) =>
        React.cloneElement(child, {
          style: {
            ...child.props.style,
            width: !isMobileView ? `${maxWidth}px` : "100%",
            height: `${maxHeight}px`,
          },
        })
      )}
    </div>
  );
};

LandingPageWrapper.propTypes = {
  children: PropTypes.node.isRequired,
  className: PropTypes.string,
  styles: PropTypes.object,
};

LandingPageWrapper.defaultProps = {
  className: "",
  styles: {},
};

export default LandingPageWrapper;
