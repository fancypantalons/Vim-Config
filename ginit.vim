" Note, the font handling here is largely stolen from https://github.com/unclechu/neovimrc

let s:font_family = 'Inconsolata Medium'
let s:font_size = 15 

function! s:update_font()
  call rpcnotify(1, 'Gui', 'Font', s:font_family.' '.string(s:font_size))
endfunction

function! s:set_font(family, size)
  let s:font_family = a:family
  let s:font_size = a:size
  call s:update_font()
endfunction

function! s:font_size_dec(count)
  let l:count = a:count | if l:count < 1 | let l:count = 1 | endif
  let s:font_size = s:font_size - l:count
  if s:font_size < 1 | let s:font_size = 1 | endif
  call s:update_font()
endfunction

function! s:font_size_inc(count)
  let l:count = a:count | if l:count < 1 | let l:count = 1 | endif
  let s:font_size = s:font_size + l:count
  if s:font_size < 1 | let s:font_size = 1 | endif
  call s:update_font()
endfunction

function! SetupVimwiki()
  call s:set_font("Nitti Basic Light", 14)
  GuiLinespace 3
endfunction

nnoremap <leader>- :<C-u>call <SID>font_size_dec(v:count)<CR>
nnoremap <leader>+ :<C-u>call <SID>font_size_inc(v:count)<CR>
nnoremap <leader>= :<C-u>call <SID>font_size_inc(v:count)<CR>

call s:update_font()

call rpcnotify(1, 'Gui', 'Command', 'SetCursorBlink', '0')
GuiLinespace 2
call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)

NGPreferDarkTheme on

au FileType vimwiki call SetupVimwiki()
