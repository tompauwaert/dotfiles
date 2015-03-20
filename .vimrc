" description
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
Bundle 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/ScrollColors'
Plugin 'vim-scripts/CSApprox'
Plugin 'vim-scripts/Colour-Sampler-Pack'
Plugin 'Lokaltog/powerline', {'rtp' : 'powerline/bindings/vim/'}
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Plugin 'tmhedberg/matchit'
Plugin 'godlygeek/tabular'
"Plugin 'kien/ctrlp.vim'
"Bundle 'rstacruz/sparkup'
"Bundle 'tpope/vim-fugitive'  
"Plugin 'scrooloose/syntastic'
"Bundle 'Shougo/neocomplete.vim'


call vundle#end()
filetype plugin indent on

set showcmd " Always show an incomplete command in the lower right corner
set incsearch " Set the match for a search pattern when halfway typing it.
set backspace=indent,eol,start " Make backspace behave like other editors
set autoindent " Automatically indent on new lines
set copyindent " Copy the indentation of the previous line if auto indent doesn't know what to do
set shiftwidth=4 " Indenting a line with >> or << will indent or un-indent by 4
set softtabstop=4 " Pressing tab in insert mode will use 4 spaces
set expandtab " Use spaces instead of tabs
set showmatch " Highlight matching braces/tags
set ignorecase " Ignore case when searching
set smartcase " ...unless there's a capital letter in the query
set smarttab " Indent to correct location with tab
set hlsearch " Highlight search matches
set incsearch " Search while you enter the query, not after
set undolevels=1000 " More undos
set title " Vim can set the title of the terminal window
set noerrorbells " Or just turn error bells off with this
 set pastetoggle=<F3> " Toggle paste mode with F2
" "Use ; instead of : to enter commands, saves a lot of keystrokes in the long run
"nnoremap ; :
set timeoutlen=750 " Set the timeout len for commands to be shorter.
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
" runtime macros/matchit.vim
" 
" " Make <TAB> in command mode show the different completion options.
set wildmode=list:longest,full
" 
" " Keep context around cursor. Start scrolling when the cursor is 3 lines away
" " from the bottom/top of viewport.
set scrolloff=6
" 
" " Set the backup and temp files in a central folders.
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,/~.tmp,~/tmp,/var/tmp,/tmp 

" Scroll the viewport faster, 3 lines instead of 1 line 
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y> 

" set ruler 

" Temporarily turn of search term higlighting
nmap <silent> <leader>h :silent :nohlsearch<CR> 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snipmate Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" REENABLE TILL >

let g:sparkupNextMapping = '<c-f>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart indenting when using 'i'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart indent when entering insert mode with i on empty lines.
function! IndentWithI()
        if len(getline('.')) == 0
                return "\"_cc"
        else 
                return "i"
        endif
endfunction
nnoremap <expr> i IndentWithI()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Powerline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerdtree settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F2> :NERDTreeToggle<CR>
let NERDTreeDirArrows=0

""""""""""""""""""""""""""""""""""""""""""""""""""
" Change colorscheme depending on light.
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:solarized_italic=1
let g:solarized_termcolors=16
set t_Co=256
set background=light
colorscheme solarized
" colorscheme Mustang
syntax enable

" Changes to default solarized color scheme
""""""""""""""""""""""""""""""""""""""""""""""""""
highlight ErrorMsg guibg=White

" nnoremap <C-F10> :colorscheme Mustang<cr>
" nnoremap <C-F9> :colorscheme solarized<cr>
