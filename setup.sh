#! /bin/bash

this_dir=$(pwd)"/"
home_dir=/$(echo $this_dir | cut -d '/' -f 2,3)

bash_alias_this_dir=$this_dir.bash_aliases
vimrc_this_dir=$this_dir.vimrc
bashrc_this_dir=$this_dir.bashrc

mv $bash_alias_this_dir $vimrc_this_dir $bashrc_this_dir $home_dir
ln ${home_dir}/.vimrc $this_dir
ln ${home_dir}/.bash_aliases $this_dir
ln ${home_dir}/.bashrc $this_dir

sudo bash ./install_script.sh
