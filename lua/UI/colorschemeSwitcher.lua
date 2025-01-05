local map = vim.keymap.set

local ok_telescope, _ = pcall(require, "telescope")
if not (ok_telescope) then
	print("Telescope Not Loaded")
	return
end

-- Making a new telescope colorscheme picker with live preview hopefully
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
-- local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")
local conf = require("telescope.config").values

local switcher_appearance = {
	prompt_title = "Choose Colorscheme",
}

-- ┌────────────────────┐
-- │Colorscheme Switcher│
-- └────────────────────┘


local installed_colourschemes = vim.fn.getcompletion('', "color")
local preinstalled = {
	"blue", "darkblue", "delek", "desert", "elflord", "quiet",
	"evening", "industry", "koehler", "morning", "murphy",
	"pablo", "peachpuff", "ron", "shine", "slate",
	"torte", "zellner", "habamax", "lunaperche",
	"default", "vim"
	-- like to keep default uncommented here.. its too good since > 0.10
	-- "sorbet"
}
-- remove preinstalled colorschemes from the installed list
local array_sub = function(t1, t2)
	local t = {}
	for i = 1, #t1 do
		t[t1[i]] = true;
	end
	for i = #t2, 1, -1 do
		if t[t2[i]] then
			table.remove(t2, i);
		end
	end
	return t2
end
local downloaded = array_sub(preinstalled, installed_colourschemes)

-- Exports and reloads
function ExportColorsKitty()
	local fn = vim.fn
	local filename = os.getenv("HOME") .. "/.config/kitty/nvim_export.conf"
	local file = io.open(filename, "w")
	---@diagnostic disable-next-line: param-type-mismatch
	io.output(file)
	io.write("# vim:ft=kitty" .. "\n\n")
	io.write("# exported from " .. vim.g.colors_name .. "\n\n")
	local fg = fn.synIDattr(fn.hlID("Normal"), "fg")
	local bg = fn.synIDattr(fn.hlID("Normal"), "bg")
	io.write("foreground " .. fg .. "\n")
	io.write("background " .. bg .. "\n")
	io.write("selection_foreground " .. bg .. "\n")
	io.write("selection_background " .. fg .. "\n")
	for i = 0, 15 do
		local var = "g:terminal_color_" .. tostring(i)
		if fn.exists(var) == 1 then
			local tc = fn.eval(var)
			io.write("color" .. tostring(i) .. " " .. tc .. "\n")
			if i == 2 then
				io.write("cursor " .. tc .. "\n")
			end
		end
	end
	io.close(file)
	local exec_run = string.format("kitty @ set-colors --all --configured ~/.config/kitty/nvim_export.conf")
	vim.fn.jobstart(exec_run)
end

function ExportColorsAlacritty()
	local fn = vim.fn
	local filename = os.getenv("HOME") .. "/.config/alacritty/nvim_export.toml"
	local file = io.open(filename, "w")
	---@diagnostic disable-next-line: param-type-mismatch
	io.output(file)
	io.write("# Alacritty color scheme exported from Neovim\n\n")
	io.write("[colors]\n")
	io.write("[colors.primary]\n")
	local fg = fn.synIDattr(fn.hlID("Normal"), "fg")
	local bg = fn.synIDattr(fn.hlID("Normal"), "bg")
	io.write("foreground = '" .. fg .. "'\n")
	io.write("background = '" .. bg .. "'\n")
	io.write("\n[colors.selection]\n")
	io.write("foreground = '" .. bg .. "'\n")
	io.write("background = '" .. fg .. "'\n")
	io.write("\n[colors.cursor]\n")
	io.write("text = '" .. bg .. "'\n")
	io.write("cursor = '" .. fg .. "'\n")
	io.close(file)
end

function ExportTmux()
	local fn = vim.fn
	local filename = os.getenv("HOME") .. "/.tmux_statuline_colors.conf"
	local file = io.open(filename, "w")
	local statusline_fg = vim.fn.synIDattr(vim.fn.hlID('Normal'), 'fg')
	local statusline_bg = vim.fn.synIDattr(vim.fn.hlID('StatusLine'), 'bg')
	io.output(file)
	io.write("# Tmux colors exported from neovim" .. "\n\n")
	io.write("# exported from " .. vim.g.colors_name .. "\n\n")
	local color_string = string.format("set-option -g status-style bg=%s,fg=%s", statusline_bg, statusline_fg)
	io.write(color_string)
	io.close(file)

	local exec_run = string.format("tmux source-file ~/.tmux.conf")
	vim.fn.jobstart(exec_run)
end

function ExportColorsI3()
	local fn = vim.fn
	local filename = os.getenv("HOME") .. "/.config/i3/nvim_colors.config"
	local i3_config = os.getenv("HOME") .. "/.config/i3/config" -- Path to your i3 config file
	local file = io.open(filename, "w")

	---@diagnostic disable-next-line: param-type-mismatch
	io.output(file)
	io.write("# i3 colorscheme exported from Neovim\n\n")

	-- Define border colors
	local normal_fg = fn.synIDattr(fn.hlID("Normal"), "fg")
	local normal_bg = fn.synIDattr(fn.hlID("Normal"), "bg")
	local comment = fn.synIDattr(fn.hlID("Comment"), "fg")
	local error = fn.synIDattr(fn.hlID("ErrorMsg"), "fg")
	local search = fn.synIDattr(fn.hlID("Search"), "bg")

	-- Check if the background is light or dark
	local background = vim.o.background
	-- vim.notify(background)

	-- If background is light, swap the fg and bg
	if background == "light" then
		local temp = normal_fg
		normal_fg = normal_bg
		normal_bg = temp
	end

	-- Write i3 border color configuration to the temp file
	io.write("set $fg " .. normal_fg .. "\n")
	io.write("set $bg " .. normal_bg .. "\n")
	io.write("set $comment " .. comment .. "\n")
	io.write("set $error " .. error .. "\n")
	io.write("set $statusline_bg " .. search .. "\n")

	io.close(file)

	-- Function to update i3 config using sed
	local function updateI3Config()
		-- Combined sed command for all replacements
		local sed_command = "sed -i -e '/^set \\$fg /s|^.*|set $fg " .. normal_fg .. "|' " ..
				"-e '/^set \\$bg /s|^.*|set $bg " .. normal_bg .. "|' " ..
				"-e '/^set \\$comment /s|^.*|set $comment " .. comment .. "|' " ..
				"-e '/^set \\$error /s|^.*|set $error " .. error .. "|' " ..
				"-e '/^set \\$statusline_bg /s|^.*|set $statusline_bg " .. search .. "|' " ..
				i3_config

		-- Combined append command for all missing variables
		local append_command = "grep -q -F 'set $fg " .. normal_fg .. "' " .. i3_config ..
				" && grep -q -F 'set $bg " .. normal_bg .. "' " .. i3_config ..
				" && grep -q -F 'set $comment " .. comment .. "' " .. i3_config ..
				" && grep -q -F 'set $error " .. error .. "' " .. i3_config ..
				" && grep -q -F 'set $statusline_bg " .. search .. "' " .. i3_config ..
				" || echo -e 'set $fg " .. normal_fg .. "\\nset $bg " .. normal_bg ..
				"\\nset $comment " .. comment .. "\\nset $error " .. error ..
				"\\nset $statusline_bg " .. search .. "' >> " .. i3_config

		-- Execute the sed and append commands
		os.execute(sed_command)
		os.execute(append_command)
	end

	-- Update i3 config file
	updateI3Config()

	-- Reload i3 to apply the new colors
	vim.fn.jobstart("i3-msg reload")
end

function River()
	-- Define border colors
	local normal_fg     = vim.fn.synIDattr(vim.fn.hlID("Normal"), "fg")
	local normal_bg     = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg")
	local comment       = vim.fn.synIDattr(vim.fn.hlID("Comment"), "fg")
	local error         = vim.fn.synIDattr(vim.fn.hlID("ErrorMsg"), "fg")
	local search        = vim.fn.synIDattr(vim.fn.hlID("Search"), "bg")
	local statusline_fg = vim.fn.synIDattr(vim.fn.hlID("StatusLine"), "fg")
	local statusline_bg = vim.fn.synIDattr(vim.fn.hlID("StatusLine"), "bg")

	-- Convert colors to 0x format
	local normal_bg_hex = "0x" .. normal_bg:sub(2) -- Removing '#' and adding '0x'
	local search_hex    = "0x" .. search:sub(2)
	local comment_hex   = "0x" .. comment:sub(2)
	local error_hex     = "0x" .. error:sub(2)
	local statusline_fg = "0x" .. statusline_fg:sub(2)

	-- Concatenate commands
	local command       = string.format(
		"riverctl background-color '%s' && riverctl border-color-focused '%s' && riverctl border-color-unfocused '%s'",
		normal_bg_hex, search_hex, comment_hex)

	-- local command       = string.format(
	-- 	"riverctl border-color-focused '%s' && riverctl border-color-unfocused '%s'",
	-- 	search_hex, comment_hex)
	--
	local write_command =  string.format("echo '%s' > %s",command, "~/.config/river/borders.sh")
	-- vim.notify(write_command)

	-- Execute the command
	os.execute(command)
	os.execute(write_command)
end


function i3Bar()
	-- Define border colors
	local normal_fg     = vim.fn.synIDattr(vim.fn.hlID("Normal"), "fg")
	local normal_bg     = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg")
	local comment       = vim.fn.synIDattr(vim.fn.hlID("Comment"), "fg")
	local error         = vim.fn.synIDattr(vim.fn.hlID("ErrorMsg"), "fg")
	local search        = vim.fn.synIDattr(vim.fn.hlID("Search"), "bg")
	local statusline_fg = vim.fn.synIDattr(vim.fn.hlID("StatusLine"), "fg")
	local statusline_bg = vim.fn.synIDattr(vim.fn.hlID("StatusLine"), "bg")

	local bar = os.getenv("HOME") .. "/.config/i3bar-river/config.toml" -- Path to your i3 config file
	local file = io.open(bar, "r+")
	if file == nil then
		print("Unable to open i3Bar config")
		return
	end

	-- Read file content and modify it
	local content = file:read("*a")
	-- vim.notify(content)
	file:close()

	-- Find and replace tag_focused_bg value with the search color
	local updated_content = content:gsub("tag_focused_bg%s*=%s*\"#%x%x%x%x%x%x\"", "tag_focused_bg = \"" .. search .. "\"")

	-- background
	local updated_content = updated_content:gsub("background%s*=%s*\"#%x%x%x%x%x%x\"", "background = \"" .. statusline_bg .. "\"")
	local updated_content = updated_content:gsub("tag_bg%s*=%s*\"#%x%x%x%x%x%x\"", "tag_bg = \"" .. statusline_bg .. "\"")
	local updated_content = updated_content:gsub("tag_inactive_bg%s*=%s*\"#%x%x%x%x%x%x\"", "tag_inactive_bg = \"" .. statusline_bg .. "\"")

	-- foreground
	local updated_content = updated_content:gsub("color%s*=%s*\"#%x%x%x%x%x%x\"", "color = \"" .. statusline_fg .. "\"")
	local updated_content = updated_content:gsub("tag_fg%s*=%s*\"#%x%x%x%x%x%x\"", "tag_fg = \"" .. statusline_fg .. "\"")
	local updated_content = updated_content:gsub("tag_inactive_fg%s*=%s*\"#%x%x%x%x%x%x\"", "tag_inactive_fg = \"" .. statusline_fg .. "\"")
	local updated_content = updated_content:gsub("tag_active_fg%s*=%s*\"#%x%x%x%x%x%x\"", "tag_active_fg = \"" .. statusline_bg .. "\"")

	-- Write the updated content back to the file
	file = io.open(bar, "w")
	file:write(updated_content)
	file:close()

	-- Define the sed command (if necessary) to be run on the file
	-- local sed_command = "sed -i 's/tag_focused_bg = \"#%x%x%x%x%x%x\"/tag_focused_bg = \"" .. search .. "\"/' " .. bar
	-- os.execute(sed_command)

	-- Reload i3 bar by killing and restarting it using vim.fn.jobstart
	local reload_command = "killall -q i3bar-river && i3bar-river" -- Adjust to your bar process name

	vim.fn.jobstart(reload_command,{detach = true})

end

local switcheroo = function()
	ExportColorsAlacritty()
	River()
	i3Bar()
	-- ExportColorsI3()
	-- ExportColorsKitty()
	ExportTmux()
end

local enter_switcheroo = function()
  River()
end

local escape = function(prompt_bufnr)
	-- Reset it back to the colorscheme it was before
	local cmd = "colorscheme " .. CURRENT_SCHEME
	vim.cmd(cmd)
	actions.close(prompt_bufnr)
	switcheroo()
end

local enter = function(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	local cmd = "colorscheme " .. selected[1]
	vim.cmd(cmd)
	actions.close(prompt_bufnr)
	local csPath = vim.fn.expand("~/.config/nvim/lua/UI/set_scheme.lua")
	local exec_run = string.format("echo 'vim.cmd[[colorscheme %s]]' > %s", selected[1], csPath)
	vim.fn.jobstart(exec_run)
	vim.notify("Colorscheme Change From " .. CURRENT_SCHEME .. " to " .. selected[1])
	switcheroo()
	-- return back to normal mode
	vim.api.nvim_input("<esc>")
	-- Turn On if you're using TMUX.
	-- ExportTmux()
end

local preview_selection = function(selected)
	local cmd = "colorscheme " .. selected
	vim.cmd(cmd)
	switcheroo()
end

local preview_next = function(prompt_bufnr)
	actions.move_selection_next(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	local cmd = "colorscheme " .. selected[1]
	vim.cmd(cmd)
	switcheroo()
end

local preview_prev = function(prompt_bufnr)
	actions.move_selection_previous(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	local cmd = "colorscheme " .. selected[1]
	vim.cmd(cmd)
	switcheroo()
end


local switcherOpts = {
	finder = finders.new_table { results = downloaded },
	-- sorter = sorters.get_generic_fuzzy_sorter({}),
	sorter = conf.generic_sorter(),
	sorting_stratergy = "ascending",

	attach_mappings = function(prompt_bufnr, map)
		-- change on TextChangedI
		vim.schedule(function()
			vim.api.nvim_create_autocmd("TextChangedI", {
				buffer = prompt_bufnr,
				callback = function()
					preview_selection(actions_state.get_selected_entry()[1])
				end
			})
		end)
		map("i", "<CR>", enter)
		map("i", "<ESC>", escape)
		map("i", "<C-n>", preview_next)
		map("i", "<Down>", preview_next)
		map("i", "<C-p>", preview_prev)
		map("i", "<Up>", preview_prev)
		return true
	end
}

local change_scheme = function()
	CURRENT_SCHEME = vim.g.colors_name
	colors = pickers.new(switcher_appearance, switcherOpts)
	colors:find()
end
vim.api.nvim_create_user_command("Newcolorscheme", change_scheme, {})
map('n', "<leader>cs", ":Newcolorscheme<cr>", { noremap = true })
