local packages = {

	{"tpope/vim-surround"},

	-- Detect tabstop and shiftwidth automatically
	{'tpope/vim-sleuth'},


	-- UI related plugins
	{
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		config = function()
			require 'hop'.setup {}
		end
	},

	{ 'echasnovski/mini.animate', version = false,
		config = function ()
			require("mini.animate").setup()
		end},

	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter"},
		module = "nvim-autopairs.completion.cmp",
		after = "nvim-cmp",
		config = function() require("nvim-autopairs").setup({}) end,
	},
	--
	{ -- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			{ 'j-hui/fidget.nvim', opts = {} },
			'folke/neodev.nvim',
		},
	},

	{
		"ray-x/lsp_signature.nvim",
		after = "nvim-lspconfig",
		config = function()
			require"lsp_signature".setup({wrap=true,})
		end
	},

	{ -- Autocompletion
		'hrsh7th/nvim-cmp',
		event = { "InsertEnter"},
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
			},-- See `:help gitsigns.txt`
		},
		config = function(_,opts)
			require("gitsigns").setup(opts)
		end
	},


	{
		'lukas-reineke/indent-blankline.nvim',
		opts = {
			char = '┊',
			show_trailing_blankline_indent = false,
			show_first_indent_level = true,
			show_current_context = true,
			show_current_context_start = false,
		},
	},


	-- "gc" to comment visual regions/lines
	{ 'echasnovski/mini.comment', version = false,
		config = function ()
			require("mini.comment").setup()
		end
	},

	-- Fuzzy Finder (files, lsp, etc)
	{ 'nvim-telescope/telescope.nvim',
		cmd = "Telescope",
		dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
		config = function()
			-- settings
			require('telescope').setup {
				defaults = require('telescope.themes').get_ivy {
					selection_caret = "->  ",
					layout_config={height=0.45},
				},
			}
		end
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		lazy = false,
		build = 'make',
		cond = function()
			return vim.fn.executable 'make' == 1
		end,
		config=function ()
			pcall(require('telescope').load_extension, 'fzf')
		end
	},

	{ 'tpope/vim-vinegar',event = "VeryLazy"},

	{ "nvim-telescope/telescope-file-browser.nvim",
		config = function()
			require("telescope").setup { extensions = { file_browser = { hijack_netrw = true, }, }, }
			require("telescope").load_extension "file_browser"
		end },

	{ -- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		-- commit = "4cccb6f",
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		config = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
		end,
	},

	{
		'rcarriga/nvim-notify',
		event="VeryLazy",
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
	{ 'norcalli/nvim-colorizer.lua', cmd = "ColorizerToggle",
		config = function() require 'colorizer'.setup() end
	},

	{ -- My Take on dark(black) nord
		'adishourya/nordic.nvim',
		priority = 1000,
		config = function ()
			require 'nordic' .setup {
				-- Available themes: 'nordic', 'onedark', 'choco'
				theme = 'choco',
			}
		end
	},

	{
		"adishourya/base46",
		priority=1000,
	},

}

return packages
