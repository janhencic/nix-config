vim.o.wrap = false

-- Folding with the use of treesitter
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
-- Start with all folds open
vim.o.foldlevelstart = 99
