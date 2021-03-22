local use = require('packer').use
return require('packer').startup(function()
use {"wbthomason/packer.nvim", opt = true}

--Basic Needs

--Man's gotta have some comments
use{'tpope/vim-commentary'}

-- Colors my #ex
use {'norcalli/nvim-colorizer.lua'}

-- good fonts have icons and my fonts from space
use {'kyazdani42/nvim-web-devicons'}

-- feels like coconut oil
use {'yuttie/comfortable-motion.vim'}

-- Nvim in Browser. say what ?
use {'glacambre/firenvim'}

-- File structure
use {'kyazdani42/nvim-tree.lua'}

-- indent guidelines
use{'lukas-reineke/indent-blankline.nvim', branch = 'lua'}
-- Lua Branch doesn not need this anymore
-- use{'Yggdroot/indentLine'}

-- Colorscheme
use{'kyazdani42/blue-moon'}

-- Tree Sitter
use {'nvim-treesitter/nvim-treesitter'}

--Lsp
use {'neovim/nvim-lspconfig'}
use {'hrsh7th/nvim-compe'}

-- Telescope
use {'nvim-lua/popup.nvim'}
use {'nvim-lua/plenary.nvim'}
use {'nvim-telescope/telescope.nvim'}

-- Git Signs
use {'lewis6991/gitsigns.nvim',requires = {'nvim-lua/plenary.nvim'}}

-- Statusline
use {'datwaft/bubbly.nvim'}

end)



