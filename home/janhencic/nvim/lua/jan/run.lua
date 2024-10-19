local M = {}

M.keybinds = {
  { '<leader>r', group = 'run' },
  {
    '<leader>rc',
    function()
      vim.cmd('split term://cargo check')
    end,
    desc = 'Run Cargo check',
  },
}

return M
