#! /bin/sh

#List of programs to install
list="code vim git tldr python3-dev spotify-client nodejs npm"

# Add repositories not present by standard

    # Get newest git repo to get Restore and Switch
    add-apt-repository ppa:git-core/ppa

    ## vscode 
    if ! hash code 2>/dev/null; then
        curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
        sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
        apt-get install apt-transport-https
    fi

    ## spotify
    if ! hash spotify 2>/dev/null; then
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 4773BD5E130D1D45
        add-apt-repository "deb http://repository.spotify.com stable non-free"
    fi


apt-get update
apt-get install -y ${list}
# install tldr from npm
npm install -g tldr
apt-get update
