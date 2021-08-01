if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'preservim/nerdcommenter'
Plug 'Krasjet/auto.pairs'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'mcchrish/nnn.vim'
Plug 'Yggdroot/indentLine'
" Plug 'vim-scripts/tinykeymap'
" Plug 'storyn26383/vim-vue'
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'andys8/vim-elm-syntax'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Text objects.
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'vimtaku/vim-textobj-keyvalue'  " k/v, doesn't seems to work.
Plug 'glts/vim-textobj-indblock'  " o
Plug 'deathlyfrantic/vim-textobj-blanklines'  " <space>
Plug 'michaeljsmith/vim-indent-object' " i/I

" Color schemes.
" Plug 'junegunn/seoul256.vim'
" Plug 'andreasvc/vim-256noir'
" Plug 'ajmwagar/vim-deus'
" Plug 'jacoborus/tender.vim'
" Plug 'joshdick/onedark.vim'
" Plug 'morhetz/gruvbox'
" Plug 'sheerun/vim-wombat-scheme'
" Plug 'arcticicestudio/nord-vim'
" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'airblade/vim-gitgutter'
Plug 'christianchiarulli/nvcode-color-schemes.vim'
call plug#end()

for f in glob('~/.config/nvim/config/*.vim', 0, 1)
    execute 'source' f
endfor

" disable netrw
let loaded_netrwPlugin = 1
" Otherwise I can't close stupid netrw buffers.
" let g:netrw_fastbrowse = 0

" Highlight trailing spaces.
:highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
:match ExtraWhitespace /\s\+$/
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

set noshowmode

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also https://sunaku.github.io/vim-256color-bce.html
    set t_ut=
endif

set t_8f=^[[38;2;%lu;%lu;%lum
set t_8b=^[[48;2;%lu;%lu;%lum
set background=dark
" colorscheme nord
set t_Co=256
set termguicolors

set path+=**
set iskeyword+=-
nnoremap <Space> <Nop>
let mapleader="\<Space>"
set mouse=a
" set hidden
autocmd BufEnter * :syntax sync fromstart

" Changes swap file and gitgutter frequency.
set updatetime=500

set expandtab
set shiftwidth=2
set softtabstop=2

autocmd FileType elm setlocal softtabstop=4 shiftwidth=4 expandtab
let g:elm_setup_keybindings = 0

set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Buffer change.
" nnoremap gb :ls<CR>:b<space>

" Rg config.
let g:rg_highlight = 'true'

" FZF config.
let g:fzf_command_prefix = 'Fzf'
let g:fzf_preview_window = 'down:30%'
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.8 } }
nnoremap gf  :FzfFiles<CR>
nnoremap grg :FzfRg
nnoremap gb  :FzfBuffers<CR>
nnoremap g:  :FzfHistory:<CR>


" DELETEME: dirty hack because I broke autofixOnSave :c
" nnoremap <leader>f :CocCommand eslint.executeAutofix<CR>


let g:nnn#set_default_mappings = 0
let g:nnn#layout = { 'window': { 'width': 1, 'height': 0.8 } }
nnoremap <leader>n :NnnPicker %:p:h<CR>
nnoremap <leader>N :NnnPicker<CR>
let g:nnn#command = 'nnn -o'

" Switch to prev/next buffer
nnoremap <silent> gh :bp<CR>
nnoremap <silent> gl :bn<CR>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q
nnoremap <leader>/ :Lines<CR>
nnoremap <leader>bd :bd<CR>

" Search by visual selected text.
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" WhichKey config.
" set timeoutlen=500
" highlight WhichKeyFloating cterm=NONE ctermfg=14 ctermbg=0 gui=NONE guifg=#93a1a1 guibg=#002931
" nnoremap <silent> <leader> :WhichKey '<space>'<CR>
" nnoremap <leader><leader> <leader>
" nnoremap <silent> g :WhichKey 'g'<CR>

set ignorecase
set smartcase

" Auto watch external file changes.
set autoread
au CursorHold,CursorHoldI * checktime

" System clipboard support.
noremap <leader>y "+y
noremap <leader>p "+p

" Disable search highlght by Esc.
nnoremap <silent> <esc> :noh<CR>

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" Select to visual mode pasted/edited text.
nnoremap gp `[v`]


" Put these in an autocmd group, so that you can revert them with:
" ":augroup vimStartup | au! | augroup END"
augroup vimStartup
  au!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid, when inside an event handler
  " (happens when dropping a file on gvim) and for a commit message (it's
  " likely a different one than last time).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup END


" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1


let g:lightline = {
  \ 'colorscheme': 'nord',
  \ 'tabline': {
  \   'left': [ [ 'tabs' ] ],
  \   'right': [ [] ]
  \ },
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filepath', 'modified' ] ],
  \   'right': [ [ 'githunks' ],
  \              [ 'lineinfo' ],
  \              [ 'filetype' ],
  \              [ 'cocstatus' ]]
  \ },
  \ 'inactive': {
  \  'left': [ [ 'readonly', 'filename', 'modified' ] ],
  \  'right': [ [] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'GitBranchSliced',
  \   'githunks': 'GitStatus',
  \   'lineinfo': 'LightlineLineinfo',
  \   'filepath': 'LightlineFilepath',
  \   'cocstatus': 'coc#status'
  \ },
  \ }

function! LightlineFilepath()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

function! LightlineLineinfo() abort
  if winwidth(0) < 86
      return ''
  endif

  let l:current_line = printf('%3d', line('.'))
  let l:max_line = printf('%3d', line('$'))
  let l:col = virtcol('.')
  let l:lineinfo = l:current_line . '/' . l:max_line . ':' . l:col
  return l:lineinfo
endfunction

function GitBranchSliced()
  return substitute(FugitiveHead(), "Remizov/", "R/", "")[:25]
endfunction

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
" set statusline+=%{GitStatus()}


command! Gtvdiff tabedit %|Gvdiff


function! CleanNoNameEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
    if !empty(buffers)
        exe 'bd '.join(buffers, ' ')
    else
        echo 'No buffer deleted'
    endif
endfunction
command! CleanNoNameBuffers call CleanNoNameEmptyBuffers()


" let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_char = '│'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_first_char = '│'
" let g:indentLine_setColors = 0
let g:indentLine_defaultGroup = 'NonText'

" Some fixes for nord conceal colors.
au Colorscheme * hi! link Conceal Number
hi Conceal ctermfg=NONE
hi Conceal ctermbg=NONE
hi Conceal guifg=NONE
hi Conceal guibg=NONE



" configure treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        },
      },
    },
  },
}
EOF

" configure nvcode-color-schemes
let g:nvcode_termcolors=256

syntax on
colorscheme nord
" Fix for wrong yellow comments
highlight! Comment ctermfg=240 ctermbg=NONE gui=NONE cterm=NONE

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

