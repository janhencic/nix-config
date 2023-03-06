vim.g.mapleader = ' '
local wk = require('which-key')
local neogit = require('neogit')
local telescope_builtin = require('telescope.builtin')
require('jan.set')
local jan_nvim_tree = require('jan.nvim_tree')
local jan_telescope = require('jan.telescope')
local jan_tab = require('jan.tab')

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

wk.register({
  f = {
    name = 'file',
    t = {
      function()
        vim.cmd('NvimTreeToggle')
      end,
      'ToggleNvimTree',
    },
    r = {
      function()
        telescope_builtin.oldfiles()
      end,
      'Open recently opned files',
    },
    f = {
      function()
        telescope_builtin.commands()
      end,
      'List all available commands',
    },
  },
  w = {
    name = 'window',
    s = {
      function()
        vim.cmd('split')
      end,
      'horizontal split',
    },
    v = {
      function()
        vim.cmd('vsplit')
      end,
      'vertical split',
    },
    d = {
      function()
        vim.cmd('q')
      end,
      'close current splt',
    },
    l = {
      function()
        vim.cmd('wincmd l')
      end,
      'Move to right split',
    },
    h = {
      function()
        vim.cmd('wincmd h')
      end,
      'Move to left split',
    },
    j = {
      function()
        vim.cmd('wincmd j')
      end,
      'Move to bottom split',
    },
    k = {
      function()
        vim.cmd('wincmd k')
      end,
      'Move to top split',
    },
  },
  t = {
    name = 'terminal',
    o = {
      function()
        vim.cmd('term')
      end,
      'open terminal in current split',
    },
  },
  l = {
    name = 'lsp',
    d = jan_telescope.lsp_definitions,
    D = {
      function()
        vim.lsp.buf.declaration()
      end,
      'go declaration',
    },
    r = jan_telescope.lsp_references,
    ['R'] = {
      function()
        vim.lsp.buf.rename()
      end,
      'rename variable or struct',
    },
    v = {
      function()
        vim.lsp.buf.hover()
      end,
      'show varible type under cursor',
    },
  },
  g = {
    g = {
      function()
        neogit.open()
      end,
      'open negit',
    },
  },
  k = {
    function()
      vim.cmd('NvimTreeOpen')
    end,
    'OpenNvimTree',
  },
  u = {
    function()
      vim.cmd('UndotreeToggle')
    end,
    'Toggle Undo tree',
  },
  s = {
    d = {
      function()
        telescope_builtin.live_grep()
      end,
      'Search for a string in your current working directory and get results live as you type, respects .gitignore',
    },
    f = {
      function()
        telescope_builtin.find_files()
      end,
      'Search for a string in your current working directory and get results live as you type, respects .gitignore',
    },
  },
  c = {
    function()
      telescope_builtin.commands()
    end,
    'List all available commands',
  },
  ['<tab>'] = jan_tab.keybinds(),
  ['<space>'] = {
    function()
      telescope_builtin.git_files()
    end,
    'Fuzzy search through the output of git ls-files command, respects .gitignore',
  },
  ['.'] = {
    jan_nvim_tree.open_current_dir,
    'Open nvim-tree in current folder',
  },
  [','] = jan_nvim_tree.close,
}, { prefix = '<leader>' })

function MyWinEnter()
  -- vim.api.nvim_set_option('winhighlight', 'NormalNC:InactiveWindow')
end

MyWinEnter()

vim.api.nvim_set_option('termguicolors', true)
vim.cmd('colorscheme tokyonight-moon')
require('tokyonight').setup({
  styles = {
    variables = { 'transparent' },
  },
})
vim.api.nvim_set_hl(0, 'InactiveWindow', { bg = '#080707' })

vim.g.netrw_keepdir = false

local myWinEnterGroup = vim.api.nvim_create_augroup('MyWinEnterGroup', { clear = true })
vim.api.nvim_create_autocmd({ 'WinEnter' }, { pattern = '*', callback = MyWinEnter, group = myWinEnterGroup })
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.number = true
vim.o.autochdir = true

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

vim.g.netrw_banner = false

vim.o.updatetime = 300

-- Folding with the use of treesitter
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
-- Start with all folds open
vim.o.foldlevelstart = 99
