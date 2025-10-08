" disable netrw at the very start of your init.lua
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Rooter configuration

let g:rooter_manual_only = 1

" Airline configuration

let g:airline_theme="bubblegum"
let g:airline_detect_whitespace=0
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_powerline_fonts = 1

let g:airline_left_sep = "\uE0B4"
let g:airline_right_sep = "\uE0B6"

" Writing configuration

let g:goyo_width = 75
let g:pencil#joinspaces = 1

" NERDTree settings

let NERDTreeShowBookmarks=1
let g:NERDTreeGitStatusUseNerdFonts = 1

" localvimrc settings

let g:localvimrc_ask=0
let g:localvimrc_sandbox=0

" Vimwiki configuration

let g:vimwiki_listsyms = " .ox"
let g:vimwiki_key_mappings =
  \ {
  \   'all_maps': 1,
  \   'global': 1,
  \   'headers': 1,
  \   'text_objs': 1,
  \   'table_format': 1,
  \   'table_mappings': 0,
  \   'lists': 1,
  \   'links': 1,
  \   'html': 1,
  \   'mouse': 0,
  \ }

let wiki_personal = {}
let wiki_personal.path = '~/wiki/'
let wiki_personal.path_html = '~/wiki/export/html/'
let wiki_personal.syntax = 'markdown'
let wiki_personal.links_space_char = '_'
let wiki_personal.ext = '.md'

let wiki_blog = {}
let wiki_blog.path = '~/blog/'
let wiki_blog.syntax = 'markdown'
let wiki_blog.diary_rel_path = '_posts/'
let wiki_blog.links_space_char = '_'
let wiki_blog.ext = '.md'

let g:vimwiki_list = [wiki_personal, wiki_blog]

let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'index.md']
