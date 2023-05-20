-- Keymaps with plugins
-- Edit Vimrc
vim.keymap.set('n','\\ev',":Telescope find_files cwd=~/.config/nvim <cr>")
vim.keymap.set('n','\\ed',":Telescope find_files cwd=~/.config <cr>")

-- Autochdir breaks many plugins and is not really a good habbit
vim.keymap.set('n','<Leader>cd',":cd %:p:h<CR> :lua vim.notify('changed Dir')<cr>")

-- Put it in a box
vim.keymap.set({'n','v'}, '\\-', '<cmd>.!toilet -f term -F border <cr> ',{noremap=true})

vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true })
vim.keymap.set('n', '<leader>rf', ':Telescope oldfiles<CR>', { noremap = true })
vim.keymap.set('n', '<leader>fw', ':Telescope live_grep<CR>', { noremap = true })
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>', { noremap = true })
vim.keymap.set('n', '<leader>km', ':Telescope keymaps <CR>', { noremap = true })

-- Change word
vim.keymap.set('n', '\\rn', ':%s/\\<<C-r><C-w>\\>//g<Left><Left>', { noremap = true })

-- git signs
vim.keymap.set('n',"\\gs",':Gitsigns toggle_signs <CR>')
vim.keymap.set('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
vim.keymap.set('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

vim.keymap.set('n', '<leader>sh', ':Gitsigns stage_hunk<CR>', { noremap = true })
vim.keymap.set('v', '<leader>sh', ':Gitsigns stage_hunk<CR>', { noremap = true })
vim.keymap.set('n', '<leader>sb', ':Gitsigns stage_buffer<CR>', { noremap = true })

vim.keymap.set('n', '<leader>rh', ':Gitsigns reset_hunk<CR>', { noremap = true })
vim.keymap.set('v', '<leader>rb', ':Gitsigns reset_buffer<CR>', { noremap = true })

vim.keymap.set('n', '<leader>uh', ':Gitsigns undo_stage_hunk<CR>', { noremap = true })
vim.keymap.set('n', '<leader>ph', ':Gitsigns preview_hunk<CR>', { noremap = true })
vim.keymap.set('n', '<leader>tb', ':Gitsigns toggle_current_line_blame<CR>', { noremap = true })
vim.keymap.set('n', '<leader>hd', ':Gitsigns diffthis<CR>', { noremap = true })
vim.keymap.set('n', '<leader>td', ':Gitsigns toggle_deleted<CR>', { noremap = true })


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
