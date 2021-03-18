 -- [[
-- vim.o for setting global options
-- vim.bo for setting buffer-scoped options
-- vim.wo for setting window-scoped options
-- ]]


-- Buffer Level
local bo = vim.bo
-- bo.shiftwidth   =  2
-- bo.smartindent  =  true
-- bo.tabstop      =  2

-- Global Level
local glo = vim.o
glo.shiftwidth                    =  2
glo.smartindent                   =  true
glo.tabstop                       =  2
glo.softtabstop                       =  2
glo.expandtab                     =  false
glo.smartindent                   =  true
glo.completeopt                   =  'menuone,noselect'
glo.hidden                        =  true
glo.ignorecase                    =  false
glo.joinspaces                    =  false
glo.scrolloff                     =  4
glo.shiftround                    =  true
glo.sidescrolloff                 =  8
glo.smartcase                     =  true
glo.splitbelow                    =  true
glo.splitright                    =  true
glo.termguicolors                 =  true
-- glo.wildmode                      =  'list:longest'
glo.clipboard                     =  'unnamedplus'
glo.undofile                      =  true
glo.swapfile                      =  false
glo.compatible                    =  false
glo.autoindent                    =  true
glo.backspace                     =  "indent,eol,start"
glo.incsearch                     =  true
glo.wildmenu                      =  true
glo.ruler                         =  true
glo.laststatus                    =  2
glo.autochdir                     =  true
glo.smarttab                      =  true
vim.g.python3_host_prog           =  "~/anaconda3/bin/python3.8"
glo.backup                        = false
glo.listchars                     = "tab:• ,trail:•,extends:>,precedes:←,nbsp:─"


-- Window Level
local wo = vim.wo
wo.number          =  true
wo.relativenumber  =  true
wo.list            =  true
wo.wrap            =  false
