local util = require("colorschemes/nordnight.util")
local config = require("colorschemes/nordnight.config")

-- Color Palette
---@class ColorScheme
local colors = {
  none = "NONE",
  bg_dark = "#1a1c22",
  bg = "#1e222a",
  bg_highlight = "#2e3440",
  fg = "#eceff4",
  fg_dark = "#dbdee9",
  fg_gutter = "#3b4252",
  dark3 = "#4c566a",
  comment = "#4c566a",
  dark5 = "#525d73",
  blue0 = "#81a1c1",
  blue = "#5e81ac",
  cyan = "#88c0d0",
  blue1 = "#8fbcbb",
  blue5 = "#89ddff",
  blue6 = "#B4F9F8",
  magenta = "#b48ead",
  purple = "#a6acdd",
  orange = "#d08770",
  yellow = "#ebcb8b",
  green3 = "#a3be8c",
  green = "#a3be8c",
  teal = "#525d73",
  red = "#bf616a",
  red1 = "#bf616a",

--  For Indent Line and shit
  black_il = "#282c34",
  grey_il = "#969896",
  yellow_il = "#f0c674",
  algea_il = "#8abeb7",
  aqua_il = "#689d6a",


  diff = { change = "#394b70", add = "#164846", delete = "#823c41" },
  git = { change = "#6183bb", add = "#449dab", delete = "#914c54" },
}
if config.style == "night" then colors.bg = "#1a1b26" end
util.bg = colors.bg
colors.git.ignore = colors.dark3
colors.black = util.darken(colors.bg, 0.7, "#000000")
colors.border_highlight = colors.blue0
colors.border = colors.black

colors.bg_popup = colors.bg_dark
colors.bg_sidebar = colors.bg_dark
colors.bg_statusline = colors.bg_dark
colors.bg_float = colors.bg
colors.bg_visual = util.darken(colors.blue0, 0.7)
colors.bg_search = colors.blue0
colors.fg_sidebar = colors.fg_dark

colors.error = colors.red1
colors.warning = colors.yellow
colors.info = colors.teal
colors.hint = colors.info

-- util.fg = colors.fg

return colors

