-- code running and output viewing

local otter = require("otter")
-- table of embedded languages to look for.
-- required (no default)
local languages = {'python', 'lua' }

-- enable completion/diagnostics
-- defaults are true
local completion = true
local diagnostics = true
-- treesitter query to look for embedded languages
-- uses injections if nil or not set
local tsquery = nil

otter.activate(languages, completion, diagnostics, tsquery)

-- I find auto open annoying, keep in mind setting this option will require setting
-- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
vim.g.molten_auto_open_output = true

vim.g.molten_enter_output_behavior = "open_and_enter"

vim.g.molten_output_win_max_height = 20
vim.g.molten_virt_text_max_lines = 20

-- this guide will be using image.nvim
-- Don't forget to setup and install the plugin if you want to view image outputs
vim.g.molten_image_provider = "image.nvim"

-- optional, I like wrapping. works for virt text and the output window
vim.g.molten_wrap_output = false

-- Output as virtual text. Allows outputs to always be shown, works with images, but can
-- be buggy with longer images
vim.g.molten_virt_text_output = true

-- this will make it so the output shows up below the \`\`\` cell delimiter
vim.g.molten_virt_lines_off_by_1 = true
vim.g.molten_enter_output_behavior = "open_and_enter"


-- keymaps
vim.keymap.set("n", "<leader>rr", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
vim.keymap.set("n", "<S-CR>", ":MoltenEvaluateOperator<CR>ib", { desc = "evaluate operator", silent = true })
vim.keymap.set("n", "<leader>ro", ":MoltenEnterOutput<CR>", { desc = "open output", silent = true })


-- treesitter
require("nvim-treesitter.configs").setup({
-- ... other ts config
textobjects = {
		move = {
				enable = true,
				set_jumps = false, -- you can change this if you want.
				goto_next_start = {
						--- ... other keymaps
						["]b"] = { query = "@code_cell.inner", desc = "next code block" },
				},
				goto_previous_start = {
						--- ... other keymaps
						["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
				},
		},
		select = {
				enable = true,
				lookahead = true, -- you can change this if you want
				keymaps = {
						--- ... other keymaps
						["ib"] = { query = "@code_cell.inner", desc = "in block" },
						["ab"] = { query = "@code_cell.outer", desc = "around block" },
				},
		},
		swap = { -- Swap only works with code blocks that are under the same
						 -- markdown header
				enable = true,
				swap_next = {
						--- ... other keymap
						["<leader>sbl"] = "@code_cell.outer",
				},
				swap_previous = {
						--- ... other keymap
						["<leader>sbh"] = "@code_cell.outer",
				},
		},
}
})


-- automatically import output chunks from a jupyter notebook
-- tries to find a kernel that matches the kernel in the jupyter notebook
-- falls back to a kernel that matches the name of the active venv (if any)
local imb = function(e) -- init molten buffer
		vim.schedule(function()
				local kernels = vim.fn.MoltenAvailableKernels()
				local try_kernel_name = function()
						local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
						return metadata.kernelspec.name
				end
				local ok, kernel_name = pcall(try_kernel_name)
				if not ok or not vim.tbl_contains(kernels, kernel_name) then
						kernel_name = nil
						local venv = os.getenv("VIRTUAL_ENV")
						if venv ~= nil then
								kernel_name = string.match(venv, "/.+/(.+)")
						end
				end
				if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
						vim.cmd(("MoltenInit %s"):format(kernel_name))
				end
				vim.cmd("MoltenImportOutput")
		end)
end

-- automatically import output chunks from a jupyter notebook
vim.api.nvim_create_autocmd("BufAdd", {
		pattern = { "*.ipynb" },
		callback = imb,
})

-- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
vim.api.nvim_create_autocmd("BufEnter", {
		pattern = { "*.ipynb" },
		callback = function(e)
				if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
						imb(e)
				end
		end,
})


-- automatically export output chunks to a jupyter notebook on write
vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = { "*.ipynb" },
		callback = function()
				if require("molten.status").initialized() == "Molten" then
						vim.cmd("MoltenExportOutput!")
				end
		end,
})


require("lspconfig")["pyright"].setup({
on_attach = on_attach,
capabilities = capabilities,
settings = {
		python = {
				analysis = {
						diagnosticSeverityOverrides = {
								reportUnusedExpression = "none",
						},
				},
		},
},
})


-- change the configuration when editing a python file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.py",
	callback = function(e)
		if string.match(e.file, ".otter.") then
			return
		end
		if require("molten.status").initialized() == "Molten" then -- this is kinda a hack...
			vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
			vim.fn.MoltenUpdateOption("virt_text_output", false)
		else
			vim.g.molten_virt_lines_off_by_1 = false
			vim.g.molten_virt_text_output = false
		end
	end,
})

-- Undo those config changes when we go back to a markdown or quarto file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.qmd", "*.md", "*.ipynb" },
	callback = function(e)
		require'otter'.activate({'python'})
		if string.match(e.file, ".otter.") then
			return
		end
		if require("molten.status").initialized() == "Molten" then
			vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
			vim.fn.MoltenUpdateOption("virt_text_output", true)
		else
			vim.g.molten_virt_lines_off_by_1 = true
			vim.g.molten_virt_text_output = true
		end
	end,
})


local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
-- local d = ls.dynamic_node
local c = ls.choice_node
-- local f = ls.function_node
-- local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
-- local h = require("snippets.snippet_helpers")

ls.add_snippets("quarto", {
	-- code cell
	s(
		"c",
		fmt(
			[[```{{{}}}
{}
```]],
			{ c(1, { t("python"), t("") }), i(0) }
		)
	),
	s(
		"`",
		fmt(
			[[```{{{}}}
{}
``]],
			{ c(1, { t("python"), t("") }), i(0) }
		)
	),
})
