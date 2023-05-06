-- Frequent quittting options
-- Save all and quit
-- dont save anything and quit
-- Save this session . (save in temp. so it resets after reboot)
-- Dont require enter to confirm just the number
--

local options = {
	"{S}ave All buffers and quit",
	"{s}ave only this buffer and quit",
	"{M}ake current buffers as session",
	"{L}oad saved sessions"
}


local option_logic = function ()
	if options[1] then
		vim.cmd[[wqa]]
	elseif options[2] then
		vim.cmd[[w]]
		vim.cmd[[qa!]]
	elseif options[3] then
		local sessName = "/tmp/".."Session_" .. os.date()
		vim.cmd("mksession! "..sessName)
	else
		local function savedSessions()
			return 0
		end
		savedSessions()
	end
end

local quitter = function ()
	return 0
end

-- map a key to call the function
vim.api.nvim_create_user_command("Quitter", quitter, {})
vim.keymap.set('n', "\\q", ":Quitter<cr>", { noremap = true })
