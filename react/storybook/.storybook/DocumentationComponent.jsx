import React from "react";
import { Iframe } from "@egovernments/digit-ui-components/atoms";

/**
 * Reusable Documentation component for Storybook
 * Automatically generates the correct documentation URL based on component type and name
 * 
 * @param {Object} props - Component props
 * @param {string} props.componentName - The name of the component (e.g., "Accordion", "Button")
 * @param {string} props.componentType - The type of component ("atoms" or "molecules")
 * @param {string} [props.title] - Optional custom title for the iframe
 */
export const DocumentationComponent = ({ 
  componentName, 
  componentType = "atoms", 
  title 
}) => {
  // Convert component name to lowercase and kebab-case for URL
  const urlComponentName = componentName;
    // .replace(/([A-Z])/g, '-$1')
    // .toLowerCase()
    // .replace(/^-/, '');
  
  // Convert component type to singular for URL (atoms -> atom, molecules -> molecule)
  const urlComponentType = componentType === "atoms" ? "atom" : "molecule";
  
  // Generate the documentation URL
  const baseUrl = "https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui-components0.2.0";
  const documentationUrl = `${baseUrl}/${urlComponentType}/${urlComponentName}`;
  
  // Generate the iframe title
  const iframeTitle = title || `${componentName} Documentation`;
  
  return (
    <Iframe
      src={documentationUrl}
      title={iframeTitle}
       onLoad={(e) => {
    const iframeDoc = e.target.contentDocument || e.target.contentWindow.document;
    if (iframeDoc) {
      const style = iframeDoc.createElement("style");
      style.innerHTML = `
        header, nav, aside { display: none !important; }
        main { margin: 0 !important; }
      `;
      iframeDoc.head.appendChild(style);
    }
  }}
    />
  );
};

/**
 * Higher-order function to create a Documentation story export
 * 
 * @param {string} componentName - The name of the component
 * @param {string} componentType - The type of component ("atoms" or "molecules")
 * @param {Object} argTypes - Optional argTypes to disable in the Documentation story
 * @returns {Function} - The Documentation story function
 */
export const createDocumentationStory = (componentName, componentType = "atoms", argTypes = {}) => {
  const DocumentationStory = () => (
    <DocumentationComponent 
      componentName={componentName}
      componentType={componentType}
    />
  );
  
  DocumentationStory.storyName = "Detailed Props Definition";
  DocumentationStory.argTypes = {
    ...argTypes,
    // Disable all controls in documentation view by default
    ...Object.keys(argTypes).reduce((acc, key) => ({
      ...acc,
      [key]: { table: { disable: true } }
    }), {})
  };
  
  return DocumentationStory;
};

export default DocumentationComponent;