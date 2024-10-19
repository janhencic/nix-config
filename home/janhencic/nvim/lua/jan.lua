local M = {}

local jan_nvim_tree = require('jan.nvim_tree')
local api = require('nvim-tree.api')
local telescope_builtin = require('telescope.builtin')

M.set_colorscheme = function()
  vim.cmd('colorscheme tokyonight-moon')

  require('tokyonight').setup({
    styles = {
      variables = { 'transparent' },
    },
  })
end

M.create_autocmd = function()
  local file_type = vim.api.nvim_create_augroup('my_file_type_group', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'lua',
    callback = function()
      vim.schedule(function()
        vim.o.shiftwidth = 2
      end)
    end,
    group = file_type,
  })
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'rust',
    callback = function()
      vim.schedule(function()
        vim.o.shiftwidth = 4
      end)
    end,
    group = file_type,
  })
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'javacript', 'typescript' },
    callback = function()
      vim.schedule(function()
        vim.o.shiftwidth = 2
      end)
    end,
    group = file_type,
  })
end

M.keybinds = {
  {
    '<leader>,',
    function()
      api.tree.close()
    end,
    desc = 'Close nvim-tree',
    group = 'tree_close',
  },
  {
    '<leader>.',
    jan_nvim_tree.open_current_dir,
    desc = 'Open nvim-tree in current working directory',
    group = 'tree_open',
  },
  {
    '<leader><space>',
    function()
      telescope_builtin.git_files()
    end,
    desc = 'Fuzzy find git files',
    group = 'git_files',
  },
  {
    '<leader>c',
    function()
      telescope_builtin.commands()
    end,
    desc = 'List all available commands',
    group = 'commands',
  },
  {
    '<leader>u',
    function()
      vim.cmd('UndotreeToggle')
    end,
    desc = 'Toggle Undo tree',
    group = 'undo',
  },
}

return M
