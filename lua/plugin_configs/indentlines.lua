-- ┌─────────────┐
-- │ Indent Lines│
-- └─────────────┘

-- vim.g:indent_blankline_char_list = {'|', '¦', '┆', '┊'}
-- vim.g.indent_blankline_char = '┊'
-- vim.g.indent_blankline_char = '│'
vim.g.indent_blankline_char = '┃'
vim.g.indent_blankline_strict_tabs = true
vim.g.indent_blankline_char_highlight_list = {
	'aqua_ind',
	'grey_ind',
	'yellow_ind',
	'algea_ind'
}

-- vim.g.indent_blankline_char_highlight_list = {'black_ind'}
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_filetype_exclude = {'help'}
vim.g.indent_blankline_buftype_exclude = {'terminal'}

-- warning this off if things feel a little slow
vim.g.indent_blankline_show_current_context = false

