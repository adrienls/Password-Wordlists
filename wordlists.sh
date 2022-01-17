#!/bin/bash

# Exit when any command fails
set -e
# Keep track of the last executed command
trap 'last_command=$BASH_COMMAND' DEBUG
# Echo an error message before exiting
trap 'echo; echo "\"${last_command}\" command failed with exit code $?."' EXIT

DIRECTORY_NAME='./Password_Wordlist'
DIRECTORY_SEARCH='./SecLists/Passwords'

OUTPUT_FILE_NAME=("small_password_list.txt" "medium_password_list.txt" "medium_large_password_list.txt" "large_password_list.txt" "very_large_password_list.txt")
# For the very large password list the input file max size is not specified as every single password list is concatenate in one, whatever its size
INPUT_MAX_SIZE=("-size -6k" "-size -10k" "-size -100k" "-size -10M" "")

# https://opensource.com/article/19/10/remove-duplicate-lines-files-awk
# https://stackoverflow.com/questions/23740545/how-to-print-only-the-unique-lines-in-bash
AWK_UNIQUE_LINES='!visited[$0]++'

# Install required package
sudo apt update
sudo apt install --yes git

GITHUB_DIRECTORY="SecLists"
# Check if directory exists
if [[ -d "$GITHUB_DIRECTORY" ]]; then
  # Check if directory is empty
  if [[ -z "$(ls -A "$GITHUB_DIRECTORY")" ]]; then
    # Clone the SecLists repository with all the wordlists
    git clone https://github.com/danielmiessler/SecLists.git
  fi
else
  cd "$GITHUB_DIRECTORY"
  git pull
  cd ..
fi

# Create an output directory
mkdir -p "$DIRECTORY_NAME"

# Loop through different size of wordlists
for ((i = 0;  i < ${#OUTPUT_FILE[@]}; i++))
do
  # https://stackoverflow.com/questions/21854384/find-command-argument-iname-doesnt-work-from-variable
  # Exclude some useless directories, look only in valid files with the suffix *.txt
  # And print each line of each file in a new file after removing duplicate lines (awk pipe)
  find "$DIRECTORY_SEARCH" \
    -not \( -path "$DIRECTORY_SEARCH/Default-Credentials" -prune \) \
    -not \( -path "$DIRECTORY_SEARCH/Malware" -prune \) \
    -not \( -path "$DIRECTORY_SEARCH/Permutations" -prune \) \
    -not \( -iname "*withcount*" -prune \) \
    "${INPUT_MAX_SIZE[$i]}" \
    -type f \
    -name "*.txt" \
    -exec cat {} \; | awk "$AWK_UNIQUE_LINES" > "$DIRECTORY_NAME/$(( i+1 ))-${OUTPUT_FILE_NAME[$i]}"
done
