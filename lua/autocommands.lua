
vim = vim
local utils = {}
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

-- autocommands
function utils.define_augroups(definitions) -- {{{1
  -- Create autocommand groups based on the passed definitions
  --
  -- The key will be the name of the group, and each definition
  -- within the group should have:
  --    1. Trigger
  --    2. Pattern
  --    3. Text
  -- just like how they would normally be defined from Vim itself
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    vim.cmd("autocmd!")

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
      vim.cmd(command)
    end

    vim.cmd("augroup END")
  end
end

-- options
function utils.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= "o" then
    scopes["o"][key] = value
  end
end

-- mappings
function utils.map(mode, key, result, opts)
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, key, result, options)
end

-- Telescope
function utils.search_dotfiles()
  require("telescope.builtin").find_files(
  {
    prompt_title = "Dotfiles",
    cwd = "$HOME/.config/"
  }
  )
end

function utils.search_nvim()
  require("telescope.builtin").find_files(
  {
    prompt_title = "Neovim Config",
    cwd = "$HOME/.config/nvim"
  }
  )
end

local u = utils

local autocmds = {
  jump_last = {
    {
      "BufReadPost",
      "*",
      [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
    }
  },
  filetypes = {
    {"BufNewFile,BufRead", "*.ejs", "set filetype=html"},
    {"FileType", "markdown", "setlocal wrap"},
    {"FileType", "markdown", "setlocal spell"},
    {
      "FileType",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
    },
    {"FileType", "toggleterm", "setlocal nonumber norelativenumber"}
  },
  -- Expensive shit.
  cursor = {
    -- {"CursorHold", "*", "lua vim.lsp.diagnostic.show_line_diagnostics()"},
    -- {"CursorHoldI", "*", "silent! lua vim.lsp.buf.signature_help()"}
    --
    -- Bad Idea
    -- {"CursorHoldI", "*", "silent! lua vim.lsp.buf.hover()"}
  },
  hl_yank = {{"TextYankPost", "*", 'lua require"vim.highlight".on_yank()'}}
}

local format = {
  {
    "BufWritePre",
    "*",
    [[try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry]]
  }
}

local trim_whitespaces = {
  {"BufWritePre", "*", [[%s/\s\+$//e]]},
  {"BufWritePre", "*", [[%s/\n\+\%$//e]]}

  -- {"BufWritePre", "*.[ch]", [[*.[ch] %s/\%$/\r/e]]}
}

u.define_augroups(autocmds)
