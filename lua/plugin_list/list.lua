local packages = {

	-- Change/delete something around any braces
	{ "tpope/vim-surround" },

	-- Detect tabstop and shiftwidth automatically
	{ 'tpope/vim-sleuth' },


	-- UI related plugins
	{
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		config = function()
			require 'hop'.setup {}
		end
	},

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


	{ 'echasnovski/mini.indentscope', version = false, config = function ()
		require('mini.indentscope').setup()
	end },



	-- "gc" to comment visual regions/lines
	{
		'echasnovski/mini.comment',
		version = false,
		config = function()
			require("mini.comment").setup()
		end
	},

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
					layout_config = { height = 0.45 },
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

	{ 'tpope/vim-vinegar', event = "VeryLazy" },

	{
		"nvim-telescope/telescope-file-browser.nvim",
			dependencies = {
				'nvim-treesitter/nvim-treesitter-textobjects',
			},
		config = function()
			require("telescope").setup { extensions = { file_browser = { hijack_netrw = true, }, }, }
			require("telescope").load_extension "file_browser"
		end
	},

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
	{
		"vhyrro/luarocks.nvim",
		priority = 1001, -- this plugin needs to run before anything else
		opts = {
			rocks = { "magick" },
		},
	},
	{
		"bluz71/vim-moonfly-colors",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.syntax("enable")
			vim.cmd.colorscheme("moonfly")

			vim.api.nvim_set_hl(0, "MoltenOutputBorder", { link = "Normal" })
			vim.api.nvim_set_hl(0, "MoltenOutputBorderFail", { link = "MoonflyCrimson" })
			vim.api.nvim_set_hl(0, "MoltenOutputBorderSuccess", { link = "MoonflyBlue" })
		end,
	},
	{
		"benlubas/molten-nvim",
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_use_border_highlights = true
			-- add a few new things

			-- don't change the mappings (unless it's related to your bug)
			vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>")
			vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>")
			vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>")
			vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv")
			vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>")
			vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>")
			vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>")
		end,
	},
	{
		"3rd/image.nvim",
		opts = {
			backend = "kitty",
			integrations = {},
			max_width = 100,
			max_height = 12,
			max_height_window_percentage = math.huge,
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		},
		version = "1.1.0", -- or comment out for latest
	},

}

return packages
