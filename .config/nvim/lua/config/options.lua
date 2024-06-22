vim.g.mapleader = ' '

vim.opt.showmode = false
vim.opt.syntax = 'on'

vim.opt.laststatus = 3

vim.cmd([[
set path+=**
set iskeyword+=-
]])
vim.opt.mouse = 'a'

vim.opt.updatetime = 500

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.completeopt = { 'menu',  'menuone', 'noselect' }

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoindent = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.timeoutlen=500

if vim.fn.has('termguicolors') == 1 then
  vim.o.termguicolors = true
  vim.cmd('hi LineNr ctermbg=NONE guibg=NONE')
end
