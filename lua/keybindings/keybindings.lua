-- Basic Keymaps
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Keep the cursor @ correct indent on empty lines
vim.keymap.set("x", "i", function()
if #vim.fn.getline(".") == 0 then
		return [["_cc]]
else
		return "i"
end
end, { expr = true })

------------ Basic Keymaps-------------
--Paste with respect
vim.api.nvim_set_keymap('n', 'p', ']p', { noremap = true })
-- Jump paragraphs without respect
vim.api.nvim_set_keymap('n', '{', ':keepjumps normal! {<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '}', ':keepjumps normal! }<CR>', { noremap = true, silent = true })

-- Buffer
vim.keymap.set('n', '<Leader><Esc>', ':bd<CR>', { noremap = true })
vim.keymap.set('n', '<C-l>', ':noh<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>]', ':bnext<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>[', ':bprev<CR>', { noremap = true })

-- Escape terminal like a human
vim.cmd [[tnoremap <Esc> <C-\><C-N>]]

-- Window navigation
vim.keymap.set('n', '\\a', ':wincmd h<CR>', { noremap = true })
vim.keymap.set('n', '\\s', ':wincmd j<CR>', { noremap = true })
vim.keymap.set('n', '\\w', ':wincmd k<CR>', { noremap = true })
vim.keymap.set('n', '\\d', ':wincmd l<CR>', { noremap = true })

-- Tab Navigation
vim.keymap.set('n','\\1','1gt',{noremap=true})
vim.keymap.set('n','\\2','2gt',{noremap=true})
vim.keymap.set('n','\\3','3gt',{noremap=true})
vim.keymap.set('n','\\4','4gt',{noremap=true})
vim.keymap.set('n','\\5','5gt',{noremap=true})
vim.keymap.set('n','\\6','6gt',{noremap=true})
vim.keymap.set('n','\\7','7gt',{noremap=true})

-- Make splits
vim.keymap.set('n', '_', ':sp<CR>', { noremap = true })
vim.keymap.set('n', '|', ':vsp<CR>', { noremap = true })

-- resize splits
vim.keymap.set('n', '<A-d>', ':vertical resize -20 <CR>', { noremap = true })
vim.keymap.set('n', '<A-a>', ':vertical resize +20 <CR>', { noremap = true })
vim.keymap.set('n', '<A-s>', ':resize +10 <CR>', { noremap = true })
vim.keymap.set('n', '<A-w>', ':resize -10 <CR>', { noremap = true })

-- Force of habbit mappings
vim.keymap.set('n','<C-a>','<Esc>^',{noremap=true})
vim.keymap.set('i','<C-a>','<Esc>^',{noremap=true})
vim.keymap.set('n','<C-e>','<Esc>$',{noremap=true})
vim.keymap.set('i','<C-e>','<Esc>A',{noremap=true})


