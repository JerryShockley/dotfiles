#!/bin/zsh
############################
# link-dotfiles.sh
# This script creates symlinks from the home directory to any corresponding dotfiles in ~/dotfiles
############################

########## Variables

root_dir=~
dir=$root_dir/dotfiles                    # dotfiles directory
files="gemrc zpreztorc vimrc zshrc zshenv zprofile gitignore tmux.conf mongorc.js"    # list of files/folders to symlink in homedir

##########

# change to the dotfiles directory
cd $dir

for file in $files; do
    echo -e "Creating symlink for: $file"

    ln -fs $dir/$file $root_dir/.$file
done

