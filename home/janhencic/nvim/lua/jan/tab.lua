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

M.horizontal_split = {
  function()
    vim.cmd('split')
  end,
  'horizontal split',
}

M.vertical_split = {
  function()
    vim.cmd('vsplit')
  end,
  'vertical split',
}

M.close_split = {
  function()
    vim.cmd('q')
  end,
  'close current splt',
}

M.move_right = {
  function()
    vim.cmd('wincmd l')
  end,
  'Move to right split',
}

M.move_left = {
  function()
    vim.cmd('wincmd h')
  end,
  'Move to left split',
}

M.move_down = {
  function()
    vim.cmd('wincmd j')
  end,
  'Move to bottom split',
}

M.move_up = {
  function()
    vim.cmd('wincmd k')
  end,
  'Move to top split',
}

return M
