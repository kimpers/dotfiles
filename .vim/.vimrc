" Standard settings
set nocompatible              " be iMproved, required
syntax on

" Vundle configurations
" -----------------------------------------------------------------------
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Bundles to install
Bundle 'tpope/vim-fugitive'
Bundle 'Valloric/YouCompleteMe'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-ruby/vim-ruby'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'tpope/vim-rails.git'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'sickill/vim-pasta'
Bundle 'sjl/gundo.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'moll/vim-node'
Bundle 'scrooloose/syntastic'
Bundle 'digitaltoad/vim-jade'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'sidorares/node-vim-debugger'
Bundle 'myhere/vim-nodejs-complete'
Bundle 'airblade/vim-gitgutter'
Bundle 'jiangmiao/auto-pairs'
Bundle 'JulesWang/css.vim'
Bundle 'kana/vim-textobj-indent'
Bundle 'kana/vim-textobj-user'
Bundle 'junegunn/vim-easy-align'
Bundle 'kien/ctrlp.vim'
Bundle 'matze/vim-move'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'sheerun/vim-polyglot'
"Bundle 'szw/vim-ctrlspace' learn some other time
Bundle 'terryma/vim-multiple-cursors'
Bundle 'terryma/vim-expand-region'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'zhaocai/GoldenView.Vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-dispatch'
Bundle 'astashov/vim-ruby-debugger'
Bundle 'jonathanfilip/vim-lucius'
Bundle 'jpo/vim-railscasts-theme'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'tpope/vim-repeat.git'
Bundle 'benmills/vimux'
Bundle 'wookiehangover/jshint.vim'

" ------------------------------------------------------------------------
filetype plugin indent on

" Change the leader from \ to ,
let mapleader="\<Space>"

runtime macros/matchit.vim

" Omni complete functions
autocmd FileType * setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
" Eclim should only autocomplete some files
autocmd FileType php,java, let g:EclimCompletionMethod = 'omnifunc'
autocmd FileType php,java
	\if &completefunc != '' | let &omnifunc=&completefunc | endif

" Ultisnips selection on ctrl-j to stop interference
" with YouCompleteMe
let g:UltiSnipsExpandTrigger = '<c-j>'

" YouCompleteMe
let g:ycm_min_num_of_chars_for_completion = 3

" Vim Jedi
let g:jedi#popup_on_dot = 0

" Lucius theme
" colorscheme lucius
" LuciusBlack

" Solarized theme
set background=dark
colorscheme solarized

" Vim-ruby
autocmd FileType ruby,eruby compiler ruby
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" Vimux
" Run the current file with rspec
map <Leader>rb :call VimuxRunCommand("clear; bundle exec rspec " . bufname("%"))<CR>
" Promt for a command to run
map <Leader>rp :VimuxPromptCommand<CR>
" Inspect runner pane
map <Leader>ri :VimuxInspectRunner<CR>
" Run last vimux command
map <Leader>rl :VimuxRunLastCommand<CR>
" Close vim tmux runner opened by vimux
map <Leader>rq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane
map <Leader>rs :VimuxInterruptRunner<CR>
" Split tmuxpane horizontally
let g:VimuxOrientation = "h"


" Powerline
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Nerdtree autostart if vim is started without file argument
"autocmd vimenter * if !argc() | NERDTree | endif

" Highlight matching bracket/parantheses
autocmd vimenter * DoMatchParen

" Rainbow parantheses
au VimEnter * RainbowParenthesesToggle
au VimEnter * RainbowParenthesesLoadRound
au VimEnter * RainbowParenthesesLoadSquare
au VimEnter * RainbowParenthesesLoadBraces

" IndentGuides
au VimEnter * IndentGuidesEnable

" GoldenView
let g:goldenview__enable_default_mapping = 0
" 1. split to tiled windows
nmap <silent> <S-L>  <Plug>GoldenViewSplit
" 2. quickly switch current window with the main pane
" and toggle back
nmap <silent> <F8>   <Plug>GoldenViewSwitchMain
nmap <silent> <S-F8> <Plug>GoldenViewSwitchToggle
" 3. jump to next and previous window
nmap <silent> <S-N>  <Plug>GoldenViewNext
nmap <silent> <S-P>  <Plug>GoldenViewPrevious

" CtrP
let g:ctrlp_extensions = ['funky']
let g:ctrlp_funky_syntax_highlight = 1
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" Easy-align
" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign with a Vim movement
nmap <Leader>a <Plug>(EasyAlign)

" Vim-surround
" ERB tags
"autocmd FileType eruby let g:surround_45 = "<% \r %>"
"autocmd FileType eruby let g:surround_61 = "<%= \r %>"
"autocmd FileType eruby let g:surround_33 = "```\r```"

" ALT key bindings in terminal mode workaround to get terminal vim 
" to pick up on M-key bindings
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw
set timeout ttimeoutlen=50

" Settings ----------------------------------------------------------------------------------

" Set hybrid relative and absolute line numbers
set number
set relativenumber

" 2 spaces TABS as standard and 4 for some files
set tabstop=2       " The width of a TAB is set to 4.
set shiftwidth=2    " Indents will have a width of 4
set softtabstop=2   " Sets the number of columns for a TAB
autocmd FileType java set tabstop=4
autocmd FileType java set shiftwidth=4
autocmd FileType java set softtabstop=4
set expandtab

" New vertical splits to the right and horizontal below
:set splitright
:set splitbelow

" General settings
set hidden
set nobackup
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set visualbell
set noerrorbells
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set nowrap        " don't wrap lines
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

" Keymappings --------------------------------------------------------------------------------

" Map ctrl-d to toggle between vim and terminal
noremap <C-d> :sh<cr>

" Ctrl F6 to toggle GUndo
nnoremap <C-F6> :GundoToggle<CR>

" Ctrl F7 to toggle Nerdtree
nnoremap <C-F7> :NERDTreeToggle<CR>

" Map esc to j+k no matter order so both can be pressed at the same time
:imap jj <Esc>
:imap jk <Esc>
:imap kj <Esc>

" CTRL-C/V binding to system clipboard
vnoremap <C-c> "+y
noremap <C-v> "+p

" Quick edit vimrc in vertical split
nmap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Toggle paste mode on F2
set pastetoggle=<F2>

" Toggle fullscreen and tool/menu bars (requires vim-qt)
nnoremap <C-F9> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F10> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F11> :set fullscreen<CR>
nnoremap <C-F12> :set nofullscreen<CR>

" Put : command on ; for easer access
nnoremap ; :

" Better window navigation with ctrl-hjkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Unbind arrow keys to force use of hjkl
" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor


