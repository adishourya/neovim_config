-- ┌─────────────┐
-- │ Indent Lines│
-- └─────────────┘
vim.g.indent_blankline_char = '│'

-- should have just made a .vim file for this

-- vim.cmd("let g:indent_blankline_char_list = ['|', '¦', '┆', '┊']")
vim.cmd("let g:indent_blankline_char_highlight = 'aqua_ind'")
vim.cmd("let g:indent_blankline_char_highlight_list = ['aqua_ind' , 'grey_ind', 'yellow_ind','algea_ind','aqua_ind']")
vim.cmd("let g:indent_blankline_space_char_highlight = 'aqua_ind'")
vim.cmd("let g:indent_blankline_space_char_blankline_highlight = 'aqua_ind'")
vim.cmd("let g:indent_blankline_space_char_highlight_list = [ 'aqua_ind' , 'grey_ind', 'yellow_ind','algea_ind','aqua_ind']")
vim.cmd("let g:indent_blankline_space_char_blankline_highlight_list = ['aqua_ind' , 'grey_ind', 'yellow_ind','algea_ind','aqua_ind']")
vim.cmd("let g:indent_blankline_use_treesitter = v:true")
vim.cmd("let g:indent_blankline_show_end_of_line = v:true")
vim.cmd("let g:indent_blankline_filetype_exclude = ['help']")
-- Try turning this off if things feel a little slow
vim.cmd("let g:indent_blankline_show_current_context = v:true")
vim.cmd("let g:indent_blankline_context_highlight = 'aqua_ind'")

-- vim.cmd('let g:indent_blankline_show_first_indent_level = v:false')

-- vim.g.indent_blankline_char_highlight_list = "'purple_il','orange_ils'"
-- vim.g.indent_blankline_char_highlight = "'purple_il','orange_ils'"
-- vim.g.indent_blankline_char_highlight_list = "'purple_il','orange_ils'"
-- -- Dont Know what this does
-- -- let g:indent_blankline_space_char = ' '
-- vim.g.indent_blankline_space_char_highlight = 'purple_il'
-- vim.g.indent_blankline_space_char_blankline_highlight = 'purple_il'
-- vim.g.indent_blankline_space_char_highlight_list = "'purple_il', 'orange_il'"

-- vim.g.indent_blankline_space_char_blankline_highlight_list = "'purple_il', 'orange_il'"

-- vim.g.indent_blankline_use_treesitter = true

-- This might slow things down updates after curosor change
-- vim.g.indent_blankline_show_current_context = true


