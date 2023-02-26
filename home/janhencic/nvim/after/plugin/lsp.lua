local jan_lsp = require('jan.lsp')

require('lspconfig')['sumneko_lua'].setup(jan_lsp.setup_lua)
require('lspconfig')['rust_analyzer'].setup(jan_lsp.setup_ts)
require('lspconfig')['tsserver'].setup(jan_lsp.setup_ts)

jan_lsp.create_lsp_cursorhold_autocmd()
