require('table')

local M = {}

-- An arbitrary number
local max_allowed_tabs = 9

local function open_tab_index_keybind(index)
  return {
    '<leader><tab>' .. index,
    function()
      vim.cmd('tabn ' .. index)
    end,
    desc = 'Move to tab ' .. index,
  }
end

local which_key_window_keybinds = {
  { '<leader>w', group = 'window' },
  {
    '<leader>ws',
    function()
      vim.cmd('split')
    end,
    desc = 'horizontal split',
  },
  {
    '<leader>wv',
    function()
      vim.cmd('vsplit')
    end,
    desc = 'vertical split',
  },
  {
    '<leader>wd',
    function()
      vim.cmd('q')
    end,
    desc = 'close current splt',
  },
  {
    '<leader>wl',
    function()
      vim.cmd('wincmd l')
    end,
    desc = 'Move to right split',
  },
  {
    '<leader>wh',
    function()
      vim.cmd('wincmd h')
    end,
    desc = 'Move to left split',
  },
  {
    '<leader>wj',
    function()
      vim.cmd('wincmd j')
    end,
    desc = 'Move to bottom split',
  },
  {
    '<leader>wk',
    function()
      vim.cmd('wincmd k')
    end,
    desc = 'Move to top split',
  },
}

local which_key_tab_keybinds = {
  { '<leader>tab', group = 'tab' },
}

function M.keybinds()
  for index = 1, max_allowed_tabs do
    table.insert(which_key_tab_keybinds, open_tab_index_keybind(index))
  end

  return table.merge_lists(which_key_tab_keybinds, which_key_window_keybinds)
end

return M
