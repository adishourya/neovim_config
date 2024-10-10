-- Your trial and error scratchpad
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
	-- "default",
	-- like to keep default uncommented here.. its too good since > 0.10
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
	for i = 0,15 do
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
	-- 	-- Trigger Alacritty hot reload by sending SIGUSR1 to Alacritty process
	-- local alacritty_pid = fn.system("pgrep alacritty")
	-- if alacritty_pid ~= "" then
	-- 	fn.system("kill -s USR1 " .. alacritty_pid)
	-- 	print("Alacritty configuration reloaded.")
	-- else
	-- 	print("Alacritty process not found.")
	-- end
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
	local color_string = string.format("set-option -g status-style bg=%s,fg=%s",statusline_bg,statusline_fg)
	io.write(color_string)
	io.close(file)

	local exec_run = string.format("tmux source-file ~/.tmux.conf")
	vim.fn.jobstart(exec_run)
end


function ExportColorsI3()
	local fn = vim.fn
	local filename = os.getenv("HOME") .. "/.config/i3/nvim_colors.config"
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

	-- Write i3 border color configuration
	io.write("set $fg " .. normal_fg .."\n")
	io.write("set $bg " .. normal_bg .."\n")
	io.write("set $comment " .. comment .. "\n")
	io.write("set $error " .. error .. "\n")
	io.write("set $statusline_bg " .. search .. "\n")

	io.close(file)

	-- Reload i3 to apply the new colors
	vim.fn.jobstart("i3-msg reload")
end


function NewExportColorsI3()
	local fn = vim.fn
	local filename = os.getenv("HOME") .. "/.config/i3/nvim_colors.config"
	local i3_config = os.getenv("HOME") .. "/.config/i3/config"  -- Path to your i3 config file
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

	-- Write i3 border color configuration to the temp file
	io.write("set $fg " .. normal_fg .. "\n")
	io.write("set $bg " .. normal_bg .. "\n")
	io.write("set $comment " .. comment .. "\n")
	io.write("set $error " .. error .. "\n")
	io.write("set $statusline_bg " .. search .. "\n")

	io.close(file)

	-- Function to update i3 config using sed
	local function updateI3Config()
		-- Replace existing color lines with new ones
		local sed_commands = {
			"sed -i 's|^set \\$fg .*|set $fg " .. normal_fg .. "|' " .. i3_config,
			"sed -i 's|^set \\$bg .*|set $bg " .. normal_bg .. "|' " .. i3_config,
			"sed -i 's|^set \\$comment .*|set $comment " .. comment .. "|' " .. i3_config,
			"sed -i 's|^set \\$error .*|set $error " .. error .. "|' " .. i3_config,
			"sed -i 's|^set \\$statusline_bg .*|set $statusline_bg " .. search .. "|' " .. i3_config,
		}

		for _, command in ipairs(sed_commands) do
			os.execute(command)
		end

		-- Append new color definitions if not found
		local append_command = "grep -qxF 'set $fg " .. normal_fg .. "' " .. i3_config .. " || echo 'set $fg " .. normal_fg .. "' >> " .. i3_config
		os.execute(append_command)
		append_command = "grep -qxF 'set $bg " .. normal_bg .. "' " .. i3_config .. " || echo 'set $bg " .. normal_bg .. "' >> " .. i3_config
		os.execute(append_command)
		append_command = "grep -qxF 'set $comment " .. comment .. "' " .. i3_config .. " || echo 'set $comment " .. comment .. "' >> " .. i3_config
		os.execute(append_command)
		append_command = "grep -qxF 'set $error " .. error .. "' " .. i3_config .. " || echo 'set $error " .. error .. "' >> " .. i3_config
		os.execute(append_command)
		append_command = "grep -qxF 'set $statusline_bg " .. search .. "' " .. i3_config .. " || echo 'set $statusline_bg " .. search .. "' >> " .. i3_config
		os.execute(append_command)
	end

	-- Update i3 config file
	updateI3Config()

	-- Reload i3 to apply the new colors
	vim.fn.jobstart("i3-msg reload")
end

local switcheroo = function ()
	ExportColorsAlacritty()
	-- ExportColorsI3()
	NewExportColorsI3()
	-- ExportColorsKitty()
	ExportTmux()
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
	local exec_run = string.format("echo 'vim.cmd[[colorscheme %s]]' > %s",selected[1],csPath)
	vim.fn.jobstart(exec_run)
	vim.notify("Colorscheme Change From "..CURRENT_SCHEME.." to "..selected[1])
	switcheroo()
	-- return back to normal mode
	vim.api.nvim_input("<esc>")
	-- Turn On if you're using TMUX.
	-- ExportTmux()
end

local preview_selection = function (selected)
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
	finder = finders.new_table{results=downloaded},
	-- sorter = sorters.get_generic_fuzzy_sorter({}),
	sorter = conf.generic_sorter(),
	sorting_stratergy = "ascending",

	attach_mappings = function(prompt_bufnr, map)
		-- change on TextChangedI
		vim.schedule(function()
			vim.api.nvim_create_autocmd("TextChangedI",{
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
	colors = pickers.new(switcher_appearance,switcherOpts)
	colors:find()
end
vim.api.nvim_create_user_command("Newcolorscheme", change_scheme, {})
map('n',"<leader>cs",":Newcolorscheme<cr>",{noremap=true})
