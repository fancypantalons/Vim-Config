function! ChangeToFileDir()
    if expand("%") !~ "fugitive" && expand("%") !~ "term://"
        exec "cd " . fnameescape(expand("%:p:h"))
    endif
endfunction

" Appearance settings

set termguicolors
colorscheme lucius

" General behavioural options

set noswapfile
set noequalalways

" File formatting options

set cindent
set cinoptions=(0g0

set expandtab
set smarttab
set shiftwidth=2
set showbreak=>\ 

set nowrap

" Configure the wildmenu for file selection, etc.

set wildignore+=*.class

" Search-related settings

set ignorecase
set smartcase

" Keymappings

map ; :
map <leader>n :NvimTreeToggle<cr>

map <leader>G :Goyo<cr>

nnoremap <leader>f :execute 'Telescope find_files cwd=' . FindRootDirectory()<cr>
nnoremap <leader>g :execute 'Telescope live_grep cwd=' . FindRootDirectory()<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>
nnoremap <leader>r <cmd>Telescope lsp_references<cr>
nnoremap <leader>i <cmd>Telescope lsp_implementations<cr>

nnoremap <leader>dt :lua require("dapui").toggle()<cr>
nnoremap <leader>dl :lua require("dap.ui.widgets").hover<cr>
nnoremap <leader>dc <cmd>DapContinue<cr>
nnoremap <leader>ds <cmd>DapTerminate<cr>
nnoremap <leader>db <cmd>DapToggleBreakpoint<cr>
nnoremap <leader>dn <cmd>DapStepOver<cr>
nnoremap <leader>di <cmd>DapStepInto<cr>
nnoremap <leader>do <cmd>DapStepOut<cr>

nnoremap <leader>hd <cmd>GitGutterDiffOrig<cr>

" Mappings to change how buffer deletes work

cnoremap bd<CR> execute "lua require('bufdelete').bufdelete(0)"<CR>
cnoremap bd!<CR> execute "lua require('bufdelete').bufdelete(0, true)"<CR>

" Filetype-specific auto-commands for setting up context-specific preferences

au FileType text set wrap|set lbr|set nocindent
au FileType vimwiki call pencil#init({'wrap': 'soft'})|set sbr=|set foldlevel=99|set spell|set syntax=markdown

autocmd BufEnter * call ChangeToFileDir()

" Trigger Limelight automatically if we turn on/off Goyo

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
