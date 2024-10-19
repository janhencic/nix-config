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

function M.live_grep_git_repo()
  local cwd = vim.loop.cwd()
  local cmd = { 'git', 'rev-parse', '--show-toplevel', '-C', cwd }

  local output = vim.fn.systemlist(cmd)

  telescope_builtin.live_grep({ cwd = output[1] })
end

return M
