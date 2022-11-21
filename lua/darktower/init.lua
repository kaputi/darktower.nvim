local M = {}

local theme = require('darktower.theme')

local updateHighlight = function(hi, values)
  if theme[hi] == nil then
    theme[hi] = values
    return
  end

  for k, v in pairs(values) do
    theme[hi][k] = v
  end
end

local set_highlights = function()
  -- for hi, values in pairs(theme) do
    -- print('------------------------------------')
    -- print(hi .. ' ::::::::')
    -- print(vim.inspect(values))
  -- end

  -- print(vim.inspect(defaultTheme))
end

M.setup = function(values)
  if values.theme == nil then
    values.theme = {}
  end

  -- for hi, values in pairs(values.theme) do
    -- updateHighlight(hi,values)
  -- end

  -- vim.cmd('hi clear')

  -- vim.o.background = 'dark'

  -- if vim.fn.exists('sytax_on') then
  --   vim.cmd('syntax reset')
  -- end

  -- vim.o.termguicolors = true

  set_highlights()
end

return M
