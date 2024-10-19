local neogit = require('neogit')

local M = {}

local open_neogit = {
  function()
    neogit.open()
  end,
  'Open Neogit',
}

M.keybinds = {
  { '<leader>g', group = 'git' },
  { '<leader>gg', open_neogit, desc = 'Open Neogit' },
}

return M
