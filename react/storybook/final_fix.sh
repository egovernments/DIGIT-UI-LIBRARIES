#!/bin/bash

# Fix all files that have orphaned Documentation functions and incomplete exports
for file in atoms/*.stories.js molecules/*.stories.js; do
  if [[ -f "$file" ]]; then
    # Check if the file has both orphaned function and incomplete export
    if grep -q "() => (" "$file" && grep -q "Documentation\." "$file"; then
      echo "Fixing $file"
      
      # Create a temporary file to store the fixed content
      temp_file=$(mktemp)
      
      # Extract the Documentation function
      doc_func=$(awk '/^\(\) => \(/{flag=1} flag{out=out $0 "\n"} /^\);$/{flag=0} END{print out}' "$file")
      
      # Extract the Documentation config
      doc_config=$(grep -A 20 "Documentation\." "$file" | awk '/Documentation\./{flag=1} flag{out=out $0 "\n"} /^};$/{flag=0; print out; exit}')
      
      if [[ -n "$doc_func" ]]; then
        # Remove orphaned function and config from file
        awk '
        /^\(\) => \(/{skip=1; next} 
        skip && /^\);$/{skip=0; next} 
        skip{next}
        /Documentation\./{skip2=1} 
        skip2 && /^};$/{skip2=0; next} 
        skip2{next}
        {print}
        ' "$file" > "$temp_file"
        
        # Add complete Documentation export at the end
        cat >> "$temp_file" <<EOF

export const Documentation = $doc_func

$doc_config
EOF
        
        mv "$temp_file" "$file"
      else
        rm "$temp_file"
      fi
    fi
  fi
done

echo "Completed fixing all story files"