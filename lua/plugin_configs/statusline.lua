-- Here you can add the configuration for the plugin

vim.g.bubbly_palette = {
  background = "#20242b",
  foreground = "#c5cdd9",
  black = "#3b4252",
  red = "#ec7279",
  green = "#a0c980",
  yellow = "#deb974",
  blue = "#6cb6eb",
  purple = "#d38aea",
  cyan = "#5dbbc1",
  white = "#c5cdd9",
  lightgrey = "#4c566a",
  darkgrey = "#434c5e",

}

vim.g.bubbly_statusline ={

  'mode',

  'truncate',

  'path',
  'branch',
  'builtinlsp.diagnostic_count',

  'divisor',

  'filetype',
  'progress',

}

vim.g.bubbly_inactive_style = 'italic'
