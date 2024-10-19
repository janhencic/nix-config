local M = {}

local telescope_builtin = require('telescope.builtin')
local default_picker_config = require('telescope.themes').get_ivy({ layout_config = { height = 18 } })

M.setup = {
  pickers = {
    git_files = default_picker_config,
    oldfiles = default_picker_config,
    commands = default_picker_config,
    command_history = default_picker_config,
    live_grep = default_picker_config,
    lsp_definitions = default_picker_config,
    lsp_references = {
      path_display = { 'smart' },
    },
  },
}

function M.command_history_keymap()
  vim.keymap.set('n', '<A-x>', function()
    telescope_builtin.command_history()
  end)
end

M.lsp_definitions = {
  function()
    telescope_builtin.lsp_definitions()
  end,
  'Show lsp variable definitions with telescope',
}

M.lsp_references = {
  function()
    telescope_builtin.lsp_references()
  end,
  'Show lsp variable refferences with telescope',
}

local function live_grep_git_repo()
  local cwd = vim.loop.cwd()
  local cmd = { 'git', 'rev-parse', '--show-toplevel', '-C', cwd }

  local output = vim.fn.systemlist(cmd)

  telescope_builtin.live_grep({ cwd = output[1] })
end

M.live_grep_git_repo = {
  live_grep_git_repo,
  'Live grep git repository',
}

M.live_grep = {
  function()
    telescope_builtin.live_grep()
  end,
  'Live grep cwd',
}

M.find_files = {
  function()
    telescope_builtin.find_files()
  end,
  'Find file in cwd',
}

M.commands = {
  function()
    telescope_builtin.commands()
  end,
  'List all available commands',
}

M.oldfiles = {
  function()
    telescope_builtin.oldfiles()
  end,
  'Open recently opened files',
}

M.git_files = {
  function()
    telescope_builtin.git_files()
  end,
  'Fuzzy find git files',
}

return M
