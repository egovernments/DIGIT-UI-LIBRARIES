import React, { Children, useState } from "react";
import { Timeline, Button, StringManipulator } from "../atoms";

const sortTimelines = (children) => {
  const variantsOrder = {
    upcoming: 1,
    inprogress: 2,
    completed: 3,
  };

  return Children.toArray(children).sort((a, b) => {
    const variantA = variantsOrder[a.props.variant] || 4;
    const variantB = variantsOrder[b.props.variant] || 4;
    return variantA - variantB;
  });
};

const TimelineMolecule = ({ children, initialVisibleCount, viewMoreLabel,viewLessLabel }) => {
  const sortedChildren = sortTimelines(children);

  const [visibleCount, setVisibleCount] = useState(initialVisibleCount);
  const [isExpanded, setIsExpanded] = useState(false);


  const toggleViewMoreItems = () => {
    if (isExpanded) {
      setVisibleCount(initialVisibleCount);
    } else {
      setVisibleCount(sortedChildren.length);
    }
    setIsExpanded(!isExpanded);
  };

  let currentActiveStep = -1;
  sortedChildren.forEach((child, index) => {
    console.log(child.props, "child ");
    if (child.props.variant === "inprogress") {
      currentActiveStep = index;
    }
  });

  const visibleChildren = sortedChildren.slice(0, visibleCount);
  

  return (
    <div className="digit-timeline-molecule">
      {Children.map(visibleChildren, (child, index) => (
        <Timeline
          {...child.props}
          isLastStep={index === Children.count(visibleChildren) - 1}
          isNextActiveStep={currentActiveStep - 1 === index}
        />
      ))}
      {initialVisibleCount && (
        <div className="view-more-container">
          <Button
            isSuffix={true}
            icon={isExpanded ? "ArrowDropUp" : "ArrowDropDown"}
            variation={"teritiary"}
            onClick={toggleViewMoreItems}
            label = {isExpanded ? (StringManipulator("CAPITALIZEFIRSTLETTER", viewLessLabel) || "View Less") : (StringManipulator("CAPITALIZEFIRSTLETTER", viewMoreLabel) || "View More")}
            size={"medium"}
          ></Button>
        </div>
      )}
    </div>
  );
};

export default TimelineMolecule;
