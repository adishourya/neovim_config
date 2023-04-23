-- place this in one of your configuration file(s)
local hop_ok, hop = pcall(require,"hop")
if hop_ok then
	local directions = require('hop.hint').HintDirection
	-- Basics
	vim.keymap.set('', 'f', function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
	end, {remap=true})
	vim.keymap.set('', 'F', function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
	end, {remap=true})

	vim.keymap.set('', 't', function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
	end, {remap=true})
	vim.keymap.set('', 'T', function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
	end, {remap=true})

	-- Across lines
	vim.keymap.set('', 's', function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
	end, {remap=true})
	vim.keymap.set('', 'S', function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
	end, {remap=true})
end
