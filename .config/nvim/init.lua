-- local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
-- if not vim.loop.fs_stat(lazypath) then
  -- vim.fn.system({
    -- 'git',
    -- 'clone',
    -- '--filter=blob:none',
    -- 'https://github.com/folke/lazy.nvim.git',
    -- '--branch=stable', -- latest stable release
    -- lazypath,
  -- })
-- end
-- vim.opt.rtp:prepend(lazypath)

-- vim.g.mapleader = ' '

function map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command) map('n', shortcut, command) end
function imap(shortcut, command) map('i', shortcut, command) end
function vmap(shortcut, command) map('v', shortcut, command) end
function xmap(shortcut, command) map('x', shortcut, command) end
function omap(shortcut, command) map('o', shortcut, command) end

require 'config.options'
require 'config.lazy'

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require 'config.autocmds'
    require 'config.keymaps'
  end,
})

-- vim.opt.showmode = false
-- vim.opt.syntax = 'on'

-- vim.opt.laststatus = 3

-- vim.cmd([[
-- set path+=**
-- set iskeyword+=-
-- ]])
-- vim.opt.mouse = 'a'

-- vim.opt.updatetime = 500

-- vim.opt.expandtab = true
-- vim.opt.shiftwidth = 2
-- vim.opt.softtabstop = 2


-- require('lazy').setup({
  -- 'nvim-lua/plenary.nvim',
  -- {
    -- 'neovim/nvim-lspconfig',
    -- opts = {
      -- format = { timeout_ms = 10000 },
    -- },
    -- config = function() end,
  -- },
  -- 'jose-elias-alvarez/nvim-lsp-ts-utils',
  -- {
    -- 'jose-elias-alvarez/null-ls.nvim',
    -- dependencies = { 'nvim-lua/plenary.nvim' },
    -- config = function()
      -- local null_ls = require'null-ls'
      -- null_ls.setup{
        -- sources = {
          -- null_ls.builtins.formatting.prettierd
          -- --.with{
            -- -- env = {
              -- -- PRETTIERD_DEFAULT_CONFIG = vim.fn.expand '~/.config/prettierd/prettierrc.json',
            -- -- },
        -- },
        -- on_attach = function(client, bufnr)
            -- if client.supports_method("textDocument/formatting") then
                -- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                -- vim.api.nvim_create_autocmd("BufWritePre", {
                    -- group = augroup,
                    -- buffer = bufnr,
                    -- callback = function()
                        -- vim.lsp.buf.format({ bufnr = bufnr })
                    -- end,
                -- })
            -- end
        -- end,
      -- }
    -- end
  -- },
  -- {
    -- 'williamboman/mason.nvim',
    -- build = ':MasonUpdate', -- :MasonUpdate updates registry contents
    -- config = function()
      -- require'mason'.setup()
    -- end
  -- },
  -- 'williamboman/mason-lspconfig.nvim',

  -- 'hrsh7th/cmp-nvim-lsp',
  -- 'hrsh7th/cmp-buffer',
  -- 'hrsh7th/cmp-path',
  -- 'hrsh7th/cmp-cmdline',
  -- 'hrsh7th/nvim-cmp',
  -- 'hrsh7th/cmp-vsnip',
  -- 'rafamadriz/friendly-snippets',
  -- 'hrsh7th/vim-vsnip',
  -- 'hrsh7th/vim-vsnip-integ',

  -- {
    -- 'dominikduda/vim_current_word',
    -- config = function()
     -- vim.g['vim_current_word#highlight_twins'] = 1
     -- vim.g['vim_current_word#highlight_current_word'] = 0
    -- end
  -- },

  -- 'windwp/nvim-autopairs',
  -- 'windwp/nvim-ts-autotag',

  -- 'kevinhwang91/promise-async',
  -- {
    -- 'kevinhwang91/nvim-ufo',
    -- config = function()
      -- local ufo = require('ufo')
      -- nmap('zR', ufo.openAllFolds)
      -- nmap('zM', ufo.closeAllFolds)
      -- ufo.setup({
        -- provider_selector = function(bufnr, filetype, buftype)
          -- return {'treesitter', 'indent'}
        -- end
      -- })
    -- end
  -- },

  -- 'kevinhwang91/nvim-bqf',
  -- 'junegunn/fzf',
  -- 'junegunn/fzf.vim',

  -- 'tpope/vim-sensible',
  -- 'tpope/vim-surround',
  -- {
    -- 'tpope/vim-fugitive',
    -- config = function()
      -- nmap('<leader>G', ':G<cr>')
    -- end
  -- },
  -- 'tpope/vim-vinegar',
  -- {
    -- 'nvim-lualine/lualine.nvim',
    -- opts = {
      -- options = {
        -- icons_enabled = false,
        -- component_separators = '',
        -- section_separators = '',
      -- },
      -- sections = {
        -- lualine_a = {
          -- {
            -- 'mode',
            -- fmt = string.lower,
            -- -- separator = { left = '' },
          -- },
        -- },
        -- lualine_b = {
          -- {
            -- 'branch',
          -- },
          -- {
            -- 'diff',
            -- colored = false,
          -- },
          -- {
            -- 'filename',
            -- file_status = true,
            -- newfile_status = false,
            -- path = 1,
            -- shorting_target = 40,
            -- symbols = {
              -- modified = '[+]',
              -- readonly = '[-]',
              -- unnamed = '[No Name]',
              -- newfile = '[New]',
            -- },
            -- separator = { right = '' },
          -- },
        -- },
        -- lualine_c = {
        -- },
        -- lualine_x = {
        -- },
        -- lualine_y = {
          -- {
            -- 'diagnostics',
            -- separator = { left = '' },
            -- draw_empty = true,
          -- },
        -- },
        -- lualine_z = {
          -- {
            -- function()
              -- if vim.fn.winwidth(0) < 86 then return '' end
              -- local current_line = string.format('%3d', vim.fn.line('.'))
              -- local max_line = string.format('%3d', vim.fn.line('$'))
              -- local col = vim.fn.virtcol('.')
              -- local lineinfo = current_line .. '/' .. max_line .. ':' .. col
              -- return lineinfo
            -- end,
            -- -- separator = { right = '' },
        -- },
        -- },
      -- },
    -- },
    -- config = function(_, opts)
      -- local custom_theme = require'lualine.themes.auto'
      -- local colors = require'tokyonight.colors'.setup({ transform = true })
      -- custom_theme.normal.c.bg = colors.bg
      -- opts.options.theme = custom_theme
      -- require'lualine'.setup(opts)
    -- end,
  -- },
  -- {
    -- 'preservim/nerdcommenter',
    -- config = function()
      -- -- Add spaces after comment delimiters by default
      -- vim.g.NERDSpaceDelims = 1
      -- -- Use compact syntax for prettified multi-line comments
      -- vim.g.NERDCompactSexyComs = 1
    -- end
  -- },

  -- {
    -- 'mcchrish/nnn.vim',
    -- opts = {
      -- layout = { window = { width = 1, height = 0.8 } },
      -- set_default_mappings = 0,
      -- command = 'nnn -o',
      -- replace_netrw = 1,
    -- },
    -- config = function(_, opts)
      -- require('nnn').setup(opts)
      -- nmap('<leader>n', ':NnnPicker %:p:h<cr>')
      -- nmap('<leader>N', ':NnnPicker<cr>')
    -- end
  -- },
  -- {
    -- 'Yggdroot/indentLine',
    -- config = function()
      -- vim.g.indentLine_char = '│'
      -- vim.g.indentLine_showFirstIndentLevel = 1
      -- vim.g.indentLine_first_char = '│'
      -- vim.g.indentLine_defaultGroup = 'NonText'
      -- vim.g.vim_json_conceal = 0
    -- end
  -- },
  -- 'moll/vim-bbye', -- :Bdelete and :Bwipeout
  -- {
    -- 'folke/which-key.nvim',
    -- opts = {
      -- icons = {
        -- separator = '-'
      -- }
    -- }
  -- },
  -- 'folke/lsp-colors.nvim',

  -- {
    -- 'nvim-telescope/telescope.nvim',
    -- dependencies = { 'nvim-lua/plenary.nvim' },
    -- config = function()
      -- local telescope = require('telescope.builtin')
      -- nmap('<leader>ff', telescope.find_files)
      -- nmap('<leader>fg', telescope.live_grep)
      -- nmap('<leader>fG', telescope.grep_string)
      -- nmap('<leader>fb', telescope.buffers)
      -- nmap('<leader>fh', telescope.help_tags)
      -- nmap('<leader>fr', telescope.lsp_references)
      -- nmap('<leader>fB', telescope.builtin)
      -- nmap('<leader>f:', telescope.command_history)
      -- nmap('gd'        , telescope.lsp_definitions)
      -- nmap('gD'        , telescope.lsp_type_definitions)
      -- require('telescope').setup{
        -- extensions = {
          -- ['ui-select'] = {
            -- require('telescope.themes').get_dropdown {},
          -- },
        -- },
        -- defaults = {
          -- path_display={'smart'},
          -- layout_config = {
            -- horizontal = { width = 0.99, preview_width = 0.5 }
          -- },
        -- },
      -- }
      -- require('telescope').load_extension('fzf')
      -- require('telescope').load_extension('ui-select')
    -- end,
  -- },
  -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  -- 'nvim-telescope/telescope-ui-select.nvim',

  -- {
    -- 'nvim-treesitter/nvim-treesitter',
    -- build = ':TSUpdate',
    -- opts = {
      -- autotag = {
        -- enable = true,
      -- },
      -- highlight = {
        -- enable = true, -- false will disable the whole extension
      -- },
      -- incremental_selection = {
        -- enable = true,
        -- keymaps = {
          -- init_selection = 'gs',
          -- node_incremental = 'i',
          -- scope_incremental = 'I',
          -- node_decremental = 'gd',
        -- },
      -- },
      -- textobjects = {
        -- select = {
          -- enable = true,

          -- -- Automatically jump forward to textobj, similar to targets.vim
          -- lookahead = true,

          -- keymaps = {
            -- -- You can use the capture groups defined in textobjects.scm
            -- ['af'] = '@function.outer',
            -- ['if'] = '@function.inner',
            -- ['ac'] = '@class.outer',
            -- ['ic'] = '@class.inner',
            -- ['aa'] = '@parameter.outer',
            -- ['ia'] = '@parameter.inner',
            -- ['ab'] = '@parameter.outer',
            -- ['ib'] = '@parameter.inner',
          -- },
        -- },

        -- move = {
          -- enable = true,
          -- set_jumps = true, -- whether to set jumps in the jumplist
          -- goto_next_start = {
            -- [']]'] = '@function.outer',
          -- },
          -- goto_next_end = {
            -- [']['] = '@function.outer',
          -- },
          -- goto_previous_start = {
            -- ['[['] = '@function.outer',
          -- },
          -- goto_previous_end = {
            -- ['[]'] = '@function.outer',
          -- },
        -- },

        -- indent = {
          -- enable = true
        -- },
      -- },
      -- context_commentstring = {
        -- enable = true
      -- },
    -- }
  -- },
  -- 'nvim-treesitter/nvim-treesitter-context',
  -- 'nvim-treesitter/nvim-treesitter-textobjects',
  -- {
    -- 'David-Kunz/treesitter-unit',
    -- config = function()
      -- local unit = require'treesitter-unit'
      -- xmap('iu', function() unit.select() end)
      -- xmap('au', function() unit.select(true) end)
      -- omap('iu', function() unit.select() end)
      -- omap('au', function() unit.select(true) end)
    -- end
  -- },
  -- 'JoosepAlviste/nvim-ts-context-commentstring',
  -- 'airblade/vim-gitgutter',
  -- {
    -- 'ggandor/leap.nvim',
    -- config = function()
      -- require('leap').set_default_keymaps()
    -- end
  -- },
  -- 'echasnovski/mini.nvim',
  -- {
    -- 'brenoprata10/nvim-highlight-colors',
    -- opts = { enable_named_colors = false }
  -- },
  --[[ {
     [   'sainnhe/everforest',
     [   lazy = false,
     [   priority = 1000,
     [   config = function()
     [     vim.g.everforest_background = 'hard'
     [     vim.g.everforest_diagnostic_virtual_text = 'colored'
     [     vim.g.everforest_diagnostic_line_highlight = '1'
     [     vim.cmd.colorscheme('everforest')
     [   end,
     [ }, ]]
  -- {
    -- 'folke/tokyonight.nvim',
    -- lazy = false,
    -- priority = 1000,
    -- opts = {
      -- style = 'night',
       -- styles = {
        -- comments = { italic = false },
        -- keywords = { italic = false },
      -- },
      -- on_highlights = function(hl, c)
        -- local prompt = '#2d3149'
        -- hl.TelescopeNormal = {
          -- bg = c.bg_dark,
          -- fg = c.fg_dark,
        -- }
        -- hl.TelescopeBorder = {
          -- bg = c.bg_dark,
          -- fg = c.bg_dark,
        -- }
        -- hl.TelescopePromptNormal = {
          -- bg = prompt,
        -- }
        -- hl.TelescopePromptBorder = {
          -- bg = prompt,
          -- fg = prompt,
        -- }
        -- hl.TelescopePromptTitle = {
          -- bg = prompt,
          -- fg = prompt,
        -- }
        -- hl.TelescopePreviewTitle = {
          -- bg = c.bg_dark,
          -- fg = c.bg_dark,
        -- }
        -- hl.TelescopeResultsTitle = {
          -- bg = c.bg_dark,
          -- fg = c.bg_dark,
        -- }
      -- end,
    -- },
    -- config = function(_, opts)
      -- require'tokyonight'.setup(opts)
      -- vim.cmd.colorscheme('tokyonight')
    -- end,
  -- },
-- })


-- nmap('<leader>w', ':w<cr>')
-- nmap('<leader>q', ':q')
-- nmap('<leader>bd', ':Bdelete<cr>')

-- -- System clipboard support.
-- nmap('<leader>y', '"*y')
-- nmap('<leader>p', '"*p')

-- -- Disable search highlght by Esc.
-- nmap('<esc>', ':noh<cr>')

-- -- Don't use Ex mode, use Q for formatting.
-- nmap('Q', 'gq')

-- -- Search by visual selected text.
-- vmap('//', [[y/\V<C-R>=escape(@','/\')<CR><CR>]])

-- vim.opt.completeopt = { 'menu',  'menuone', 'noselect' }

-- vim.opt.ignorecase = true
-- vim.opt.smartcase = true
-- vim.opt.autoindent = true

-- vim.opt.splitbelow = true
-- vim.opt.splitright = true

-- vim.o.foldcolumn = '0' -- '0' is not bad
-- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.o.foldlevelstart = 99
-- vim.o.foldenable = true

-- vim.o.timeoutlen=500

-- if vim.fn.has('termguicolors') == 1 then
  -- vim.o.termguicolors = true
  -- vim.cmd('hi LineNr ctermbg=NONE guibg=NONE')
-- end


-- local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
-- local autocmd = vim.api.nvim_create_autocmd -- Create autocommand


-- -- Highlight on yank
-- augroup('YankHighlight', { clear = true })
-- autocmd('TextYankPost', {
  -- group = 'YankHighlight',
  -- callback = function()
    -- vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '100' })
  -- end
-- })


-- -- Remove whitespace on save
-- autocmd('BufWritePre', {
  -- pattern = '',
  -- command = ':%s/\\s\\+$//e'
-- })


-- vim.cmd([[
-- set number relativenumber
-- augroup numbertoggle
  -- autocmd!
  -- autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  -- autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
-- augroup END
-- ]])


-- vim.cmd([[
-- augroup vimstartup
  -- au!
  -- " when editing a file, always jump to the last known cursor position.
  -- " don't do it when the position is invalid, when inside an event handler
  -- " (happens when dropping a file on gvim) and for a commit message (it's
  -- " likely a different one than last time).
  -- autocmd bufreadpost *
    -- \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    -- \ |   exe "normal! g`\""
    -- \ | endif
-- augroup end
-- ]])


-- vim.cmd([[
-- " Highlight trailing spaces.
-- :highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
-- :match ExtraWhitespace /\s\+$/
-- :autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
-- ]])
