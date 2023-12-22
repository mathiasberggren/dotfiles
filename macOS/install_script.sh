#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Read the list of formulae from a file
while read formula; do
   brew install "$formula"
done < formulae.txt

# Read the list of casks from a file
while read cask; do
   brew install --cask "$cask"
done < casks.txt
