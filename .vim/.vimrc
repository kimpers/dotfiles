" Standard settings
"
set nocompatible              " be iMproved, required
syntax on

"Setup
call plug#begin('~/.vim/plugged')

" Plugs to install
" General
Plug 'tpope/vim-fugitive'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'iCyMind/NeoSolarized'
Plug 'scrooloose/nerdtree'
Plug 'honza/vim-snippets'
Plug 'Lokaltog/vim-easymotion'
Plug 'sickill/vim-pasta'
Plug 'sjl/gundo.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'kana/vim-textobj-user'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'qpkorr/vim-bufkill'
Plug 'Shougo/denite.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'benekastah/neomake'
Plug 'benjie/neomake-local-eslint.vim'
Plug 'bling/vim-airline'
Plug 'rking/ag.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'mhinz/vim-startify'
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'cohama/lexima.vim'
Plug 'christoomey/vim-tmux-navigator'

" Ruby
Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
Plug 'tpope/vim-endwise', {'for': 'ruby'}
Plug 'nelstrom/vim-textobj-rubyblock', {'for': 'ruby'}
"Plug 'fishbullet/deoplete-ruby', {'for': 'ruby'}

" Javascript
Plug 'ternjs/tern_for_vim', { 'do': 'npm install'}
"Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
"Plug 'mxw/vim-jsx'
Plug 'flowtype/vim-flow', { 'do': 'npm install -g flow-bin'}
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'thalesmello/deoplete-flow'

" Typescript
Plug 'HerringtonDarkholme/yats.vim'
"Plug 'mhartington/deoplete-typescript'

" Golang
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'zchee/deoplete-go', {'for': 'go', 'do': 'make'}

" Other
Plug 'JulesWang/css.vim', {'for': 'css'}
Plug 'ap/vim-css-color', {'for': 'css'}

" Not needed?
" Plug 'matze/vim-move'
"Plug 'SirVer/ultisnips'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
"Plug 'tpope/vim-repeat'
"Plug 'Shougo/vimproc.vim', { 'do': 'make' }
"Plug 'zhaocai/GoldenView.Vim'
"Plug 'tpope/vim-unimpaired'
"Plug 'terryma/vim-expand-region'
"Plug 'sheerun/vim-polyglot', { 'do': './build' }
"Plug 'benmills/vimux'
"Plug 'tpope/vim-dispatch'
"Plug 'jonathanfilip/vim-lucius'
"Plug 'jpo/vim-railscasts-theme'
"Plug 'szw/vim-ctrlspace'
"Plug 'digitaltoad/vim-jade', {'for': 'jade'}
"Plug 'moll/vim-node', {'for': 'javascript'}
"Plug 'tpope/vim-rails', {'for': 'ruby'}
"Plug 'sheerun/vim-polyglot', { 'do': './build' }
"Plug 'jiangmiao/auto-pairs'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

call plug#end()
" ------------------------------------------------------------------------
filetype plugin indent on

" Change the leader from \ to <Space>
let mapleader="\<Space>"

runtime macros/matchit.vim

" Custom commands ---------------------------------------------------------
" Beautify JSON
function! JsonFmt()
  %!python -m json.tool
  %s;^\(\s\+\);\=repeat(' ', len(submatch(0))/2);g
endfunction

command! JsonFmt :call JsonFmt()

" Settings ----------------------------------------------------------------------------------
" Disable equal always to avoid resizing splits automatically
"set noea
set equalalways


"  True colors
set termguicolors

" JsDoc
nmap <silent> <leader>jd <Plug>(jsdoc)

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
let g:tmux_navigator_no_mappings = 1
" Update changed buffer when switching to Tmux
let g:tmux_navigator_save_on_switch = 1

" Name tmux tabs after file open
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window 'vim | " . expand("%:t") . "'")


" Simpler split navigation in vim and tmux
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-p> :TmuxNavigatePrevious<cr>
if has('nvim') " https://github.com/neovim/neovim/issues/2048
  nmap <bs> :<c-u>TmuxNavigateLeft<cr>
endif


" Toggle text folding easily with F9
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" Plugins --------------------------------------------------------------------------------------
" Fugitive
" Split vertically
set diffopt+=vertical

" Enable deoplete
let g:deoplete#enable_at_startup = 1
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete
let g:deoplete#file#enable_buffer_path = 1
" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
autocmd BufEnter * set completeopt-=preview " Turn off autocomplete info buffer
" deoplete-typescript
let g:deoplete#sources#tss#javascript_support = 1

" deoplete + neosnippet + autopairs
let g:AutoPairsMapCR=0
let g:deoplete#enable_smart_case = 1
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.dotfiles/.vim/plugged/vim-snippets/snippets'

" Use markdown syntax for .md
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Neomake
" Autoreload changed files for eslint fix on file save
set autoread
autocmd BufEnter,FocusGained * checktime

let g:neomake_list_height = 2
let g:neomake_open_list = 2
let g:neomake_verbose = 0
let g:neomake_javascript_eslint_exe = './node_modules/.bin/eslint'
"let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_maker = {
    \ 'args': ['--fix', '--no-color', '--format', 'compact'],
    \ 'errorformat': '%f: line %l\, col %c\, %m'
    \ }

let g:flow#enable = 0
let g:neomake_javascript_enabled_makers = ['flow', 'eslint']
let g:neomake_jsx_enabled_makers = ['flow', 'eslint']


autocmd! BufWritePost * Neomake
autocmd! BufWritePost *.go GoTest

" vim-go
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_fmt_fail_silently = 1 " Let neomake show errors instead
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

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
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
nnoremap <leader>t :FZF!<CR>

" Denite.nvim
"Buffer switching
nnoremap <leader>b :Denite -quick-match buffer<cr>

" Vim Jedi
let g:jedi#popup_on_dot = 0

" GitGutter
" Performance optimization
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" Solarized theme
set background=dark
colorscheme NeoSolarized

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
"set t_Co=256

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
