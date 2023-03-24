vim.o.wrap = false

-- Folding with the use of treesitter
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
-- Start with all folds open
vim.o.foldlevelstart = 99
-- If this is not set the column will pop in and out whenever lsp is displaying a warning
-- see https://github.com/neovim/nvim-lspconfig/issues/195 for more information.
vim.o.signcolumn = 'yes'

vim.o.relativenumber = true

-- Stay in visual mode after indenting either left or right
vim.cmd('vnoremap < <gv')
vim.cmd('vnoremap > >gv')
