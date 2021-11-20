# This script installs the new dotfiles. While everything could be looped,
# I decided to do everything individually to keep things as transparent
# as possible.

dotfiles=~/dotfiles
dotfiles_b=$dotfiles/backup

# Move current files out of the way
mkdir $dotfiles_b

sudo mv ~/.config/nvim/init.vim $dotfiles_b/.config/nvim/init.vim
sudo mv ~/.bashrc $dotfiles_b
sudo mv ~/.bash_aliases $dotfiles_b
sudo mv ~/.tmux.conf $dotfiles_b
sudo mv ~/.nanorc $dotfiles_b
sudo mv ~/.gdbinit $dotfiles_b
sudo mv ~/.teamocil $dotfiles_b

# Create symlinks
ln -sf $dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -sf $dotfiles/.bashrc ~/.bashrc
ln -sf $dotfiles/.bash_aliases ~/.bash_aliases
ln -sf $dotfiles/.bashrc_misc ~/.bashrc_misc
ln -sf $dotfiles/.bashrc_pentesting ~/.bashrc_pentesting
ln -sf $dotfiles/.tmux.conf ~/.tmux.conf
ln -sf $dotfiles/.nanorc ~/.nanorc
ln -sf $dotfiles/.gdbinit ~/.gdbinit
ln -sf $dotfiles/.teamocil ~/.teamocil

# Rights
chmod +x $dotfiles/scripts/*