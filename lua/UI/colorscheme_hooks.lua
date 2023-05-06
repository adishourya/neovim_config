-- Override your colors here

local augroup, autocmd = vim.api.nvim_create_augroup, vim.api.nvim_create_autocmd
-- These are all user autocmds
augroup("user", {})

-- They have mehh.. highlighting by default for FloatBorder and floatNormal
local weird_borders_schemes = {"everforest","gruvbox-material","edge","sonokai","monokaipro","monochrome"}
local locate = function( table, value )
	for i = 1, #table do
		if table[i] == value then return true end
	end
	return false
end


local fix_borders = function ()
	if locate(weird_borders_schemes,vim.g.colors_name) then
		vim.cmd("highlight! link FloatBorder Normal")
		vim.cmd("highlight! link NormalFloat Normal")
	end
end


autocmd("ColorScheme",{
	callback = function ()
		fix_borders()
	end,
	group="user",
})
