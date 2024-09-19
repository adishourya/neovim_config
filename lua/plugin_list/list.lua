local packages = {

	-- Change/delete something around any braces
	{ "tpope/vim-surround" },

	-- Detect tabstop and shiftwidth automatically
	-- it has messed up once .. last straw
	-- { 'tpope/vim-sleuth' },


	-- UI related plugins
	{
	'smoka7/hop.nvim',
	version = "*",
	opts = { keys = 'etovxqpdygfblzhckisuran' }
	},

	{
		"OXY2DEV/markview.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
	},

	-- {
	-- 	'echasnovski/mini.statusline',
	-- 	version = false,
	-- 	config = function()
	-- 		require("mini.statusline").setup()
	-- 	end
	-- },
	--
	{
		'echasnovski/mini.animate',
		version = false,
		config = function()
			require("mini.animate").setup()
		end
	},

	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		module = "nvim-autopairs.completion.cmp",
		after = "nvim-cmp",
		config = function() require("nvim-autopairs").setup({}) end,
	},

	{ -- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'folke/neodev.nvim',
		},
	},

	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		config = function()
			-- Example mapping to toggle outline
			vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
				{ desc = "Toggle Outline" })

		require("outline").setup ({
			outline_window = {
				position = "left",
				},
		})
	end,
},

	{
		"ray-x/lsp_signature.nvim",
		after = "nvim-lspconfig",
		config = function()
			require "lsp_signature".setup({ wrap = true, })
		end
	},

	{ -- Autocompletion
		'hrsh7th/nvim-cmp',
		event = { "InsertEnter" },
		dependencies = {
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'jmbuhr/otter.nvim',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"lukas-reineke/cmp-under-comparator",
		},
	},

	{
		"danymat/neogen",
		module = "neogen",
		ft = { "sh", "c", "cpp", "go", "lua", "python", "rust", },
		config = function() require("neogen").setup({}) end,
	},


	{ -- Adds git releated signs to the gutter, as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add          = { text = '│' },
				change       = { text = '│' },
				delete       = { text = '┆' },
				topdelete    = { text = '┆' },
				changedelete = { text = '┆' },
				untracked    = { text = '┆' },
			}, -- See `:help gitsigns.txt`
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end
	},

	-- { 'stevearc/oil.nvim',
	-- opts = {},
	-- -- Optional dependencies
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	-- },

	{ 'echasnovski/mini.files', version = false,
		config = function ()
			require('mini.files').setup()
		end},

	-- {
	-- 	'echasnovski/mini.indentscope',
	-- 	version = false,
	-- 	config = function()
	-- 		require('mini.indentscope').setup()
	-- 	end
	-- },

	-- { "lukas-reineke/indent-blankline.nvim",version = "2.0", opts = {}},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {},
		config = function ()
			require("ibl").setup()
		end},


	-- Fuzzy Finder (files, lsp, etc)
	{
		'nvim-telescope/telescope.nvim',
		cmd = "Telescope",
		dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
		config = function()
			-- settings
			require('telescope').setup {
				defaults = require('telescope.themes').get_ivy {
					selection_caret = "->  ",
					layout_config = { height = 0.5 },
				},
			}
		end
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		lazy = false,
		build = 'make',
		cond = function()
			return vim.fn.executable 'make' == 1
		end,
		config = function()
			pcall(require('telescope').load_extension, 'fzf')
		end
	},
	-- This is great but we will let mini.files take over this
	{ 'tpope/vim-vinegar', event = "VeryLazy" },


	-- { -- Highlight, edit, and navigate code
	-- 	'nvim-treesitter/nvim-treesitter',
	-- 	lazy = false,
	-- 	-- commit = "4cccb6f",
	-- 	config = function()
	-- 		pcall(require('nvim-treesitter.install').update { with_sync = true })
	-- 	end,
	-- },

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"markdown",
					"markdown_inline",
					"python",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighing = false,
				},
			})
		end,
	},

	-- sticky header
	{"nvim-treesitter/nvim-treesitter-context",
	config = function ()
		require("treesitter-context").setup(
				{max_lines = 2,}
			)
	end},

	{
		'rcarriga/nvim-notify',
		event = "VeryLazy",
		config = function()
			require('notify').setup({
				stages = 'slide',
				timeout = 1000,
			})
			vim.notify = require('notify')
		end,
	},

	-- colorschemes (keep them sep. They can have config funcs)
	-- see colors
	{
		'norcalli/nvim-colorizer.lua',
		config = function() require 'colorizer'.setup() end
	},

	{ -- My Take on dark(black) nord
		'adishourya/nordic.nvim',
		priority = 1000,
		config = function()
			require 'nordic'.setup {
				-- Available themes: 'nordic', 'onedark', 'choco'
				theme = 'choco',
			}
		end
	},

	{
		"adishourya/base46",
		priority = 1000,
	},

	-- Configuring Notebook
}

return packages
