#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to the PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Read the list of packages from a file and install each one individually
while IFS= read -r package; do
    for attempt in {1..3}; do
        if brew install "$package"; then
            break
        elif [[ $attempt -eq 3 ]]; then
            echo "Failed to install $package after $attempt attempts"
            exit 1
        fi
        sleep 5  # wait for 5 seconds before retrying
    done
done < brew_packages.txt

# Read the list of casks from a file and install each one individually
while IFS= read -r cask; do
    brew install --cask "$cask"
done < brew_casks.txt

