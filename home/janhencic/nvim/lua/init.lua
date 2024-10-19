local wk = require('which-key')
require('jan.set')
local jan_nvim_tree = require('jan.nvim_tree')
local jan_telescope = require('jan.telescope')
local jan_tab = require('jan.tab')
local jan_lsp = require('jan.lsp')
local jan = require('jan')

local M = {}

function M.run(js_debugger_path)
  wk.register({
    f = {
      name = 'file',
      r = jan_telescope.oldfiles,
    },
    w = {
      name = 'window',
      s = jan_tab.horizontal_split,
      v = jan_tab.vertical_split,
      d = jan_tab.close_split,
      l = jan_tab.move_right,
      h = jan_tab.move_left,
      j = jan_tab.move_down,
      k = jan_tab.move_up,
    },
    t = {
      name = 'terminal',
      o = jan.open_terminal,
    },
    l = {
      name = 'lsp',
      d = jan_telescope.lsp_definitions,
      D = jan_lsp.declaration,
      r = jan_telescope.lsp_references,
      R = jan_lsp.rename,
      v = jan_lsp.hover,
      a = jan_lsp.action,
    },
    g = {
      g = jan.open_neogit,
    },
    u = jan.toggle_undo_tree,
    s = {
      d = jan_telescope.live_grep,
      f = jan_telescope.find_files,
      p = jan_telescope.live_grep_git_repo,
    },
    c = jan_telescope.commands,
    r = {
      name = 'run',
      c = jan.cargo_check,
    },
    ['<tab>'] = jan_tab.keybinds(),
    ['<space>'] = jan_telescope.git_files,
    ['.'] = jan_nvim_tree.open_current_dir,
    ['>'] = jan_nvim_tree.open,
    [','] = jan_nvim_tree.close,
  }, { prefix = '<leader>' })

  jan.set_colorscheme()
  jan.create_autocmd()
end

return M
