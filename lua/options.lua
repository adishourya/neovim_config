-- ┌───────────┐
-- │ vim.opts  │
-- └───────────┘
--
--{{{
-- remove this when vim.opt gets merged
local if_nil = function(a, b)
	if a == nil then
		return b
	end
	return a
end

local singular_values = {
	['boolean'] = true,
	['number'] = true,
	['nil'] = true,
}

local set_key_value = function(t, key_value_str)
	assert(
		string.find(key_value_str, ":"),
		"Must have a :" .. tostring(key_value_str)
	)

	local key, value = unpack(vim.split(key_value_str, ":"))
	key = vim.trim(key)
	value = vim.trim(value)

	t[key] = value
end

local convert_vimoption_to_lua = function(option, val)
	-- Short circuit if we've already converted!
	if type(val) == 'table' then
		return val
	end

	if singular_values[type(val)] then
		return val
	end

	if type(val) == "string" then
		-- TODO: Bad hax I think
		if string.find(val, ":") then
			local result = {}
			local items = vim.split(val, ",")
			for _, item in ipairs(items) do
				set_key_value(result, item)
			end

			return result
		else
			return vim.split(val, ",")
		end
	end
end

-- local concat_keys = function(t, sep)
--   return table.concat(vim.tbl_keys(t), sep)
-- end

local concat_key_values = function(t, sep, divider)
	local final = {}
	for k, v in pairs(t) do
		table.insert(final, string.format('%s%s%s', k, divider, v))
	end

	table.sort(final)
	return table.concat(final, sep)
end

local remove_duplicate_values = function(t)
	local result = {}
	for _, v in ipairs(t) do
		result[v] = true
	end

	return vim.tbl_keys(result)
end

local remove_value = function(t, val)
	if vim.tbl_islist(t) then
		local remove_index = nil
		for i, v in ipairs(t) do
			if v == val then
				remove_index = i
			end
		end

		if remove_index then
			table.remove(t, remove_index)
		end
	else
		t[val] = nil
	end

	return t
end

local add_value = function(current, new)
	if singular_values[type(current)] then
		error("This is not possible to do. Please do something different: " .. tostring(current) .. " // " .. tostring(new))
	end

	if type(new) == 'string' then
		if vim.tbl_islist(current) then
			table.insert(current, new)
		else
			set_key_value(current, new)
		end

		return current
	elseif type(new) == 'table' then
		if vim.tbl_islist(current) then
			assert(vim.tbl_islist(new))
			vim.list_extend(current, new)
		else
			assert(
				not vim.tbl_islist(new),
				vim.inspect(new) .. vim.inspect(current)
			)
			current = vim.tbl_extend("force", current, new)
		end

		return current
	else
		error("Unknown type")
	end
end

local convert_lua_to_vimoption = function(t)
	if vim.tbl_islist(t) then
		t = remove_duplicate_values(t)

		table.sort(t)
		return table.concat(t, ',')
	else
		return concat_key_values(t, ',', ':')
	end
end

local clean_value = function(v)
	if singular_values[type(v)] then
		return v
	end

	local result = v:gsub('^,', '')

	return result
end

local opt_mt

opt_mt = {
	__index = function(t, k)
		if k == '_value' then
			return rawget(t, k)
		end

		return setmetatable(
			{
				_option = k,
			},
			opt_mt
		)
	end,

	__newindex = function(t, k, v)
		if k == '_value' then
			return rawset(t, k, v)
		end

		if type(v) == 'table' then
			local new_value
			if getmetatable(v) ~= opt_mt then
				new_value = v
			else
				assert(v._value, "Must have a value to set this")
				new_value = v._value
			end

			vim.o[k] = convert_lua_to_vimoption(new_value)
			return
		end

		if v == nil then
			v = ''
		end

		-- TODO: Figure out why nvim_set_option doesn't override values the same way.
		-- @bfredl said he will fix this for me, so I can just use nvim_set_option
		if type(v) == 'boolean' then
			vim.o[k] = clean_value(v)
			if v then
				vim.cmd(string.format("set %s", k))
			else
				vim.cmd(string.format("set no%s", k))
			end
		else
			vim.cmd(string.format("set %s=%s", k, clean_value(v)))
		end
	end,

	__add = function(left, right)
		--[[
    set.wildignore = set.wildignore + 'hello'
    set.wildignore = set.wildignore + { '*.o', '*~', }
    --]]

		assert(left._option, "must have an option key")
		if left._option == 'foldcolumn' then
			error("not implemented for foldcolumn.. use a string")
		end

		local existing = if_nil(left._value, vim.o[left._option])
		local current = convert_vimoption_to_lua(left._option, existing)
		if not current then
			left._value = convert_vimoption_to_lua(right)
		end

		left._value = add_value(current, right)
		return left
	end,

	__sub = function(left, right)
		assert(left._option, "must have an option key")

		local existing = if_nil(left._value, vim.o[left._option])
		local current = convert_vimoption_to_lua(left._option, existing)
		if not current then
			return left
		end

		left._value = remove_value(current, right)
		return left
	end
}

vim.opt = setmetatable({}, opt_mt)

--}}}

local apply_options = function(opts)--{{{
	for k, v in pairs(opts) do
		vim.opt[k] = v
	end
end
--}}}

-- ┌───────┐
-- │Options│
-- └───────┘

local options = {--{{{
	autochdir = true,
	autoindent = true,

	-- enable autoindent
	backup = false,

	-- disable backup
	cursorline = true,

	-- enable cursorline
	expandtab = true,

	-- use spaces instead of tabs
	autowrite = false,

	-- autowrite buffer when it's not focused
	hidden = true,

	-- keep hidden buffers
	hlsearch = true,

	-- highlight matching search
	ignorecase = true,

	-- case insensitive on search
	lazyredraw = true,

	-- lazyredraw to make macro faster
	list = true,

	-- display listchars
	number = true,

	-- enable number
	relativenumber = true,

	-- enable relativenumber
	showmode = false,

	-- don't show mode
	smartcase = true,

	-- improve searching using '/'
	smartindent = true,

	-- smarter indentation
	smarttab = true,

	-- make tab behaviour smarter
	splitbelow = true,

	-- split below instead of above
	splitright = true,

	-- split right instead of left
	startofline = false,

	-- don't go to the start of the line when moving to another file
	swapfile = false,

	-- disable swapfile
	termguicolors = true,

	-- truecolours for better experience
	wrap = false,

	-- dont wrap lines
	writebackup = false,

	-- disable backup
	backupcopy = "yes",

	-- fix weirdness for postcss
	completeopt = {"menu", "menuone", "noselect", "noinsert"},

	-- better completion
	encoding = "UTF-8",

	-- set encoding
	fillchars = {vert = "│", eob = " "},

	-- make vertical split sign better
	foldmethod = "marker",

	-- foldmethod using marker
	clipboard = "unnamedplus",

	-- foldexpr       = "nvim_treesitter#foldexpr()",
	-- foldlevel      = 0, -- don't fold anything if I don't tell it to do so
	-- foldnestmax    = 2, -- only allow 2 nested folds, it can be confusing if I have too many
	foldopen = {"percent", "search"},

	-- don't open fold if I don't tell it to do so
	foldcolumn = "auto",

	-- enable fold column for better visualisation
	inccommand = "split",

	-- incrementally show result of command
	listchars = {tab = "» ", trail = "•"},

	-- set listchars
	-- mouse          = "a", -- enable mouse support
	-- shortmess      = "csa", -- disable some stuff on shortmess
	signcolumn = "yes",

	-- enable sign column all the time, 4 column
	-- colorcolumn    = 80, -- 80 chars color column
	laststatus = 2,

	-- always enable statusline
	pumheight = 10,

	-- limit completion items
	re = 0,

	-- set regexp engine to auto
	scrolloff = 2,

	-- make scrolling better
	sidescroll = 2,

	-- make scrolling better
	shiftwidth = 2,

	-- set indentation width
	sidescrolloff = 15,

	-- make scrolling better
	-- synmaxcol      = 300, -- set limit for syntax highlighting in a single line, probably gonna remove this since treesitter handles this very well
	tabstop = 2,

	-- tabsize
	timeoutlen = 400,

	-- faster timeout wait time
	updatetime = 100,

	-- set faster update time
	colorcolumn = 999,

	-- A hack for indentline
}
--}}}
apply_options(options)

