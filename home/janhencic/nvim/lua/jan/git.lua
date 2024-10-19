local neogit = require('neogit')

local M = {}

M.keybinds = {
  { '<leader>g', group = 'git' },
  {
    '<leader>gg',
    function()
      neogit.open()
    end,
    desc = 'Open Neogit',
  },
}

return M
