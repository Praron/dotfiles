if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-sensible'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'preservim/nerdcommenter'
Plug 'Krasjet/auto.pairs'
Plug 'tpope/vim-fugitive'

" Color schemes.
Plug 'junegunn/seoul256.vim'
Plug 'andreasvc/vim-256noir'
Plug 'ajmwagar/vim-deus'
Plug 'jacoborus/tender.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
call plug#end()

for f in glob('~/.config/nvim/config/*.vim', 0, 1)
    execute 'source' f
endfor

" Highlight trailing spaces.
:highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
:match ExtraWhitespace /\s\+$/
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

colo seoul256
set noshowmode

set iskeyword+=-
nnoremap <Space> <Nop>
let mapleader="\<Space>"
set mouse=a

" Changes swap file and gitgutter frequency.
set updatetime=500

set expandtab
set shiftwidth=2
set softtabstop=2

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

nnoremap <silent> gh :bp<CR>
nnoremap <silent> gl :bn<CR>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q
nnoremap <leader>/ :Lines<CR>

" Search by visual selected text.
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" WhichKey config.
set timeoutlen=500
highlight WhichKeyFloating cterm=NONE ctermfg=14 ctermbg=0 gui=NONE guifg=#93a1a1 guibg=#002931
nnoremap <silent> <leader> :WhichKey '<space>'<CR>
nnoremap <leader><leader> <leader>
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
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [[ 'githunks' ],
      \             [ 'percent' ],
      \             [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'GitBranchSliced',
      \   'githunks': 'GitStatus'
      \ },
      \ }

function GitBranchSliced()
  " let s = FugitiveHead()[-10:]
  " return s
  return FugitiveHead()[:25]
endfunction

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
" set statusline+=%{GitStatus()}

