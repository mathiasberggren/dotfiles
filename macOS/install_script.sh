#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to the PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Read the list of formulae from a file
while read packages; do
   brew install "$packages"
done < brew_packages.txt

# Read the list of casks from a file
while read cask; do
   brew install --cask "$cask"
done < brew_casks.txt
