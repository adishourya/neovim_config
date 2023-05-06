-- Stop loading built in plugins
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1


--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.splitbelow = true
vim.opt.splitright = true

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Copy Pasta is a Nightmare without this
vim.opt.clipboard = 'unnamedplus'

-- Global Statusline
vim.opt.laststatus = 3
vim.opt.cmdheight = 0

-- Statuscolumn
--
vim.opt.numberwidth = 4
vim.opt.statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s "
vim.opt.statuscolumn = "%s%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''} "


--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = ''

--Decrease update time
vim.o.updatetime = 50

-- 4 character wide tab for indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.g.smartintend = true

-- don't wrap lines
vim.opt.wrap = false

-- search options
--Case insensitive searching UNLESS /C or capital in search
vim.opt.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true

-- line default relative number
vim.opt.number = true
vim.opt.relativenumber = true

vim.wo.cursorline = false
vim.wo.signcolumn = "yes"

vim.wo.scrolloff = 1
vim.wo.sidescrolloff = 1

vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- whitespace characters
vim.wo.list = true
vim.opt.listchars = 'tab:→ ,trail:•,extends:»,precedes:«'

vim.opt.updatetime = 50
-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")
-- vim.opt.shortmess:append("F")


-- Error formate
vim.bo.errorformat = [[
    %E%f:%l:%c: %trror: %m,%-Z%p^,%+C%.%#
    %D%*a: Entering directory [`']%f
    %X%*a: Leaving directory [`']%f
    %-G%.%#
]]

-- Lsp Options
-- Make hover and signature in a box : like ur cmp
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

-- same for diagnostics
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
local signs = { Error = "", Warn = "", Hint = "", Info = "" } -- No Signs
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local diag_disp_config = {
	-- disable virtual text
	virtual_text = true,
	-- show signs
	signs = { active = signs },
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(diag_disp_config)
