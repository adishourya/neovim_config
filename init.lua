-- [[ Plugin List ]]
require("plugin_list")

-- [[ UI ]]
require("UI")

-- [[This makes neovim api stuff amazing]]
require('neodev').setup()

-- [[ Settings ]]
require("settings")

-- [[ Basic Keymaps ]]
require("keybindings")

-- [[ Language Serve r]]
require("lsp")

-- [[ Completion ]]
require("completion")

-- [[ My Funcs ]]
require("my_funcs")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
