local theme = {
  hi = {},
  palette = require('darktower.theme.palette'),
}

local hi = {
  require('darktower.theme.vim_hi'),
  require('darktower.theme.lsp_hi'),
  require('darktower.theme.TS_hi'),
  require('darktower.theme.gitsigns_hi'),
}

for _, value in ipairs(hi) do
  for k, v in pairs(value) do
    theme.hi[k] = v
  end
end

return theme
