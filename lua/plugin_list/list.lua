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

	-- {
	-- 	'echasnovski/mini.animate',
	-- 	version = false,
	-- 	config = function()
	-- 		require("mini.animate").setup()
	-- 	end
	-- },

	-- {
	-- 	"karb94/neoscroll.nvim",
	-- 	config = function()
	-- 		require('neoscroll').setup({})
	-- 	end
	-- },
	--
	-- {
	-- 	"sphamba/smear-cursor.nvim",
	-- 	opts = {},
	-- },

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
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			quickfile = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			styles = {
				notification = {
					wo = { wrap = true } -- Wrap notifications
				}
			}
		},
		keys = {
			{ "<leader>z",  function() Snacks.zen() end,                     desc = "Toggle Zen Mode" },
			{ "<leader>Z",  function() Snacks.zen.zoom() end,                desc = "Toggle Zoom" },
			{ "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
			{ "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
			{ "<leader>n",  function() Snacks.notifier.show_history() end,   desc = "Notification History" },
			{ "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
			{ "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
			{ "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse",                  mode = { "n", "v" } },
			{ "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
			{ "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
			{ "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
			{ "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
			{ "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
			{ "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal" },
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
					"<leader>uc")
					Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
					Snacks.toggle.inlay_hints():map("<leader>uh")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.dim():map("<leader>uD")
				end,
			})
		end,
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

			require("outline").setup({
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

	-- Ai autocompletion
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
				enable_chat = false,
			})
		end
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

	{
		'echasnovski/mini.files',
		version = false,
		config = function()
			require('mini.files').setup()
		end
	},

	-- {
	-- 	'echasnovski/mini.indentscope',
	-- 	version = false,
	-- 	config = function()
	-- 		require('mini.indentscope').setup()
	-- 	end
	-- },

	-- { "lukas-reineke/indent-blankline.nvim",version = "2.0", opts = {}},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup()
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
	-- to move and select
	{
	"nvim-treesitter/nvim-treesitter-textobjects",
	after = "nvim-treesitter",
	requires = "nvim-treesitter/nvim-treesitter",
	},

	-- sticky header
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup(
				{ max_lines = 2, }
			)
		end
	},

	-- {
	-- 	'rcarriga/nvim-notify',
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require('notify').setup({
	-- 			stages = 'slide',
	-- 			timeout = 1000,
	-- 		})
	-- 		vim.notify = require('notify')
	-- 	end,
	-- },
	--
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

	{ "neanias/everforest-nvim",          priority = 1000 },
	{ 'nyoom-engineering/oxocarbon.nvim', priority = 1000 },
	{ "rebelot/kanagawa.nvim",            priority = 1000 },
	{ "scottmckendry/cyberdream.nvim",    priority = 1000, },
	{ "adishourya/base46",                priority = 1000, },

	-- {
	-- 	"RRethy/base16-nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require('base16-colorscheme').with_config({
	-- 			telescope = true,
	-- 			indentblankline = true,
	-- 			notify = true,
	-- 			ts_rainbow = true,
	-- 			cmp = false,
	-- 			illuminate = true,
	-- 			dapui = true,
	-- 		})
	-- 	end
	-- },


	-- Configuring Notebook
}

return packages
