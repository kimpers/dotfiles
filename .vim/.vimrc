" Standard settings
"
set nocompatible              " be iMproved, required
syntax on

"Setup
call plug#begin('~/.local/share/nvim/plugged')

" Plugs to install
" General
Plug 'Lokaltog/vim-easymotion'
Plug 'sickill/vim-pasta'
Plug 'sjl/gundo.vim'
Plug 'kana/vim-textobj-user'
Plug 'rhysd/vim-textobj-conflict'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
Plug 'qpkorr/vim-bufkill'
Plug 'rking/ag.vim'
Plug 'junegunn/vim-easy-align'
Plug 'danro/rename.vim'
Plug 'tpope/vim-rhubarb'

" Git
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-abolish'

" Nvim cli only
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

Plug 'terryma/vim-multiple-cursors', Cond(!exists('g:vscode'))
Plug 'iCyMind/NeoSolarized', Cond(!exists('g:vscode'))
Plug 'scrooloose/nerdtree', Cond(!exists('g:vscode'))
Plug 'scrooloose/nerdcommenter', Cond(!exists('g:vscode'))
Plug 'nathanaelkane/vim-indent-guides', Cond(!exists('g:vscode'))
Plug 'editorconfig/editorconfig-vim', Cond(!exists('g:vscode'))
Plug 'bling/vim-airline', Cond(!exists('g:vscode'))
Plug 'vim-airline/vim-airline-themes', Cond(!exists('g:vscode'))
Plug 'dyng/ctrlsf.vim', Cond(!exists('g:vscode'))
Plug 'christoomey/vim-tmux-navigator', Cond(!exists('g:vscode'))
Plug 'metakirby5/codi.vim', Cond(!exists('g:vscode'))
Plug 'neoclide/coc.nvim', Cond(!exists('g:vscode'), {'branch': 'release', 'do': 'CoCUpdate'})
Plug 'junegunn/fzf.vim', Cond(!exists('g:vscode'))
Plug 'yardnsm/vim-import-cost', Cond(!exists('g:vscode'), { 'do': 'npm install' })
Plug 'voldikss/vim-floaterm', Cond(!exists('g:vscode'))
Plug 'github/copilot.vim', Cond(!exists('g:vscode'))
Plug 'puremourning/vimspector', Cond(!exists('g:vscode'))
Plug 'nvim-treesitter/nvim-treesitter', Cond(!exists('g:vscode'), {'do': ':TSUpdate'})
Plug 'David-Kunz/gen.nvim', Cond(!exists('g:vscode'))
"Git
Plug 'airblade/vim-gitgutter', Cond(!exists('g:vscode'))
Plug 'jreybert/vimagit', Cond(!exists('g:vscode'))
" Javascript
Plug 'pangloss/vim-javascript', Cond(!exists('g:vscode'), {'for': 'javascript'})

" Typescript
Plug 'HerringtonDarkholme/yats.vim', Cond(!exists('g:vscode'), { 'for': 'typescript' })

" Golang
Plug 'fatih/vim-go', Cond(!exists('g:vscode'), {'for': 'go'})

" CSS
Plug 'JulesWang/css.vim', Cond(!exists('g:vscode'), {'for': 'css'})
Plug 'othree/csscomplete.vim', Cond(!exists('g:vscode'), {'for': 'css'})
Plug 'ap/vim-css-color', Cond(!exists('g:vscode'), {'for': 'css'})

" Python
Plug 'psf/black', Cond(!exists('g:vscode'), {'for': 'python'})

" Rust
"Plug 'rust-lang/rust.vim', { 'for': 'rust' }, Cond(!exists('g:vscode'))
Plug 'mattn/webapi-vim', Cond(!exists('g:vscode'))

" Other
Plug 'tomlion/vim-solidity', Cond(!exists('g:vscode'), {'for': 'solidity'})
Plug 'hashivim/vim-terraform', Cond(!exists('g:vscode'), {'for': 'terraform'})
Plug 'iamcco/markdown-preview.nvim', Cond(!exists('g:vscode'), { 'do': 'cd app & yarn install', 'for': 'markdown' })
Plug 'jparise/vim-graphql' , Cond(!exists('g:vscode'), {'for': ['graphql', 'javascript', 'typescript']})
Plug 'jxnblk/vim-mdx-js', Cond(!exists('g:vscode'), {'for': ['markdown', 'markdown.mdx']})

call plug#end()
" ------------------------------------------------------------------------
filetype plugin indent on

" Change the leader from \ to <Space>
let mapleader="\<Space>"

" Custom commands ---------------------------------------------------------
" Beautify JSON
function! JsonFmt()
  %!python -m json.tool
  %s;^\(\s\+\);\=repeat(' ', len(submatch(0))/2);g
endfunction

command! JsonFmt :call JsonFmt()

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
" Enable English spell check
set spell spelllang=en_us

" Disable equal always to avoid resizing splits automatically
"set noea
set equalalways


" True colors
set termguicolors

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
" Easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" Align markdown tables with vip + |
au FileType markdown,conf,markdown.mdx map <Bar> vip :EasyAlign*<Bar><Enter>

" Vim-surround
" Python providers
"let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '~/.pyenv/shims/python3'
let g:ruby_host_prog = '/opt/homebrew/opt/ruby/bin/ruby'

"  nvim only
if !exists('g:vscode')
  " IndentGuides
  au VimEnter * IndentGuidesEnable

  " gen.nvim
  nnoremap <silent> <leader>gm :lua require('gen').select_model()<CR>
  nnoremap <silent> <leader>gg :Gen<CR>

  " vimspector
  let g:vimspector_enable_mappings = 'HUMAN'
  " for normal mode - the word under the cursor
  nmap <Leader>di <Plug>VimspectorBalloonEval
  " for visual mode, the visually selected text
  xmap <Leader>di <Plug>VimspectorBalloonEval


  " rust.vim
  let g:rust_clip_command = 'pbcopy'
  " Run test under cursor with prints
  nnoremap <silent> <leader>rtc :RustTest -- --nocapture<CR>
  " Run all project tests with prints
  nnoremap <silent> <leader>rt :RustTest! -- --nocapture<CR>
  " vim-floaterm
  let g:floaterm_gitcommit = 'vsplit'
  let g:floaterm_keymap_toggle = '<leader>ft'
  " vim-import-cost
  " Check import costs on save
  nnoremap <silent> <leader>ic :ImportCost<CR>
  nnoremap <silent> <leader>icc :ImportCostClear<CR>

  " Magit
  autocmd User VimagitEnterCommit setlocal textwidth=72
  autocmd User VimagitLeaveCommit setlocal textwidth=0

  " black (python code formatting)
  autocmd BufWritePre *.py execute ':Black'

  " markdown-preview-nvim
  " set to 1, nvim will open the preview window after entering the markdown buffer
  let g:mkdp_auto_start = 0

  " Coc.nvim
  let g:coc_global_extensions = ['coc-emoji', 'coc-eslint', 'coc-prettier', 'coc-tsserver', 'coc-css', 'coc-json', 'coc-pyls', 'coc-yaml', 'coc-stylelint', 'coc-styled-components', 'coc-rust-analyzer', 'coc-pairs', 'coc-spell-checker']
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

  " Accept autocompletion with <CR>
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Terraform
  let g:terraform_fmt_on_save=1
  " Codi
  let g:codi#width = 50
  let g:codi#rightalign = 0

  " vim-javascript
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

  " Gopls
  autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

  " vim-airline
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1


  " Smarter search
  let g:ctrlsf_backend = 'rg'
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
  set rtp+=/opt/homebrew/opt/fzf
  let $FZF_DEFAULT_COMMAND = 'rg -l ""'
  nnoremap <leader>t :FZF!<CR>
  nnoremap <leader>b :Buffers<CR>
  nnoremap <leader>g :GFiles?<CR>

  " GitGutter
  " Performance optimization
  let g:gitgutter_realtime = 0
  let g:gitgutter_eager = 0

  " Solarized theme
  set background=light
  colorscheme NeoSolarized

  " Markdown, text and latex specific settings
  au FileType text,tex,markdown,gitcommit setlocal wrap linebreak nolist spell spelllang=en_us

  " Always show statusline
  set laststatus=2
  " Use 256 colours (Use this setting only if your terminal supports 256 colours)
  "set t_Co=256


  " Highlight matching bracket/parantheses
  runtime macros/matchit.vim
  autocmd vimenter * DoMatchParen
endif
