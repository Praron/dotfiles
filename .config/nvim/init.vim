if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'jose-elias-alvarez/null-ls.nvim'
" Plug 'j-hui/fidget.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
" Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'dominikduda/vim_current_word'

Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'

" Plug 'ray-x/lsp_signature.nvim' " Doesn't work in st terminal :c
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'itchyny/lightline.vim'
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'
" Plug 'jremmen/vim-ripgrep'
Plug 'preservim/nerdcommenter'
" Plug 'jiangmiao/auto-pairs'
" Plug 'cohama/lexima.vim'
Plug 'mcchrish/nnn.vim'
Plug 'Yggdroot/indentLine'
Plug 'moll/vim-bbye' " :Bdelete and :Bwipeout
Plug 'folke/which-key.nvim'
" Plug 'folke/lsp-colors.nvim'
" Plug 'vim-scripts/tinykeymap'
" Plug 'storyn26383/vim-vue'
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'andys8/vim-elm-syntax'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-ui-select.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'David-Kunz/treesitter-unit'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

Plug 'airblade/vim-gitgutter'

Plug 'ggandor/leap.nvim'

" Text objects.
" Plug 'wellle/targets.vim'
" Plug 'kana/vim-textobj-user'
" Plug 'vimtaku/vim-textobj-keyvalue'  " k/v, doesn't seems to work.
" Plug 'glts/vim-textobj-indblock'  " o
" Plug 'deathlyfrantic/vim-textobj-blanklines'  " <space>
" Plug 'michaeljsmith/vim-indent-object' " i/I

" Color schemes.
Plug 'sainnhe/everforest'
"Plug 'christianchiarulli/nvcode-color-schemes.vim'
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
    " set t_ut=
endif

" set t_8f=^[[38;2;%lu;%lu;%lum
" set t_8b=^[[48;2;%lu;%lu;%lum
" set background=dark

" let g:nvcode_termcolors=256
" set t_Co=256
" set termguicolors

syntax on
" colorscheme nord
let g:everforest_background = 'hard'
colorscheme everforest

set laststatus=3

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
" let g:rg_highlight = 'true'

" FZF config.
" let g:fzf_command_prefix = 'Fzf'
" let g:fzf_preview_window = 'right:50%'
" let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.8 } }
" nnoremap gf  :FzfFiles<CR>
" nnoremap grg :FzfRg
" nnoremap gb  :FzfBuffers<CR>
" nnoremap g:  :FzfHistory:<CR>


nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fG <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
nnoremap <leader>fB <cmd>Telescope builtin<cr>
nnoremap <leader>f: <cmd>Telescope command_history<cr>
nnoremap gd <cmd>Telescope lsp_definitions<cr>
nnoremap gD <cmd>Telescope lsp_type_definitions<cr>
lua << EOF
require('telescope').setup{
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
      },
    },
  },
  defaults = {
    path_display={"smart"},
    layout_config = {
      horizontal = { width = 0.99, preview_width = 0.5 }
    },
  },
}
require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")
EOF


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
nnoremap <leader>bd :bdelete<CR>

" Search by visual selected text.
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>


let g:vim_current_word#highlight_twins = 1
let g:vim_current_word#highlight_current_word = 0


set completeopt=menu,menuone,noselect

set ignorecase
set smartcase

set autoindent
" set smartindent

set splitbelow
set splitright

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


noremap <leader>G :G<CR>


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
  \ 'colorscheme': 'everforest',
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
  \            ]
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
  \ },
  \ }
  " \              [ 'cocstatus' ]]
  " \   'cocstatus': 'coc#status'

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
" au Colorscheme * hi! link Conceal Number
" hi Conceal ctermfg=NONE
" hi Conceal ctermbg=NONE
" hi Conceal guifg=NONE
" hi Conceal guibg=NONE


lua << EOF
require('nvim-autopairs').setup{}

require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  },
  --ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gs",
      node_incremental = "i",
      scope_incremental = "I",
      node_decremental = "gd",
    },
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
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ab"] = "@parameter.outer",
        ["ib"] = "@parameter.inner",
      },
    },

    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]]"] = "@function.outer",
      },
      goto_next_end = {
        ["]["] = "@function.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
      },
      goto_previous_end = {
        ["[]"] = "@function.outer",
      },
    },

    indent = {
      enable = true
    },
  },
  context_commentstring = {
    enable = true
  },
}

require("null-ls").setup {
    sources = {
      --require("null-ls").builtins.formatting.prettierd.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
      require("null-ls").builtins.formatting.prettierd.with{
        disabled_filetypes={ "vue" }, -- TODO FIXME DELETEME
        env = {
          PRETTIERD_DEFAULT_CONFIG = vim.fn.expand "~/.config/prettierd/prettierrc.json",
        },
      },
      -- require("null-ls").builtins.diagnostics.eslint,
    },
    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        vim.cmd([[
        augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
        ]])
      end
    end,
}


local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
end)


-- require"fidget".setup{}

  require("which-key").setup {
    icons = {
      separator = '-'
      }
    }

  require('leap').set_default_keymaps()

EOF

set timeoutlen=500

xnoremap <silent> iu :lua require"treesitter-unit".select()<CR>
xnoremap <silent> au :lua require"treesitter-unit".select(true)<CR>
onoremap <silent> iu :<c-u>lua require"treesitter-unit".select()<CR>
onoremap <silent> au :<c-u>lua require"treesitter-unit".select(true)<CR>


" Fix for wrong yellow comments
highlight! Comment ctermfg=240 ctermbg=NONE gui=NONE cterm=NONE

" highlight! DiagnosticVirtualTextError ctermfg=131 ctermbg=NONE gui=NONE cterm=NONE


" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif
