---------  .lua-----------|


-- ┌────────────────┐
-- │ OG Leader Key  │
-- └────────────────┘

vim.g.mapleader = '\\'
print('HeyLo')


-- ┌──────────────────────────────┐
-- │Packer for maintaining plugins│
-- └──────────────────────────────┘


-- Using packer as plugin manager cuz paq is too dang slow{{{
local fn = vim.fn
local execute = vim.api.nvim_command
-- Auto install packer.nvim if not exists
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end
vim.cmd [[packadd packer.nvim]]
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua
--}}}

-- ┌────────────┐
-- │  SETTINGS  │
-- └────────────┘

-- options{{{
require('options')

-- plugins
require('plugins')

--keybinds
require('keybinds')

-- colorscheme
-- vim.cmd('colorscheme OceanicNext')
-- vim.cmd('colorscheme nord_moon')
vim.cmd('colorscheme nordnight')

-- Autocmds !!WIP!!
-- require('autocommands')
--}}}
--
--
--Handy functions{{{
Funcs = require('funcs')
--}}}


-- ┌──────────────────────┐
-- │ PLugin configurations│
-- └──────────────────────┘


---- colorizer{{{
require'colorizer'.setup()

---- Telescope
require('plugin_configs/telescope_config')

------ Lsp Configuration
require('plugin_configs/lsp_config')
require('plugin_configs/nvim_compe')
require('plugin_configs/lsp_icons').init()

------ Tree Sitter
require('plugin_configs/treesitter_config')

-- Statusline
require('plugin_configs/statusline')

-- Git Signs
require('plugin_configs/gitsigns')

-- Wiki

vim.g.vimwiki_list = {
  {
    path = '/home/adi/Documents/my_notes',
    syntax = 'markdown',
    ext = '.md',
  }
}

-- Indent Lines
require('plugin_configs/indentlines')--}}}
