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
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'kana/vim-textobj-user'
Plug 'junegunn/vim-easy-align'
Plug 'matze/vim-move'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-repeat'
Plug 'qpkorr/vim-bufkill'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/unite.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'jzelinskie/vim-sensible' " Use NeoVim compatible fork
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'benekastah/neomake'
Plug 'bling/vim-airline'
"Plug 'zhaocai/GoldenView.Vim'
"Plug 'tpope/vim-sensible'
"Plug 'tpope/vim-unimpaired'
"Plug 'terryma/vim-expand-region'
"Plug 'sheerun/vim-polyglot', { 'do': './build' }
"Plug 'benmills/vimux'
"Plug 'tpope/vim-dispatch'
"Plug 'jonathanfilip/vim-lucius'
"Plug 'jpo/vim-railscasts-theme'
"Plug 'szw/vim-ctrlspace'

" Ruby
Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
Plug 'tpope/vim-rails', {'for': 'ruby'}
Plug 'tpope/vim-endwise', {'for': 'ruby'}
Plug 'nelstrom/vim-textobj-rubyblock', {'for': 'ruby'}

" Javascript
Plug 'moll/vim-node', {'for': 'javascript'}
"Plug 'othree/yajs.vim', {'for': 'javascript'}
Plug 'ahayman/vim-nodejs-complete', {'for': 'javascript'}
Plug 'ternjs/tern_for_vim', {'for': 'javascript', 'do': 'npm install'}

" Other
Plug 'digitaltoad/vim-jade', {'for': 'jade'}
Plug 'JulesWang/css.vim', {'for': 'css'}
Plug 'ap/vim-css-color', {'for': 'css'}

call plug#end()
" ------------------------------------------------------------------------
filetype plugin indent on

" Change the leader from \ to <Space>
let mapleader="\<Space>"

runtime macros/matchit.vim

" Settings ----------------------------------------------------------------------------------

  "NeoVim handles ESC keys as alt+key, set this to solve the problem
  set timeout
  set timeoutlen=750
  set ttimeoutlen=250
  if has('nvim')
     set ttimeout
     set ttimeoutlen=0
  endif
" Set hybrid relative and absolute line numbers
set number
set relativenumber

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
set colorcolumn=80 "Show vertical line at 80 chars"

" Keymappings --------------------------------------------------------------------------------

" Ctrl F6 to toggle GUndo
nnoremap <C-F6> :GundoToggle<CR>

" Ctrl F7 to toggle Nerdtree
nnoremap <C-F7> :NERDTreeToggle<CR>

" Map esc to jj/j+k no matter order so both can be pressed at the same time
:imap jj <Esc>
:imap jk <Esc>
:imap kj <Esc>

" Quick edit vimrc in vertical split
nmap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Toggle paste mode on F2
set pastetoggle=<F2>

" Put : command on ; for easer access
nnoremap ; :

" Make esc change modes in terminal
:tnoremap <leader><Esc> <C-\><C-n>
" Better window navigation with ctrl-w-hjkl
:tnoremap <C-w>h <C-\><C-n><C-w>h
:tnoremap <C-w>j <C-\><C-n><C-w>j
:tnoremap <C-w>k <C-\><C-n><C-w>k
:tnoremap <C-w>l <C-\><C-n><C-w>l
:nnoremap <C-w>h <C-w>h
:nnoremap <C-w>j <C-w>j
:nnoremap <C-w>k <C-w>k
:nnoremap <C-w>l <C-w>l

" Toggle text folding easily with F9
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" Plugins --------------------------------------------------------------------------------------

" Omni complete functions
"autocmd FileType * setlocal omnifunc=syntaxcomplete#Complete
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['jshint']

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" Smarter search
" / in visual seaches for selection
vnoremap / y/<C-R>"<CR>
" leader / brings up CTrlSFPrompt
nmap <leader>/  <Plug>CtrlSFPrompt
" leader / in visual searches for files containing selection
vmap <leader>/ <Plug>CtrlSFVwordExec

" FZF
set rtp+=~/.fzf
nnoremap <leader>t :call fzf#run({'sink': 'e', 'window': 'enew'})<CR>

" Unite.vim

" Yank history
let g:unite_source_history_yank_enable = 1
nnoremap <leader>y :Unite history/yank<cr>

"Buffer switching
nnoremap <leader>b :Unite -quick-match buffer<cr>

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

" Text and latex specific settings
au FileType text,tex,markdown setlocal wrap linebreak nolist spell spelllang=en_us

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

" Easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Vim-surround
" ERB tags
autocmd FileType eruby let g:surround_45 = "<% \r %>"
autocmd FileType eruby let g:surround_61 = "<%= \r %>"
autocmd FileType eruby let g:surround_33 = "```\r```"

" ALT key bindings in terminal mode workaround to get terminal vim 
" to pick up on M-key bindings
"let c='a'
"while c <= 'z'
  "exec "set <A-".c.">=\e".c
  "exec "imap \e".c." <A-".c.">"
  "let c = nr2char(1+char2nr(c))
"endw
