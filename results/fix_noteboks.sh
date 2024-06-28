#!/bin/bash

# Navigate to the root directory of your project or the specific directory where the .ipynb_checkpoints folders are.
# Replace "/path/to/your/notebooks" with the actual path to your notebooks directory.
cd /project/scATAC_analysis/scATAcat_notebooks_for_paper/paper_github_repo/preprocessing

# Find all .ipynb_checkpoints directories in the project
find . -name ".ipynb_checkpoints" -type d | while read checkpoint_dir; do
    # Navigate into each .ipynb_checkpoints directory
    cd "$checkpoint_dir"
    
    # For each file in the .ipynb_checkpoints directory
    for file in *-checkpoint.*; do
        if [ -e "$file" ]; then  # Check if file exists to avoid errors
            # Construct new file name by removing "-checkpoint" suffix
            new_file_name=$(echo "$file" | sed 's/-checkpoint//g')
            # Move and rename the file to the parent directory
            mv "$file" "../$new_file_name"
        fi
    done
    
    # Go back to the root directory of your project
    cd - > /dev/null
    
    # Remove the now empty .ipynb_checkpoints directory
    rm -r "$checkpoint_dir"
done

echo "Files have been moved and renamed. Empty .ipynb_checkpoints directories have been removed."
