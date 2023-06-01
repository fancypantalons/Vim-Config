" Note, the font handling here is largely stolen from https://github.com/unclechu/neovimrc

let s:font_family = 'Fira Code Regular'
let s:font_features = 'cv02, ss01, ss05, ss03, cv29, ss02, ss07'
let s:font_size = 14

function! s:update_font()
  call rpcnotify(1, 'Gui', 'Font', s:font_family.' '.string(s:font_size))
  call rpcnotify(1, 'Gui', 'FontFeatures', s:font_features)
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
  GuiLinespace 1
endfunction

nnoremap <leader>- :<C-u>call <SID>font_size_dec(v:count)<CR>
nnoremap <leader>+ :<C-u>call <SID>font_size_inc(v:count)<CR>
nnoremap <leader>= :<C-u>call <SID>font_size_inc(v:count)<CR>

call s:update_font()

call rpcnotify(1, 'Gui', 'Command', 'SetCursorBlink', '0')
call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)

NGPreferDarkTheme on

au FileType vimwiki call SetupVimwiki()
