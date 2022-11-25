local M = {}

local hl = vim.api.nvim_set_hl

local theme = require('darktower.theme')

local updateHighlight = function(hi, values)
  local newValues = {}
  local update = false

  for k, v in pairs(values) do
    if k == 'update' then
      update = true
    else
      newValues[k] = v
    end
  end

  if update == true then
    if theme.hi[hi] == nil then
      theme.hi[hi] = newValues
    else
      for k, v in pairs(newValues) do
        theme.hi[hi][k] = v
      end
    end
  else
    theme.hi[hi] = newValues
  end
end

local updatePalette = function(mode, color, color_value)
  theme.palette[mode][color] = color_value
end

local isNone = function(val)
  if val == 'NONE' or val == 'none' or val == '-' or val == false then
    return true
  end
  return false
end

local set_highlights = function(mode)
  local palette
  if mode == 'light' then
    palette = theme.palette.light
  else
    palette = theme.palette.dark
  end

  for hi, values in pairs(theme.hi) do
    local hi_obj = {}
    for name, type_val in pairs(values) do
      if isNone(type_val) == true then
        type_val = 'NONE'
      end
      if name == 'mod' and type(type_val) == 'table' then
        for _, modName in ipairs(type_val) do
          hi_obj[modName] = true
        end
      else
        if palette[type_val] ~= nil then
          hi_obj[name] = palette[type_val]
        else
          hi_obj[name] = type_val
        end
      end
    end

    local hi_name = hi:gsub('at_', '@')
    hl(0, hi_name, hi_obj)
  end
end

M.setup = function(values)
  if values.highlights == nil then
    values.highlights = {}
  end

  if values.palette == nil then
    values.palette = {}
  end

  for hi, v in pairs(values.highlights) do
    updateHighlight(hi, v)
  end

  for mode, mode_values in pairs(values.palette) do
    for color, color_value in pairs(mode_values) do
      updatePalette(mode, color, color_value)
    end
  end

  if values.dark == false then
    M.set('light')
  else
    M.set()
  end
end

M.set = function(mode)
  vim.cmd('hi clear')

  if mode == 'light' then
    vim.o.background = 'light'
    vim.g.colors_name = 'darktower-light'
  else
    vim.o.background = 'dark'
    vim.g.colors_name = 'darktower'
  end

  if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
  end

  vim.o.termguicolors = true

  set_highlights(mode)
end

return M
