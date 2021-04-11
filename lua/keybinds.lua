--
-- nnoremap
local nnoremap = function(key, cmd)
	local opts = {noremap = true, silent = true}
	return vim.api.nvim_set_keymap('n', key, cmd, opts)
end

-- inoremap
local inoremap = function(key, cmd)
	local opts = {noremap = true, silent = true}
	return vim.api.nvim_set_keymap('i', key, cmd, opts)
end

-- General Binds
--  stop search highlighting
nnoremap('', '<cmd> noh <cr>')

-- Comments with <C-/>
vim.cmd('noremap  :Commentary <cr>')

-- Put it in a box
nnoremap(
	'<leader>-',
	'<cmd>.!toilet -f term -F border <cr> <cmd>Commentary<cr> jVj:Commentary<cr>'
)

--  Behold my autopair plugin
inoremap('"', '""<left>')
inoremap("'", "''<left>")
inoremap('(', '()<left>')
inoremap('[', '[]<left>')
inoremap('{', '{}<left>')

-- inoremap('<','<><left>')

-- Tree
nnoremap('<F12>', '<cmd>NvimTreeToggle<cr>')

-- Splits

-- Resize
nnoremap(
	'<leader>ev',
	'<cmd> lua require("plugin_configs/telescope_config").edit_nvim_config()<cr>'
)
nnoremap('<C-Up>', '<cmd> resize -5 <cr>')
nnoremap('<C-Down>', '<cmd> resize +5 <cr>')
nnoremap('<C-Left>', '<cmd> vertical resize -5 <cr>')
nnoremap('<C-Right>', '<cmd> vertical resize +5 <cr>')

-- naigate
nnoremap('<leader>a', '<cmd>wincmd h<cr>')
nnoremap('<leader>s', '<cmd>wincmd j<cr>')
nnoremap('<leader>w', '<cmd>wincmd k<cr>')
nnoremap('<leader>d', '<cmd>wincmd l<cr>')

-- Tabs
nnoremap('<leader>1', '1gt')
nnoremap('<leader>2', '2gt')
nnoremap('<leader>3', '3gt')
nnoremap('<leader>4', '4gt')
nnoremap('<leader>5', '5gt')
nnoremap('<leader>6', '6gt')
nnoremap('<leader>7', '7gt')
nnoremap('<leader>8', '8gt')
nnoremap('<leader>9', '9gt')

-- Telescope
nnoremap('<C-p>', '<cmd>Telescope find_files<cr>')
nnoremap('<leader>rg', '<cmd>Telescope live_grep<cr>')
nnoremap('<leader>b', '<cmd>Telescope buffers<cr>')
nnoremap('<leader>tc', '<cmd>Telescope commands<cr>')
nnoremap(
	'<leader>ts',
	"<cmd> lua require('plugin_configs/telescope_config').study()<cr>"
)

-- Lsp
nnoremap('gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
nnoremap('gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
nnoremap('K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
nnoremap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
nnoremap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
nnoremap('<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
nnoremap('<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
nnoremap(
	'<leader>wl',
	'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>'
)
nnoremap('<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
nnoremap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
nnoremap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
nnoremap('<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
nnoremap('[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
nnoremap(']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
nnoremap('<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
nnoremap("<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")

