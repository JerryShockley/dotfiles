#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

root_dir=~
dir=$root_dir/dotfiles                    # dotfiles directory
olddir=$dir/dotfiles_old             # old dotfiles backup directory
files="gemrc zpreztorc vimrc vim zshrc zshenv zprofile gitignore tmux.conf mongorc.js"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -e "Creating '$olddir' for backup of any existing dotfiles in '$root_dir' \n"
mkdir -pv $olddir

# change to the dotfiles directory
echo -e "Changing to the $dir directory\n"
cd $dir

# move any existing dotfiles in $root_dir to $olddir directory, then create symlinks from the $root_dir to any files in the $dir directory specified in $files
echo -e $"Moving any existing dotfiles from $root_dir to $olddir\n"
for file in $files; do
    echo -e "Creating symlink for: $file"
    mv $root_dir/.$file $olddir/
    ln -fs $dir/$file $root_dir/.$file
done
echo "Symlinks successfully created!"
