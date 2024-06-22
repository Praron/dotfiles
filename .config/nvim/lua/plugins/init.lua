local function map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end
local function imap(shortcut, command)
  map('i', shortcut, command)
end
local function vmap(shortcut, command)
  map('v', shortcut, command)
end
local function xmap(shortcut, command)
  map('x', shortcut, command)
end
local function omap(shortcut, command)
  map('o', shortcut, command)
end

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

return {
  'nvim-lua/plenary.nvim',
  {
    'neovim/nvim-lspconfig',
    -- config = function() end,
  },
  'jose-elias-alvarez/nvim-lsp-ts-utils',

  {
    'dominikduda/vim_current_word',
    config = function()
      vim.g['vim_current_word#highlight_twins'] = 1
      vim.g['vim_current_word#highlight_current_word'] = 0
    end,
  },

  'windwp/nvim-autopairs',
  'windwp/nvim-ts-autotag',

  'kevinhwang91/promise-async',
  {
    'kevinhwang91/nvim-ufo',
    config = function()
      local ufo = require('ufo')
      nmap('zR', ufo.openAllFolds)
      nmap('zM', ufo.closeAllFolds)
      ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      })
    end,
  },

  'kevinhwang91/nvim-bqf',
  'junegunn/fzf',
  'junegunn/fzf.vim',

  'tpope/vim-sensible',
  -- 'tpope/vim-surround',
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    'tpope/vim-fugitive',
    config = function()
      nmap('<leader>G', ':G<cr>')
    end,
  },
  'tpope/vim-vinegar',
  --[[ {
     [   'preservim/nerdcommenter',
     [   config = function()
     [     -- Add spaces after comment delimiters by default
     [     vim.g.NERDSpaceDelims = 1
     [     -- Use compact syntax for prettified multi-line comments
     [     vim.g.NERDCompactSexyComs = 1
     [   end,
     [ }, ]]
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
  },

  'andymass/vim-matchup',

  {
    'mcchrish/nnn.vim',
    opts = {
      layout = { window = { width = 1, height = 0.8 } },
      set_default_mappings = 0,
      command = 'nnn -o',
      replace_netrw = 1,
    },
    config = function(_, opts)
      require('nnn').setup(opts)
      nmap('<leader>n', ':NnnPicker %:p:h<cr>')
      nmap('<leader>N', ':NnnPicker<cr>')
    end,
  },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
  'moll/vim-bbye', -- :Bdelete and :Bwipeout
  {
    'folke/which-key.nvim',
    opts = {
      icons = {
        separator = '-',
      },
    },
  },
  'folke/lsp-colors.nvim',

  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope.builtin')
      nmap('<leader>ff', telescope.find_files)
      nmap('<leader>fg', telescope.live_grep)
      nmap('<leader>fG', telescope.grep_string)
      nmap('<leader>fb', telescope.buffers)
      nmap('<leader>fh', telescope.help_tags)
      nmap('<leader>fr', telescope.lsp_references)
      nmap('<leader>fB', telescope.builtin)
      nmap('<leader>f:', telescope.command_history)
      nmap('gd', telescope.lsp_definitions)
      nmap('gD', telescope.lsp_type_definitions)

      local actions = require('telescope.actions')
      local open_with_trouble = require('trouble.sources.telescope').open
      require('telescope').setup({
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({}),
          },
        },
        defaults = {
          path_display = { 'smart' },
          layout_config = {
            horizontal = { width = 0.99, preview_width = 0.5 },
          },
          file_ignore_patterns = { 'package%-lock.json' },
          mappings = {
            i = { ['<c-t>'] = open_with_trouble },
            n = { ['<c-t>'] = open_with_trouble },
          },
        },
      })
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('ui-select')
    end,
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'nvim-telescope/telescope-ui-select.nvim',

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        autotag = {
          enable = true,
        },
        highlight = {
          enable = true, -- false will disable the whole extension
        },
        matchup = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = 'v',
            node_decremental = 'V',
          },
        },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              -- ['af'] = '@function.outer',
              -- ['if'] = '@function.inner',
              -- ['ac'] = '@class.outer',
              -- ['ic'] = '@class.inner',
              -- ['aa'] = '@parameter.outer',
              -- ['ia'] = '@parameter.inner',
              -- ['ab'] = '@parameter.outer',
              -- ['ib'] = '@parameter.inner',
            },
          },

          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']]'] = '@function.outer',
            },
            goto_next_end = {
              [']['] = '@function.outer',
            },
            goto_previous_start = {
              ['[['] = '@function.outer',
            },
            goto_previous_end = {
              ['[]'] = '@function.outer',
            },
          },

          indent = {
            enable = true,
          },
        },
      })
    end,
  },
  'nvim-treesitter/nvim-treesitter-context',
  'nvim-treesitter/nvim-treesitter-textobjects',
  {
    'David-Kunz/treesitter-unit',
    config = function()
      local unit = require('treesitter-unit')
      xmap('iu', function()
        unit.select()
      end)
      xmap('au', function()
        unit.select(true)
      end)
      omap('iu', function()
        unit.select()
      end)
      omap('au', function()
        unit.select(true)
      end)
    end,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  'airblade/vim-gitgutter',
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').set_default_keymaps()
    end,
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup()
    end,
  },
  {
    'brenoprata10/nvim-highlight-colors',
    opts = { enable_named_colors = false },
  },
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
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'night',
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },
      on_highlights = function(hl, c)
        local prompt = '#2d3149'
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
      end,
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme('tokyonight')
    end,
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>xs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>xl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
  --[[   {
   [     'folke/noice.nvim',
   [     event = 'VeryLazy',
   [     opts = {
   [       -- add any options here
   [     },
   [     dependencies = {
   [       -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
   [       'MunifTanjim/nui.nvim',
   [       -- OPTIONAL:
   [       --   `nvim-notify` is only needed, if you want to use the notification view.
   [       --   If not available, we use `mini` as the fallback
   [       'rcarriga/nvim-notify',
   [     },
   [     config = function()
   [       vim.opt.cmdheight = 0
   [       require('noice').setup({
   [
   [         cmdline = {
   [           enabled = true,
   [           view = 'cmdline_popup',
   [           opts = {},
   [           format = {
   [             -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
   [             -- view: (default is cmdline view)
   [             -- opts: any options passed to the view
   [             -- icon_hl_group: optional hl_group for the icon
   [             -- title: set to anything or empty string to hide
   [             cmdline = { pattern = '^:', icon = '', lang = 'vim' },
   [             search_down = { kind = 'search', pattern = '^/', icon = '', lang = 'regex' },
   [             search_up = { kind = 'search', pattern = '^%?', icon = '', lang = 'regex' },
   [             filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
   [             lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
   [             help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
   [             input = { view = 'cmdline_input', icon = '󰥻 ' }, -- Used by input()
   [           },
   [         },
   [
   [         routes = {
   [           {
   [             filter = {
   [               event = 'msg_show',
   [               kind = '',
   [               find = 'written',
   [             },
   [             opts = { skip = true },
   [           },
   [         },
   [
   [         lsp = {
   [           -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
   [           override = {
   [             ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
   [             ['vim.lsp.util.stylize_markdown'] = true,
   [             ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
   [           },
   [         },
   [         -- you can enable a preset for easier configuration
   [         presets = {
   [           -- bottom_search = true, -- use a classic bottom cmdline for search
   [           -- command_palette = true, -- position the cmdline and popupmenu together
   [           long_message_to_split = true, -- long messages will be sent to a split
   [           inc_rename = false, -- enables an input dialog for inc-rename.nvim
   [           lsp_doc_border = true, -- add a border to hover docs and signature help
   [         },
   [       })
   [     end,
   [   }, ]]
}
