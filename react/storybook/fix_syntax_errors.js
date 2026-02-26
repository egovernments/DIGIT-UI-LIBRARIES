#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

// List of files with syntax errors
const brokenFiles = [
  'atoms/Switch.stories.js',
  'atoms/SelectionTag.stories.js',
  'atoms/BackLink.stories.js',
  'atoms/Stepper.stories.js',
  'atoms/TextBlock.stories.js',
  'atoms/TextInput.stories.js',
  'atoms/Dropdown.stories.js',
  'atoms/CheckBox.stories.js',
  'atoms/Tag.stories.js',
  'atoms/BreadCrumb.stories.js',
  'atoms/Tab.stories.js',
  'atoms/AlertCard.stories.js',
  'atoms/Loader.stories.js',
  'atoms/RadioButtons.stories.js',
  'atoms/ActionButton.stories.js',
  'atoms/Chip.stories.js',
  'atoms/MultiselectDropdown.stories.js',
  'atoms/Toggle.stories.js',
  'atoms/Timeline.stories.js'
];

function fixSyntaxErrors(filePath) {
  console.log(`Fixing ${filePath}...`);
  
  let content = fs.readFileSync(filePath, 'utf8');
  const componentName = path.basename(filePath, '.stories.js');
  const componentType = filePath.includes('/atoms/') ? 'atoms' : 'molecules';
  
  // Fix duplicate createDocumentationStory calls and syntax errors
  content = content.replace(
    /export const Documentation = createDocumentationStory\(createDocumentationStory\("([^"]+)", "atoms"\);/g,
    'export const Documentation = createDocumentationStory("$1", "atoms");'
  );
  
  content = content.replace(
    /export const Documentation = createDocumentationStory\(createDocumentationStory\("([^"]+)", "molecules"\);/g,
    'export const Documentation = createDocumentationStory("$1", "molecules");'
  );
  
  // Fix any malformed exports at the end of files
  content = content.replace(
    / No newline at end of file\nexport const Documentation = createDocumentationStory.*$/g,
    ''
  );
  
  // Add proper Documentation export if missing
  if (!content.includes('export const Documentation = createDocumentationStory(')) {
    content += `\nexport const Documentation = createDocumentationStory("${componentName}", "${componentType}");\n`;
  }
  
  // Clean up multiple "No newline at end of file" messages
  content = content.replace(/ No newline at end of file/g, '');
  
  // Ensure proper ending
  if (!content.endsWith('\n')) {
    content += '\n';
  }
  
  fs.writeFileSync(filePath, content, 'utf8');
  console.log(`  Fixed: ${filePath}`);
}

// Fix all broken files
brokenFiles.forEach(fixSyntaxErrors);

console.log('\n✅ All syntax errors fixed!');