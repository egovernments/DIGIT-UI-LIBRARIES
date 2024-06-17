import React,{Children} from "react";
import { Timeline } from "../atoms";

const TimelineMolecule = ({ children }) => {
  return (
    <div className="digit-timeline-molecule">
      {Children.map(children, (child, index) => (
        <Timeline {...child.props} isLastStep={index === Children.count(children) - 1} />
      ))}
    </div>
  );
};

export default TimelineMolecule;
