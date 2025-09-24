#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const glob = require('glob');

// Function to fix a story file
function fixStoryFile(filePath) {
  console.log(`Fixing ${filePath}...`);
  
  let content = fs.readFileSync(filePath, 'utf8');
  let modified = false;
  
  // Remove Iframe imports
  const oldContent = content;
  content = content.replace(/import\s+.*?Iframe.*?from\s+["']@egovernments\/digit-ui-components\/atoms["'];\s*\n?/g, '');
  if (content !== oldContent) {
    modified = true;
    console.log(`  Removed Iframe import from ${filePath}`);
  }
  
  // Fix broken Documentation exports with missing closing braces or syntax errors
  content = content.replace(
    /export const Documentation = createDocumentationStory\([^}]+\{\s*([^}]+)\s*\}\s*\)\s*;\s*$/gm,
    (match, argTypes) => {
      // Ensure proper closing
      const cleanArgTypes = argTypes.replace(/\s*$/, '');
      return `export const Documentation = createDocumentationStory("${getComponentName(filePath)}", "${getComponentType(filePath)}", {\n  ${cleanArgTypes}\n});`;
    }
  );
  
  // Fix incomplete Documentation exports
  content = content.replace(
    /export const Documentation = createDocumentationStory\([^;]+[^}]\s*;\s*$/gm,
    (match) => {
      // If there's an incomplete argTypes object, try to fix it
      if (match.includes('{') && !match.includes('}')) {
        // Find the opening brace and close it properly
        const componentName = getComponentName(filePath);
        const componentType = getComponentType(filePath);
        
        // Extract what's between the braces
        const braceIndex = match.indexOf('{');
        if (braceIndex > -1) {
          const argTypesPart = match.substring(braceIndex + 1).replace(/\s*;\s*$/, '').trim();
          if (argTypesPart.includes('table: { disable: true')) {
            // Fix the incomplete argTypes
            const fixedArgTypes = argTypesPart.replace(/table:\s*\{\s*disable:\s*true\s*$/, 'table: { disable: true } }');
            return `export const Documentation = createDocumentationStory("${componentName}", "${componentType}", {\n  ${fixedArgTypes}\n});`;
          }
        }
      }
      return match;
    }
  );
  
  if (modified || content !== fs.readFileSync(filePath, 'utf8')) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`  Fixed: ${filePath}`);
  }
}

// Helper functions
function getComponentName(filePath) {
  const fileName = path.basename(filePath, '.stories.js');
  return fileName.replace(/Docs$/, '');
}

function getComponentType(filePath) {
  return filePath.includes('/atoms/') ? 'atoms' : 'molecules';
}

// Find all story files that need fixing
const storyFiles = [
  ...glob.sync('atoms/*.stories.js'),
  ...glob.sync('molecules/*.stories.js')
];

console.log(`Found ${storyFiles.length} story files to fix...\n`);

// Process each file
storyFiles.forEach(fixStoryFile);

console.log('\n✅ Documentation fix completed!');