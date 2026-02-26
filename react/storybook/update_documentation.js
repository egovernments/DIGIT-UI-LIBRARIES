#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const glob = require('glob');

// Function to extract component name from file path
function getComponentName(filePath) {
  const fileName = path.basename(filePath, '.stories.js');
  // Handle special cases like ButtonDocs -> Button, PanelDocs -> Panel, etc.
  return fileName.replace(/Docs$/, '');
}

// Function to get component type (atoms or molecules) from file path
function getComponentType(filePath) {
  return filePath.includes('/atoms/') ? 'atoms' : 'molecules';
}

// Function to extract existing argTypes from Documentation story
function extractArgTypes(content) {
  const argTypesMatch = content.match(/Documentation\.argTypes\s*=\s*{([^}]+(?:{[^}]*}[^}]*)*)}/s);
  if (!argTypesMatch) return '';
  
  return argTypesMatch[1].trim();
}

// Function to update a story file
function updateStoryFile(filePath) {
  console.log(`Processing ${filePath}...`);
  
  let content = fs.readFileSync(filePath, 'utf8');
  
  // Skip if already using the new Documentation component
  if (content.includes('createDocumentationStory')) {
    console.log(`  Already updated: ${filePath}`);
    return;
  }
  
  // Skip if no Documentation export found
  if (!content.includes('export const Documentation')) {
    console.log(`  No Documentation export found: ${filePath}`);
    return;
  }
  
  const componentName = getComponentName(filePath);
  const componentType = getComponentType(filePath);
  
  // Extract existing argTypes
  const argTypes = extractArgTypes(content);
  
  // Update imports - remove Iframe import and add createDocumentationStory import
  content = content.replace(
    /import\s+(?:.*?Iframe.*?from\s+["']@egovernments\/digit-ui-components\/atoms["'];?\s*)/g, 
    ''
  );
  
  // Add the new import after existing imports
  const lastImportMatch = content.match(/import[^;]+;(?=\s*\n(?:\s*\n)*export)/);
  if (lastImportMatch) {
    const insertPos = lastImportMatch.index + lastImportMatch[0].length;
    const newImport = '\nimport { createDocumentationStory } from "../.storybook/DocumentationComponent";';
    content = content.slice(0, insertPos) + newImport + content.slice(insertPos);
  }
  
  // Replace the Documentation export
  const docExportRegex = /export const Documentation = \(\) => \(\s*<Iframe[\s\S]*?\/>\s*\);\s*Documentation\.storyName = ["'][^"']*["'];\s*Documentation\.argTypes = {[\s\S]*?};/;
  
  const newDocExport = argTypes 
    ? `export const Documentation = createDocumentationStory("${componentName}", "${componentType}", {\n  ${argTypes}\n});`
    : `export const Documentation = createDocumentationStory("${componentName}", "${componentType}");`;
  
  content = content.replace(docExportRegex, newDocExport);
  
  // Write the updated content back to the file
  fs.writeFileSync(filePath, content, 'utf8');
  console.log(`  Updated: ${filePath}`);
}

// Find all story files
const storyFiles = [
  ...glob.sync('atoms/*.stories.js'),
  ...glob.sync('molecules/*.stories.js')
];

console.log(`Found ${storyFiles.length} story files to process...\n`);

// Process each file
storyFiles.forEach(updateStoryFile);

console.log('\n✅ Documentation component update completed!');