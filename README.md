# Dotfiles (Ingo Kleiber)

This a basic set of dotfiles which I use to set up a basic (Linux) system. The installer isn't particularly advanced, but it works in most cases.
The dotfiles themselves are kept very simple as I like to modify them further for each individual system.

## Installation

### Linux

```
git clone https://github.com/IngoKl/dotfiles.git
cd dotfiles
./install_linux.sh

```

#### ZSH Quick Fix

When using `zsh` (e.g., on *Kali*), most aliases/tools can still be used. 
To do so, add the following lines (assuming you cloned into your home folder) to your `~/.zshrc`.

```bash
source $HOME/dotfiles/.bashrc_pentesting
source $HOME/dotfiles/.bashrc_misc
source $HOME/dotfiles/.bash_aliases
```

### Windows 10

```
git clone https://github.com/IngoKl/dotfiles.git
cd dotfiles
install_windows.bat

```

## Scripts

The `scripts` folder contains some (fairly random) scripts.

## To Do

* Link/Use (bash) aliases in a new `.zshrc`.
* Add more of my scripts and create an alias file for them
