require'nvim-treesitter.configs'.setup {
	textobjects = {
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]f"] = "@function.outer", -- Go to next function (using a key for general object navigation)
				["]c"] = { query = "@class.outer", desc = "Next class start" }, -- Go to next class start
				["]]"] = { query = "@block.outer", desc = "Next object start" }, -- Go to next object (e.g., class, struct)
				["]s"] = { query = "@statement.outer", desc = "Next statement" }, -- Go to next statement
			},
			goto_previous_start = {
				["[f"] = "@function.outer", -- Go to previous function (using a key for general object navigation)
				["[c"] = { query = "@class.outer", desc = "Previous class start" }, -- Go to previous class start
				["[["] = { query = "@block.outer", desc = "Previous object start" }, -- Go to previous object
				["[s"] = { query = "@statement.outer", desc = "Next statement" }, -- Go to next statement
			},
		},
	},
}
