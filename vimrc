syntax on
filetype plugin indent on

set showcmd

set autoindent
set cindent
set cinoptions=(0g0

set expandtab
set smarttab
set shiftwidth=2

set nowrap

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2
set pastetoggle=<F11>
set wildmenu
set hid
set background=dark

set ignorecase
set smartcase

let g:localvimrc_ask=0
let g:autotagVerbosityLevel=9
let g:localvimrc_sandbox=0

au FileType make set noexpandtab|set nosmarttab
au FileType cf set tabstop=4|set shiftwidth=4
au FileType sql set tabstop=4|set shiftwidth=4
au FileType python set tabstop=4|set shiftwidth=4

colorscheme zenburn

map ; :
imap jj <ESC>

"
" Enable 256-color if the terminal type is xterm.  This is a hack.
"

if &term =~ "xterm"
    if has("terminfo")
        set t_Co=16
        set t_AB=[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
        set t_AF=[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
     else
        set t_Co=16
        set t_Sf=[3%dm
        set t_Sb=[4%dm
     endif
endif

"
" I prefer editors to switch the current working directory to that of the
" file being edited.  This autocommand hook makes that happen.
"
autocmd BufEnter * exec "cd " . fnameescape(expand("%:p:h"))

"
" I use the localvimrc plugin and lvimrc files in my projects to manage
" project-specific settings (such as build configuration and so forth).  This
" function provides some common logic for setting up seach paths, the CommandT
" plugin, and adds standard ctags/cscope databases.
"
function! LocalVimRCLoadedHook(rcpath)
    let g:local_vimrc_path = a:rcpath
    let g:project_cscope_db = g:local_vimrc_path . "/.git/cscope.out"
    let g:project_ctags_db = g:local_vimrc_path . "/.git/tags"

    exec "set path=" . g:local_vimrc_path . "/**"

    exec "map <leader>t :CommandTFlush<cr>\\|:CommandT " . g:local_vimrc_path . "<cr>"
    map <leader>T :CommandTFlush<cr>\|:CommandT %%<cr>

    if filereadable(g:project_cscope_db)
        " Assuming the tags databases are rebuilt using make, we add
        " autocommand hooks to reload the cscope database when the make
        " command is run.

        au QuickFixCmdPre make exec("cs kill -1")
        au QuickFixCmdPost make exec("cs add " . g:project_cscope_db . " " . g:local_vimrc_path)

        " Now do it right meow.
        cs kill -1
        exec "cs add " . g:project_cscope_db . " " . g:local_vimrc_path
    endif

    if filereadable(g:project_ctags_db)
        exec "set tags=" . fnameescape(g:project_ctags_db)
    endif
endfunction

