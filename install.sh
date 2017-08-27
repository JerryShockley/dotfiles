#!/bin/zsh
############################
# install.sh
# This script creates the directory ~/dotfiles/dotfiles_old and backs up all
# files affected by this script into the aforementioned directory
# unless it already exists in which case if skips the backup stage.
# This is because if you've previously run the script doing the
# initial backup all other changes should be saved in git.
#
# If you already have a ~/dotfiles directory insure you have committed any changes
# and pushed those changes. It then replaces any existing ~/.vim with the copy
# stored in ~/dotfiles. It creates symlinks in ~/ for all of the files listed in the
# variable files below. This way when you pull changes from the remote and check
# them out into the working directory any changes will take affect the next time
# the file is sourced.
#
# The Hack font in dotfiles/fonts will need to be added to
# to the Fontbook mac app so that it can be used within iTerm2 and vim.
#
# The color schemes in the dotfiles/iterm2 directory will need to be placed into
# your iterm2/schemes directory and then you will need press 'CMD-,' to bring
# up the preferences dialog and select the 'Text' tab and then select the
# 'Change font' button near the bottom of the dialog and select the
# Hack font and set the default size to suit your preferences. The
# in the bottom left click the 'Other Actions' drop-down list box and
# and click 'Set as default' to save the changes for future sessions.
############################

########## Variables

root_dir=~
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
