local M = {}

local telescope_builtin = require('telescope.builtin')
local jan_telescope = require('jan.telescope')

M.keybinds = {
  { '<leader>s', group = 'search' },
  {
    '<leader>sd',
    function()
      telescope_builtin.live_grep()
    end,
    desc = 'Live grep cwd',
  },
  {
    '<leader>sf',
    function()
      telescope_builtin.find_files()
    end,
    desc = 'Find file in cwd',
  },
  {
    '<leader>sp',
    jan_telescope.live_grep_git_repo,
    desc = 'Live grep git repository',
  },
}

return M
