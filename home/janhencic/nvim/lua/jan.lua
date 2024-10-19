local M = {}

local neogit = require('neogit')

-- I miss Magit :(
M.open_neogit = {
  function()
    neogit.open()
  end,
  'Open Neogit',
}

M.cargo_check = {
  function()
    vim.cmd('split term://cargo check')
  end,
  'Run Cargo check',
}

M.open_terminal = {
  function()
    vim.cmd('term')
  end,
  'Open terminal',
}

M.toggle_undo_tree = {
  function()
    vim.cmd('UndotreeToggle')
  end,
  'Toggle Undo tree',
}

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

return M
