import React from "react";
import SimpleComponent from "./SimpleComponent";

const TestComponent = (props, ref) => {
  return (
   <div>
    Test Component
    <SimpleComponent></SimpleComponent>
   </div>
  );
};

export default TestComponent;
