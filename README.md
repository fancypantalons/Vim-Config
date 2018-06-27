# What is this?

This is the repository for my Vim configuration.  My background is in software development, so much of this is tuned for a developer's workflow, however I've since expanded my use of Vim to cover writing and note taking, as well.  As a result, this also includes my vimwiki configuration plus writing-related plugins like Goyo.

As vim and tmux are the ying to the other's yang, I've also included my tmux configuration as part of this repo.

This configuration is designed to be cross-platform, as I maintain a foot in both the Windows and Unix worlds.

# How to use this repository

1. Install vim-pathogen
2. Clone this repository to some directory, and then...

## Unix

1. ln -s /path/to/home/.vimrc /path/to/Vim-Config/vimrc
2. ln -s /path/to/home/.vim/bundle /path/to/Vim-Config/bundle
3. ln -s /path/to/home/.vim/colors/lucius.vim /path/to/Vim-Config/lucius.vim
5. ln -s /path/to/home/.tmux.conf /path/to/Vim-Config/tmux.conf
4. Install fonts

## Windows 

1. Install GnuWin32 CoreUtils
2. Install GnuWin32 Grep
3. Fire up an administrative cmd.exe
4. mklink c:\path\to\home\_vimrc c:\path\to\Vim-Config\vimrc
5. mklink /d c:\path\to\home\vimfiles\bundle c:\path\to\Vim-Config\bundle
6. mklink c:\path\to\home\vimfiles\colors\lucius.vim c:\path\to\Vim-Config\lucius.vim
7. Install fonts
