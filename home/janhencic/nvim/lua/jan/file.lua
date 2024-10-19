local telescope_builtin = require('telescope.builtin')

local M = {}

M.keybinds = {
  { '<leader>f', group = 'file' },
  {
    '<leader>fr',
    function()
      telescope_builtin.oldfiles()
    end,
    desc = 'Open recently opened files',
  },
}

return M
