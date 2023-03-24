local M = {}

local keybinds_table = {
  name = 'tab',
  n = {
    function()
      vim.cmd('tabnew')
    end,
    'Open new tab',
  },
}

-- An arbitrary number
local max_allowed_tabs = 9

local function open_tab_index_keybind(index)
  return {
    function()
      vim.cmd('tabn ' .. index)
    end,
    'Move to tab ' .. index,
  }
end

function M.keybinds()
  for index = 1, max_allowed_tabs do
    keybinds_table[tostring(index)] = open_tab_index_keybind(index)
  end

  return keybinds_table
end

return M
