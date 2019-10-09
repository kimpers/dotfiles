" Standard settings
"
set nocompatible              " be iMproved, required
syntax on

"Setup
call plug#begin('~/.local/share/nvim/plugged')

" Plugs to install
" General
Plug 'tpope/vim-fugitive'
Plug 'iCyMind/NeoSolarized'
Plug 'scrooloose/nerdtree'
Plug 'Lokaltog/vim-easymotion'
Plug 'sickill/vim-pasta'
Plug 'sjl/gundo.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'kana/vim-textobj-user'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'qpkorr/vim-bufkill'
Plug 'editorconfig/editorconfig-vim'
Plug 'bling/vim-airline'
Plug 'rking/ag.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'cohama/lexima.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'danro/rename.vim'
Plug 'tpope/vim-rhubarb'
Plug 'terryma/vim-multiple-cursors'
Plug 'metakirby5/codi.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Ruby
Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
Plug 'tpope/vim-endwise', {'for': 'ruby'}
Plug 'nelstrom/vim-textobj-rubyblock', {'for': 'ruby'}

" Javascript
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'styled-components/vim-styled-components', {'for': ['javascript', 'typescript', 'typescript.tsx']}

" Typescript
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }

" Golang
Plug 'fatih/vim-go', {'for': 'go'}

" CSS
Plug 'JulesWang/css.vim', {'for': 'css'}
Plug 'othree/csscomplete.vim', {'for': 'css'}
Plug 'ap/vim-css-color', {'for': 'css'}

" Python
Plug 'psf/black', {'for': 'python'}

" Other
Plug 'tomlion/vim-solidity', {'for': 'solidity'}
Plug 'hashivim/vim-terraform', {'for': 'terraform'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': 'markdown' }
Plug 'jparise/vim-graphql', {'for': ['graphql', 'javascript', 'typescript']}

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

" Git add current buffer
function! GitAddBuffer()
  w
  windo !git add %
endfunction
 
command! GitAddBuffer :call GitAddBuffer()

" :E to create a new file inside new folder(s)
function s:MKDir(...)
    if         !a:0 
           \|| isdirectory(a:1)
           \|| filereadable(a:1)
           \|| isdirectory(fnamemodify(a:1, ':p:h'))
        return
    endif
    return mkdir(fnamemodify(a:1, ':p:h'), 'p')
endfunction
command -bang -bar -nargs=? -complete=file E :call s:MKDir(<f-args>) | e<bang> <args>

command! RM :call delete(expand('%')) | bdelete!

" Settings ----------------------------------------------------------------------------------
" Disable equal always to avoid resizing splits automatically
"set noea
set equalalways


" True colors
set termguicolors

" JsDoc
nmap <silent> <leader>jd <Plug>(jsdoc)

" NeoVim handles ESC keys as alt+key, set this to solve the problem
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
set colorcolumn=100 "Show vertical line at 100 chars"
set noswapfile    " Turn off swap file

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
" black (python code formatting)
autocmd BufWritePre *.py execute ':Black'

" markdown-preview-nvim
" set to 1, nvim will open the preview window after entering the markdown buffer
let g:mkdp_auto_start = 0
" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
let g:mkdp_auto_close = 1

" Coc.nvim
let g:coc_global_extensions = ['coc-emoji', 'coc-eslint', 'coc-prettier', 'coc-tsserver','coc-tslint', 'coc-tslint-plugin', 'coc-css', 'coc-json', 'coc-pyls', 'coc-yaml', 'coc-stylelint']
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use `lp` and `ln` for navigate diagnostics
nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>lt <Plug>(coc-type-definition)
nmap <silent> <leader>li <Plug>(coc-implementation)
nmap <silent> <leader>lf <Plug>(coc-references)

" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Terraform
let g:terraform_fmt_on_save=1
" Codi
let g:codi#width = 50
let g:codi#rightalign = 0

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" Fugitive
" Split vertically
set diffopt+=vertical

" Use markdown syntax for .md
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

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

" Sort selected lines
vmap <leader>ss :'<,'>sort<CR>

" FZF
set rtp+=~/.fzf
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
nnoremap <leader>t :FZF!<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :GFiles?<CR>

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
au FileType text,tex,markdown,gitcommit setlocal wrap linebreak nolist spell spelllang=en_us

" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports 256 colours)
"set t_Co=256

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

" Python providers
let g:python3_host_prog = '/Users/kim/.pyenv/shims/python3'  " Python 3
