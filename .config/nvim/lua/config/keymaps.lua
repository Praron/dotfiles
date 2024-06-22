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

nmap('<leader>w', ':w<cr>')
nmap('<leader>q', ':q')
nmap('<leader>bd', ':Bdelete<cr>')
nmap('<leader>bD', ':bd<cr>')

-- System clipboard support.
nmap('<leader>y', '"*y')
nmap('<leader>p', '"*p')

-- Disable search highlght by Esc.
nmap('<esc>', ':noh<cr>')

-- Don't use Ex mode, use Q for formatting.
nmap('Q', 'gq')

-- Search by visual selected text.
vmap('//', [[y/\V<C-R>=escape(@','/\')<CR><CR>]])

-- Switch to prev/next buffer
nmap('gh', ':bp<cr>')
nmap('gl', ':bn<cr>')

-- Don't copy in buffer if only spaces.
local function smart_dd()
  if vim.api.nvim_get_current_line():match('^%s*$') then
    return '"_dd'
  else
    return 'dd'
  end
end
vim.keymap.set('n', 'dd', smart_dd, { noremap = true, expr = true })
