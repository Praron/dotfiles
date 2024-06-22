return {
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
      { 'folke/neodev.nvim', config = true },
      { 'j-hui/fidget.nvim', config = true },
      { 'smjonas/inc-rename.nvim', config = true },
      'simrat39/rust-tools.nvim',
      'rust-lang/rust.vim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    config = function(plugin)
      require('plugins.lsp.servers').setup(plugin)
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate', -- :MasonUpdate updates registry contents
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    ensure_installed = {
      'stylua',
      'ruff',
    },
    config = function(plugin)
      require('mason').setup()
      local mr = require('mason-registry')
      for _, tool in ipairs(plugin.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPre',
    dependencies = { 'mason.nvim' },
    config = function()
      local nls = require('null-ls')
      nls.setup({
        sources = {
          -- nls.builtins.formatting.prettier,
          -- nls.builtins.formatting.prettierd,
          nls.builtins.formatting.prettier          -- extra_args = { '--no-semi', '--single-quote', '--trailing-comma all' },
          -- }),
, --.with({

          nls.builtins.formatting.stylua.with({
            extra_args = { '--indent-type=Spaces', '--indent-width=2', '--quote-style=AutoPreferSingle' },
          }),
          nls.builtins.diagnostics.ruff.with({ extra_args = { '--max-line-length=180' } }),
        },
      })
    end,
  },
}
