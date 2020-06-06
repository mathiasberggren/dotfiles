#! /bin/sh
apt-get install vim
apt-get install vscode
apt-get install git
apt-get install tldr
apt-get install 
apt-get install python3-dev

# vscode 
if ! hash code 2&>/dev/null; then
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
    sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
fi

#spotify
if ! hash spotify 2&>/dev/null; then
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 4773BD5E130D1D45
    add-apt-repository "deb http://repository.spotify.com stable non-free"
    apt install spotify-client
fi

