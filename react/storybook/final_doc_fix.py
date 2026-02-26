#!/usr/bin/env python3
import os
import re
import glob

def fix_documentation_story(file_path):
    """Fix all Documentation-related issues in a story file."""
    with open(file_path, 'r') as f:
        content = f.read()
    
    # Check if file has incomplete Documentation export at the end
    if not content.rstrip().endswith('export const Documentation ='):
        return False, "No incomplete Documentation export"
    
    # Pattern to find orphaned Documentation function
    doc_func_pattern = r'\(\) => \(\s*<Iframe[^>]*>[^<]*</Iframe>\s*\);'
    doc_func_match = re.search(doc_func_pattern, content, re.DOTALL)
    
    # Pattern to find orphaned Documentation config
    doc_config_pattern = r'Documentation\.(storyName|argTypes)[^}]*?};'
    doc_config_matches = re.findall(doc_config_pattern, content, re.DOTALL)
    
    if not doc_func_match:
        return False, "No Documentation function found"
    
    doc_function = doc_func_match.group(0)
    
    # Collect all Documentation configuration
    doc_configs = []
    for match in re.finditer(doc_config_pattern, content, re.DOTALL):
        doc_configs.append(match.group(0))
    
    # Remove incomplete export at the end
    content = content.rstrip()
    if content.endswith('export const Documentation ='):
        content = content[:-len('export const Documentation =')].rstrip()
    
    # Remove orphaned function
    content = content.replace(doc_function, '')
    
    # Remove orphaned configs
    for config in doc_configs:
        content = content.replace(config, '')
    
    # Clean up extra newlines
    content = re.sub(r'\n{3,}', '\n\n', content)
    content = content.rstrip()
    
    # Build complete Documentation export
    complete_doc = f"\n\nexport const Documentation = {doc_function}"
    
    if doc_configs:
        complete_doc += "\n\n" + "\n".join(doc_configs)
    
    content = content + complete_doc + '\n'
    
    # Write back
    with open(file_path, 'w') as f:
        f.write(content)
    
    return True, "Fixed Documentation export"

def main():
    # Get all story files with incomplete Documentation exports
    files_to_fix = []
    for pattern in ['atoms/*.stories.js', 'molecules/*.stories.js']:
        for file_path in glob.glob(pattern):
            with open(file_path, 'r') as f:
                content = f.read()
                if content.rstrip().endswith('export const Documentation ='):
                    files_to_fix.append(file_path)
    
    print(f"Found {len(files_to_fix)} files with incomplete Documentation exports\n")
    
    fixed = 0
    errors = 0
    
    for file_path in sorted(files_to_fix):
        success, message = fix_documentation_story(file_path)
        if success:
            print(f"✓ Fixed: {file_path}")
            fixed += 1
        else:
            print(f"✗ Error: {file_path} - {message}")
            errors += 1
    
    print(f"\nSummary:")
    print(f"  Fixed: {fixed}")
    print(f"  Errors: {errors}")

if __name__ == "__main__":
    main()