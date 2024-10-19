local M = {}

M.keybinds = {
  { '<leader>t', group = 'terminal' },
  {
    '<leader>to',
    function()
      vim.cmd('term')
    end,
    desc = 'Open terminal',
  },
}

return M
