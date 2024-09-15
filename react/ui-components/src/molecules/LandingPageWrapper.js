import React, { useEffect, useRef, useState } from "react";
import PropTypes from "prop-types";

const LandingPageWrapper = ({ children, className, styles }) => {
  const wrapperRef = useRef(null);
  const [maxWidth, setMaxWidth] = useState(0);
  const [maxHeight, setMaxHeight] = useState(0);

  useEffect(() => {
    if (wrapperRef.current) {
      // Get all child card elements
      const cardElements = Array.from(wrapperRef.current.children);

      // Calculate the maximum width of the cards
      const maxCardWidth = Math.max(
        ...cardElements.map((child) => child.getBoundingClientRect().width)
      );

      // Calculate the maximum height of the cards
      const maxCardHeight = Math.max(
        ...cardElements.map((child) => child.getBoundingClientRect().height)
      );

      // Set the maximum width to the state
      setMaxWidth(maxCardWidth);

      // Set the maximum height to the state
      setMaxHeight(maxCardHeight);
    }
  }, [children]); // Recalculate when children change

  return (
    <div
      className={`digit-landing-page-wrapper ${className}`}
      style={styles}
      ref={wrapperRef}
    >
      {React.Children.map(children, (child) =>
        React.cloneElement(child, {
          style: {
            ...child.props.style,
            width: `${maxWidth}px`,
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
