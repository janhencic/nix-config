local wk = require('which-key')

local jan = require('jan')
local jan_file = require('jan.file')
local jan_git = require('jan.git')
local jan_lsp = require('jan.lsp')
local jan_run = require('jan.run')
local jan_search = require('jan.search')
local jan_tab = require('jan.tab')
local jan_terminal = require('jan.terminal')
local jan_set = require('jan.set')

require('jan.table')

local M = {}

function M.run()
  local keybinds = {}

  keybinds = table.merge_lists(keybinds, jan_git.keybinds)
  keybinds = table.merge_lists(keybinds, jan.keybinds)
  keybinds = table.merge_lists(keybinds, jan_file.keybinds)
  keybinds = table.merge_lists(keybinds, jan_lsp.keybinds)
  keybinds = table.merge_lists(keybinds, jan_run.keybinds)
  keybinds = table.merge_lists(keybinds, jan_search.keybinds)
  keybinds = table.merge_lists(keybinds, jan_tab.keybinds())
  keybinds = table.merge_lists(keybinds, jan_terminal.keybinds)
  keybinds = table.merge_lists(keybinds, jan_set.keybinds)

  wk.add(keybinds)

  jan.set_colorscheme()
  jan.create_autocmd()
  jan_set.set()
end

return M
