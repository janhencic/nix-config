local jan_lsp = require('jan.lsp')

require('lspconfig')['lua_ls'].setup(jan_lsp.setup_lua)
require('lspconfig')['rust_analyzer'].setup(jan_lsp.setup_ts)
require('lspconfig')['tsserver'].setup(jan_lsp.setup_ts)
require('lspconfig')['bashls'].setup(jan_lsp.bashls)
require('lspconfig')['pyright'].setup(jan_lsp.pyright)
require('lspconfig')['nil_ls'].setup(jan_lsp.nil_ls)
require('lspconfig')['intelephense'].setup(jan_lsp.intelephense)
require('lspconfig')['ccls'].setup(jan_lsp.ccls)

jan_lsp.create_lsp_cursorhold_autocmd()
