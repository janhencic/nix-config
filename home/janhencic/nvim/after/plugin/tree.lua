local jan_nvim_tree = require('jan.nvim_tree')

require('nvim-tree').setup({
  on_attach = jan_nvim_tree.on_attach,
})
