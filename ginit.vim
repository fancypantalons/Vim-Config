" Note, the font handling here is largely stolen from https://github.com/unclechu/neovimrc

" Because we're now using neovide, you have to find its TOML file 
" to configure some things (e.g. font settings).
"
" On Linux (with a flatpak install) that's in:
"
" ~/.var/app/dev.neovide.neovide/config/neovide/config.toml"
"
" On MacOS it's in: 
"
" ~/.config/neovide/config.toml
"
" On Linux don't forget to set neovim-bin to 'flatpak-spawn /usr/bin/nvim'
let g:neovide_cursor_animation_length = 0

let g:neovide_padding_right = 16 
let g:neovide_padding_left = 16
let g:neovide_padding_top = 16 
