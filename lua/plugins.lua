local use = require('packer').use
return require('packer').startup(function()
  use {"wbthomason/packer.nvim", opt = true} --self

  use{'tpope/vim-commentary'} --Man's gotta have some comments
  -- use{'tpope/vim-fugitive'} -- Baiscally use :Git instead of !git

  use {'norcalli/nvim-colorizer.lua'}   -- Colors my #ex

  use {'kyazdani42/nvim-web-devicons'}   -- good fonts have icons and my font comes from space

  use {'yuttie/comfortable-motion.vim'}   -- for buttery smooth buffers

  -- use {'glacambre/firenvim'}   -- Nvim in Browser. say what ?

  use {'kyazdani42/nvim-tree.lua'}   -- Seriously who uses netrw

  use{'lukas-reineke/indent-blankline.nvim', branch = 'lua'} -- Best indentline plugin ever

  -- Tree Sitter
  use {'nvim-treesitter/nvim-treesitter'} -- Tree Sitter
  use {'nvim-treesitter/playground'}     --playground


  use {'neovim/nvim-lspconfig'} -- Config for diagnostics and such
  use {'hrsh7th/nvim-compe'} -- For Completion and such

  use {'nvim-lua/popup.nvim'} -- New Meta
  use {'nvim-lua/plenary.nvim'}
  use {'nvim-telescope/telescope.nvim'}

  use {'lewis6991/gitsigns.nvim',requires = {'nvim-lua/plenary.nvim'}} -- Do i even need this

  use {'datwaft/bubbly.nvim'} -- Bubbly statusline


  -- Personal Wiki
  use{'vimwiki/vimwiki'}
  -- Gotta take inspiration from this theme
  use{'folke/tokyonight.nvim'}

end)



