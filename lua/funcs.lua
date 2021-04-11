
-- ┌───────────────┐
-- │Handy Functions│
-- └───────────────┘
--

local lua_formatter = function()

  if vim.bo.filetype == "lua" then
    vim.cmd("!lua ~/bin/luafmt.lua --f %")
    print('Formatted !!')
  else
    print('not a lua filetype')
  end
end

