" Attempt to load pathogen for package management.  If it's not availble
" no biggie.
try
    call pathogen#infect()
    Helptags
catch /.*/
endtry

"{{{ User-defined Functions

"
" I use the localvimrc plugin and lvimrc files in my projects to manage
" project-specific settings (such as build configuration and so forth).  This
" function provides some common logic for setting up seach paths, and adds
" standard ctags/cscope databases.
"
function! LocalVimRCLoadedHook(rcpath)
    let g:local_vimrc_path = a:rcpath
    let g:project_cscope_db = g:local_vimrc_path . "/.git/cscope.out"
    let g:project_ctags_db = g:local_vimrc_path . "/.git/tags"

    exec "set path=" . g:local_vimrc_path . "/**"

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

function! ChangeToFileDir()
    if expand("%") !~ "fugitive"
        exec "cd " . fnameescape(expand("%:p:h"))
    endif
endfunction

function! RecheckFileType()
    if (expand("%") != "") && (expand("%") !~ "fugitive") && ! exists('b:reload_dos') && ! &binary && (&ff == 'unix') && (search('\r$', 'nc') > 0)
        let b:reload_dos = 1

        e ++ff=dos
    endif

    if (search('^%YAML ') > 0)
        set ft=yaml
    endif
endfunction

"
" Simple Vim function for generating a GUID and inserting it into the current
" buffer.
"
function! MakeGuid()
python << EOF
import vim
import uuid
vim.command('let @z="' + str(uuid.uuid4()).upper() + '"')
vim.command('normal "zP');

(row, col) = vim.current.window.cursor

vim.current.window.cursor = (row, col + 1)
EOF
endfunction

"}}}

"{{{ Configuration settings

syntax on
filetype plugin indent on

set showcmd

set autoindent
set cindent
set cinoptions=(0g0

set expandtab
set smarttab
set shiftwidth=2
set showbreak=>\ 

set nowrap

set laststatus=2
set pastetoggle=<F11>
set wildmenu
set wildignore+=*.class
set hid
set background=dark

set ignorecase
set smartcase

set noequalalways

set ttimeoutlen=50

if has('gui_running')
  set guicursor=a:blinkoff0
  set guioptions=aegit

  if has('win32')
      set guifont=Consolas:h10.5
      set columns=180
      set lines=50
  else
      set guifont=Inconsolata\ Medium\ 12
      set columns=160
      set lines=50
  endif
endif

let g:localvimrc_ask=0
let g:autotagVerbosityLevel=9
let g:localvimrc_sandbox=0

let g:airline_theme='bubblegum'
let g:airline_detect_whitespace=0
let g:airline_left_sep=''
let g:airline_right_sep=''

au FileType make set noexpandtab|set nosmarttab
au FileType cf set tabstop=4|set shiftwidth=4
au FileType sql set tabstop=4|set shiftwidth=4
au FileType python set tabstop=4|set shiftwidth=4
au FileType text set wrap|set lbr|set nocindent
au FileType gitcommit set nowrap|set nocindent
au FileType quicktask set nowrap|set nocindent

if empty($MSYSTEM) || has('gui_running')
    colorscheme lucius
endif

if has('win32')
    let &grepprg="\"C:/GnuWin32/bin/grep.exe\" -n $*"
    let g:netrw_localcopycmd="C:/GnuWin32/bin/cp.exe"
    let g:netrw_localmovecmd="C:/GnuWin32/bin/mv.exe"
    let g:netrw_localmkdir="C:/GnuWin32/bin/mkdir.exe"
    let g:netrw_localrmdir="C:/GnuWin32/bin/rmdir.exe"
else
    set list listchars=tab:».,trail:°
endif

" Create a new tmux window when firing up swank for interactive lisp coding.

let g:slimv_swank_cmd = '!tmux new-window -d -n swank "sbcl --load /usr/share/common-lisp/source/slime/start-swank.lisp" &'

" NERDTree settings

let NERDTreeShowBookmarks=1

"}}}

"{{{ Key mapping and autocmd bindings

map ; :
map <leader>g :call MakeGuid()<cr>
map <leader>s :Gstatus<cr>
map <leader>d :Gdiff<cr>
map <leader>l :Glog<cr>
map <leader>b :Gblame<cr>
map <leader>w :Gwrite<cr>
map <leader>r :Gread<cr>
map <leader>c :Gcommit<cr>

map <leader>t :CtrlPMixed<cr>
map <leader>n :NERDTreeToggle<cr>
map <leader>N :NERDTreeFind<cr>

cnoremap bd<CR> execute "normal \<Plug>Kwbd"<CR>
cnoremap bd!<CR> execute "normal \<Plug>KwbdForce"<CR>

"
" I prefer editors which switch the current working directory to that of the
" file being edited.  This autocommand hook makes that happen.
"
autocmd BufEnter * call ChangeToFileDir()

"
" Weirdly, .txt files don't automatically trigger the text filetype...
"
autocmd BufRead,BufNewFile *.txt setfiletype text

"
" Check if this file contains mixed line endings but was detected as a unix
" file.  If so, reload as a DOS file.  This helps with msysgit when editing
" diff hunks
"
autocmd BufReadPost * nested call RecheckFileType()
autocmd BufReadPost fugitive://* set bufhidden=delete

"}}}
