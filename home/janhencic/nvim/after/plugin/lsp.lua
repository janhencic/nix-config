local jan_lsp = require('jan.lsp')

vim.lsp.config("lua_ls",         jan_lsp.setup_lua)
vim.lsp.config("rust_analyzer",  jan_lsp.setup_ts)
vim.lsp.config("ts_ls",          jan_lsp.setup_ts)
vim.lsp.config("bashls",         jan_lsp.bashls)
vim.lsp.config("pyright",        jan_lsp.pyright)
vim.lsp.config("nil_ls",         jan_lsp.nil_ls)
vim.lsp.config("intelephense",   jan_lsp.intelephense)
vim.lsp.config("ccls",           jan_lsp.ccls)
vim.lsp.config("terraformls",    jan_lsp.terraform_ls)
vim.lsp.config("gopls",          jan_lsp.gopls)
vim.lsp.config("sqls",           jan_lsp.sqls)
vim.lsp.config("omnisharp",      jan_lsp.omnisharp)
vim.lsp.config("fish_lsp",       jan_lsp.fish_lsp)
vim.lsp.config("ruby_lsp",       jan_lsp.fish_lsp)

vim.lsp.enable({
  "lua_ls",
  "rust_analyzer",
  "ts_ls",
  "bashls",
  "pyright",
  "nil_ls",
  "intelephense",
  "ccls",
  "terraformls",
  "gopls",
  "sqls",
  "omnisharp",
  "fish_lsp",
  "ruby_lsp",
})

jan_lsp.create_lsp_cursorhold_autocmd()
