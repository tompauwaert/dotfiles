" 
" VIMRC File for Tom Pauwaert
" Usage: Web development / HTML / Javascript / CSS / Python
" 
"
set nocompatible
filetype off

" set the runtime path to include vundle and initialize
let win_shell = (has('win32') || has('win64')) && &shellcmdflag =~ '/'
let vimDir = win_shell ? '$HOME/vimfiles' : '$HOME/.vim'
let &runtimepath .= ',' . expand(vimDir . '/bundle/Vundle.vim')
call vundle#rc(expand(vimDir . '/bundle'))
call vundle#begin()

Plugin 'gmarik/Vundle.vim' 
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'kien/ctrlp.vim'
Bundle 'rstacruz/sparkup'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Shougo/neocomplete.vim'
Plugin 'vim-scripts/ScrollColors'
Plugin 'vim-scripts/CSApprox'
Plugin 'vim-scripts/Colour-Sampler-Pack'
Plugin 'scrooloose/syntastic'


call vundle#end()
filetype plugin indent on

" Set terminal colors to 256
set t_Co=256

" Always show an incomplete command in the lower right corner
set showcmd

" Set the match for a search pattern when halfway typing it.
set incsearch

" Make backspace behave like other editors
set backspace=indent,eol,start
" Automatically indent on new lines
set autoindent
" Copy the indentation of the previous line if auto indent doesn't know what to do
set copyindent
" Indenting a line with >> or << will indent or un-indent by 4
set shiftwidth=4
" Pressing tab in insert mode will use 4 spaces
set softtabstop=4
" Use spaces instead of tabs
set expandtab
" Highlight matching braces/tags
set showmatch
" Ignore case when searching
set ignorecase
" ...unless there's a capital letter in the query
set smartcase
" Indent to correct location with tab
set smarttab
" Highlight search matches
set hlsearch
" Search while you enter the query, not after
set incsearch
" More undos
set undolevels=1000
" Vim can set the title of the terminal window
set title
" Use a visual indicator instead of a beep
set visualbell
" Or just turn error bells off with this
set noerrorbells
" Enable syntax highlighting
syntax enable
" Tell vim that your terminal supports 256 colors
set t_Co=256
" Toggle paste mode with F2
set pastetoggle=<F2>
" Use ; instead of : to enter commands, saves a lot of keystrokes in the long run
nnoremap ; :
" Set the timeout len for commands to be shorter.
set timeoutlen=750
set number


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remapping keys.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = "," 
inoremap kj <Esc>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Macro's etc.
" Source: http://items.sjbach.com/319/configuring-vim-right
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Make vim's % key also match if/elseif/else/end.
runtime macros/matchit.vim

" Make <TAB> in command mode show the different completion options.
set wildmode=list:longest,full

" Keep context around cursor. Start scrolling when the cursor is 3 lines away
" from the bottom/top of viewport.
set scrolloff=6

" Set the backup and temp files in a central folders.
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,/~.tmp,~/tmp,/var/tmp,/tmp 

" Scroll the viewport faster, 3 lines instead of 1 line 
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y> 

set ruler 

" Temporarily turn of search term higlighting
nmap <silent> <leader>n :silent :nohlsearch<CR> 

" Catch trailing whitespace
set listchars=tab:>-,trail: ,eol:$
nmap <silent> <leader>s :set nolist!<CR> 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRL+P Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ctrlp_max_files=0
" let g:ctrlp_working_path_mode=0

" Ignore these directories:
" set wildignore+=*/out/**
" set wildignore+=*/vendor/**

" Search in certain directories a large project (hardcoded for now)
" cnoremap %proj <c-r>=expand('~/Projects/some-project')<cr>
" ga = go api
" map <Leader>ga :CtrlP %proj/api/<cr>
" gf = go frontend
" map <Leader>gf :CtrlP %proj/some/long/path/to/frontend/code/<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snipmate Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:sparkupNextMapping = '<c-f>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoComplete configuration 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
	\ 'default' : '',
	\ 'vimshell' : $HOME.'/.vimshell_hist',
	\ 'scheme' : $HOME.'/.gosh_completions'
\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap      neocomplete#undo_completion()
inoremap      neocomplete#complete_common_string()

" Recommended key-mappings.
" : close popup and save indent.
inoremap   =my_cr_function()
function! s:my_cr_function()
	return neocomplete#close_popup() . "\"
	" For no inserting  key. return pumvisible() ?
	neocomplete#close_popup() : "\"
endfunction

" : completion.
inoremap   pumvisible() ? "\" : "\"

" , : close popup and delete backword char.
inoremap  neocomplete#smart_close_popup()."\"
inoremap  neocomplete#smart_close_popup()."\"
inoremap   neocomplete#close_popup()
inoremap   neocomplete#cancel_popup()

" Close popup by . 
" inoremap  pumvisible() ?  neocomplete#close_popup() : "\"

" For cursor moving in insert mode(Not recommended)
"inoremap   neocomplete#close_popup() . "\"
"inoremap  neocomplete#close_popup() . "\"
"inoremap     neocomplete#close_popup() . "\"
"inoremap   neocomplete#close_popup() . "\"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap   pumvisible() ? "\" : "\\"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ENDOF NEOCOMPLETE CONIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart indent when entering insert mode with i on empty lines.
"function! IndentWithI()
	"if len(getline('.')) == 0
		"return "\"_ddO
	"else 
		"return "i"
	"endif
"endfunction
"nnoremap <expr> i IndentWithI()


" Set color scheme
colorscheme Mustang 
