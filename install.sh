#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

root_dir=~/testenv
dir=$root_dir/dotfiles                    # dotfiles directory
olddir=$dir/dotfiles_old             # old dotfiles backup directory
iterm2dir=iterm2/schemes
dir_exists=false
files="gemrc zpreztorc vimrc zshrc zshenv zprofile gitignore tmux.conf mongorc.js"    # list of files/folders to symlink in homedir

##########

if [ -d "$olddir" ]; then
    echo -e "\n$olddir already exists. Terminating backup into this directory\n"
    dir_exists=true
else
        # create dotfiles_old in homedir
    echo -e "\nCreating '$olddir' for backup of any existing dotfiles in '$root_dir' \n"
    mkdir -pv $olddir
fi

# change to the dotfiles directory
cd $dir

# move any existing dotfiles in $root_dir to $olddir directory, then create symlinks from the $root_dir to any files in the $dir directory specified in $files
echo -e "\nMoving any existing dotfiles from $root_dir to $olddir\n"
for file in $files; do
    echo -e "Creating symlink for: $file"

if [ $dir_exists == "false" ]; then
    mv -n $root_dir/.$file $olddir/
fi
    ln -fs $dir/$file $root_dir/.$file
done

echo -e "\nCopying ~/.vim to $olddir\n"
rsync -av --exclude "plugged"  $root_dir/.vim/ $olddir/vim
rm -rf $root_dir/.vim
echo "\nCopying iTerm2 color schemes to ~/iterm2/schemes\n"
cp -v $dir/$iterm2dir/* $root_dir/$iterm2dir/
echo -e "\nCopying vim custom files to $root_dir/.vim\n"
cp -vRf $dir/vim $root_dir/.vim/
