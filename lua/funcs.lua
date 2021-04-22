-- ┌───────────────┐
-- │Handy Functions│
-- └───────────────┘
--

F = {}

-- Dont chnage the name of the function
--  references in keybinds.lua
F.formatter = function()
	if vim.bo.filetype == "lua" then
		-- vim.lsp.buf.formatting() doesn't work with lua for some reaseon
		vim.cmd("!lua ~/bin/luafmt.lua --f %")
	else
		vim.lsp.buf.formatting()
	end
end

F.reindent = function(tabsize)
	if tabsize == nil then
		-- dont know how to give default value
		-- like in python
		tabsize = 2
	end
	if vim.bo.filetype == "python" then
		-- dont know why python has a hard on for multiple of 4
		vim.bo.shiftwidth = 4
	else
		vim.bo.shiftwidth = tabsize
    -- use the magic command
		vim.cmd [[normal gg=G]]
	end
end

return F

