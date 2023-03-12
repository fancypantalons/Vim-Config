function! SetupVimwiki()
  call rpcnotify(1, 'Gui', 'Font', 'Nitti Basic Light 14')
  GuiLinespace 3
endfunction

call rpcnotify(1, 'Gui', 'Command', 'SetCursorBlink', '0')
call rpcnotify(1, 'Gui', 'Font', 'Inconsolata Medium 15')
GuiLinespace 2
call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)

NGPreferDarkTheme on

au FileType vimwiki call SetupVimwiki()
