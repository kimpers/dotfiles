" Standard settings
"
set nocompatible              " be iMproved, required
syntax on

"Setup
call plug#begin('~/.vim/plugged')

" Plugs to install
" General
Plug 'tpope/vim-fugitive'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Lokaltog/vim-easymotion'
Plug 'sickill/vim-pasta'
Plug 'sjl/gundo.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'kana/vim-textobj-user'
Plug 'junegunn/vim-easy-align'
Plug 'matze/vim-move'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'zhaocai/GoldenView.Vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-repeat'
Plug 'benmills/vimux'
Plug 'qpkorr/vim-bufkill'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/unite.vim'
"Plug 'tpope/vim-dispatch'
"Plug 'jonathanfilip/vim-lucius'
"Plug 'jpo/vim-railscasts-theme'
"Plug 'szw/vim-ctrlspace'

" Ruby
Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
Plug 'tpope/vim-rails', {'for': 'ruby'}
Plug 'tpope/vim-endwise', {'for': 'ruby'}

" Javascript
Plug 'moll/vim-node', {'for': 'javascript'}
Plug 'othree/yajs.vim', {'for': 'javascript'}
Plug 'ahayman/vim-nodejs-complete', {'for': 'javascript'}
Plug 'wookiehangover/jshint.vim', {'for': 'javascript'}

" Other
Plug 'digitaltoad/vim-jade', {'for': 'jade'}
Plug 'JulesWang/css.vim', {'for': 'css'}
Plug 'lervag/vimtex', {'for': 'tex'}

call plug#end()
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

" Unite.vim
" Content search
nnoremap <leader>/ :Unite grep:.<cr>

" File selection
nnoremap <C-p> :Unite file_rec/async<cr>

" Yank history
let g:unite_source_history_yank_enable = 1
nnoremap <leader>y :Unite history/yank<cr>

"Buffer switching
nnoremap <leader>s :Unite -quick-match buffer<cr>

" Ultisnips selection on ctrl-j to stop interference
" with YouCompleteMe
let g:UltiSnipsExpandTrigger = '<c-j>'

" YouCompleteMe
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_filetype_blacklist = {
      \ 'tex' : 1,
      \ 'markdown' : 1,
      \ 'text' : 1
      \}

" Vim Jedi
let g:jedi#popup_on_dot = 0

" GitGutter
" Performance optimization
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

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

" Latex specific settings
autocmd BufNewFile,BufRead *.tex set spell spelllang=en_us
" Fix to make large Latex files not be slow in Vim
autocmd FileType tex :NoMatchParen
autocmd FileType tex :syntax sync minlines=256
autocmd FileType tex :syntax sync maxlines=500
au FileType tex setlocal nocursorline
au FileType tex setlocal nocursorcolumn
au FileType tex setlocal norelativenumber
au FileType tex setlocal synmaxcol=200

" Vimux
" Run the current file with rspec
map <Leader>rb :call VimuxRunCommand("clear; bundle exec rspec " . bufname("%"))<CR>
" Run all specs
map <Leader>ra :call VimuxRunCommand("clear; bundle exec rspec")<CR>
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

" Easy-align
" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign with a Vim movement
nmap <Leader>a <Plug>(EasyAlign)

" Vim-surround
" ERB tags
autocmd FileType eruby let g:surround_45 = "<% \r %>"
autocmd FileType eruby let g:surround_61 = "<%= \r %>"
autocmd FileType eruby let g:surround_33 = "```\r```"

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

set splitbelow    " spawn horizontal splits below instead of above"
set splitright    " spawn vertical splits to the right instead of left"

" Keymappings --------------------------------------------------------------------------------

" Ctrl F6 to toggle GUndo
nnoremap <C-F6> :GundoToggle<CR>

" Ctrl F7 to toggle Nerdtree
nnoremap <C-F7> :NERDTreeToggle<CR>

" Map esc to j+k no matter order so both can be pressed at the same time
:imap jj <Esc>
:imap jk <Esc>
:imap kj <Esc>

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

" Toggle text folding easily with F9
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf
