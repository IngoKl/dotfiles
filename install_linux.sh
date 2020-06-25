# This script installs the new dotfiles. While everything could be looped,
# I decided to do everything individually to keep things as transparent
# as possible.


dotfiles=~/dotfiles
dotfiles_b=$dotfiles/backup

# Move current files out of the way
mkdir $dotfiles_b

sudo mv ~/.config/nvim $dotfiles_b
sudo mv ~/.bashrc $dotfiles_b
sudo mv ~/.bash_aliases $dotfiles_b

# Create symlinks
ln -sf $dotfiles/.config/nvim ~/.config/nvim
ln -sf $dotfiles/.bashrc ~/.bashrc
ln -sf $dotfiles/.bash_aliases ~/.bash_aliases
ln -sf $dotfiles/.bashrc_misc ~/.bashrc_misc
