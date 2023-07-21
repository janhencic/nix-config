vim.api.nvim_set_hl(0, 'InactiveWindow', { bg = '#080707' })
vim.g.mapleader = ' '
-- Stay in visual mode after indenting either left or right
vim.cmd('vnoremap < <gv')
vim.cmd('vnoremap > >gv')
vim.g.netrw_banner = false
vim.g.netrw_keepdir = false
vim.o.autochdir = true
vim.o.expandtab = true
-- Folding with the use of treesitter
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
-- Start with all folds open
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'expr'
vim.o.foldmethod = 'expr'
vim.o.number = true
vim.o.relativenumber = true
-- My default shift width
vim.o.shiftwidth = 4
-- If this is not set the column will pop in and out whenever lsp is displaying a warning
-- see https://github.com/neovim/nvim-lspconfig/issues/195 for more information.
vim.o.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.updatetime = 300
vim.o.wrap = false
