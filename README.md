# Dotfiles 

These files are configuration files used by various other software. These files
contain my configuration preferences, which may not be the same as your 
preferences. In addition to installing these configuration files, you must 
also install the various software applications to make use of them.

## Installation

With the exception of the Neovim configuration files, you can just put these files
in your $HOME directory. Neovim uses the [XDG Base Directory Standard](https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html)
to find it's configuration files.  The Neovim configuration files should be placed 
in the directory specified by the environment varible $XDG\_CONFIG\_HOME. If 
$XDG\_CONFIG\_HOME is undefined, the default path "$HOME/.config" should be used.

To install via git
```bash
$ cd $HOME
$ git clone https://github.com/JerryShockley/dotfiles.git
```
Now you will need to move the Neovim configuration files to their proper
location. Let's assume $XDG\_CONFIG\_HOME is undefined and the nvim directory
doesn't exist. If nvim does exist and already contains a init.vim file, that file
will be overwritten.
```bash
$ mkdir -p $HOME/.config/nvim
$ mv *.vim $HOME/.config/nvim
```

## Neovim configuration files

The default configuration file for Neovim is init.vim. I have 3 additional files 
that are sourced by init.vim to make managing the configuration easier as it's a 
lot of data for a single file. The file organization is as follows:

1. **init.vim** - This file is the entry point and contains all the Neovim settings.
1. **plugins.vim** - Leverages vim-plug to manage Neovim plugins. Able to bootstrap
the plugins by installing/configuring vim-plug and install the specified
plugins when vim-plug has not been previously installed. In addition to the 
specifying which plugins to install, it also contains all associated plugin options, key mappings, and code. 
1. **command.vim** - Contains all Ex commands and autocommands.
1. **key\_mappings.vim** - Contains all key mappings.


## Zsh and Prezto configuration files

Zsh is one of several alternative shells to bash. Prezto is one of several 
configuration frameworks for the zsh shell. If you do not use the zsh shell, 
the configuration files will have no effect on your system. If you use zsh and 
don't use Prezto, the Prezto configuration files will also have no effect on
your system if you remove the 4 lines in .zshrc that contain 'zprezto' in any
context.

1. **.zshrc** - zsh config file
1. **.zshenv** - zsh config file
1. **.zprofile** - zsh config file
1. **.zpreztorc** - Prezto config file

## Tmux configuration files

**.tmux.conf** - tmux is a terminal multiplexer. This config file will have
no effect on your system if you aren't using tmux.

## Gem configuration files

**.gemrc** - Gem is the Ruby package manager.

## Author
Created and maintained by Jerry Shockley.
