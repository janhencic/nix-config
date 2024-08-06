local M = {}

-- TODO: confirm if this is correct
local function vim_runtime_path()
  local path = vim.split(package.path, ';')
  table.insert(path, 'lua/?.lua')
  table.insert(path, 'lua/?/init.lua')
  return path
end

-- TODO: confirm if this is correct
local function vim_library_path()
  vim.api.nvim_get_runtime_file('', true)
end

M.setup_lua = {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim_runtime_path(),
      },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        library = vim_library_path(),
        maxPreload = 2000,
        preloadFileSize = 50000,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

M.setup_rust = {
  flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  },
  settings = {
    ['rust-analyzer'] = {},
  },
}

-- Make sure to install tsserver from the nix unstable channel.
-- It is currently broken on nixos-22.11.
-- See https://github.com/NixOS/nixpkgs/issues/210051 for more details
M.setup_ts = {}

M.bashls = {}

M.pyright = {}

M.nil_ls = {}

M.gopls = {}

M.sqls = {}

-- I'm going to use ccls instead
-- M.clangd = {}

M.intelephense = {}

M.ccls = {
  filetypes = { 'c', 'h', 'objc', 'objcpp', 'cuda', 'cpp' },
  compilationDatabaseDirectory = 'build',
}

M.terraform_lsp = {}

local function is_in_list(value, list)
  for _, v in ipairs(list) do
    if v == value then
      return true
    end
  end

  return false
end

-- Triggers `vim.lsp.buf.document_highlight` when the cursor is held stationary at a single location.
-- This function is active for all files with an LSP server attached, assuming the feature is supported.
-- Files with LSP servers that do not support document highlighting are explicitly excluded.
local function cursor_hold_callback()
  if not is_in_list(vim.o.filetype, { "terraform", "sql" }) then
    vim.lsp.buf.document_highlight()
  end
end

-- Activates `vim.lsp.buf.clear_references` whenever the cursor is moved.
local function cursor_moved_callback()
  if not is_in_list(vim.o.filetype, { "terraform", "sql" }) then
    vim.lsp.buf.clear_references()
  end
end

function M.create_lsp_cursorhold_autocmd()
  local lsp_document_highlight = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
  vim.api.nvim_create_autocmd(
    { 'CursorHold' },
    { pattern = '*', callback = cursor_hold_callback, group = lsp_document_highlight }
  )
  vim.api.nvim_create_autocmd(
    { 'CursorMoved' },
    { pattern = '*', callback = cursor_moved_callback, group = lsp_document_highlight }
  )
end

M.rename = {
  function()
    vim.lsp.buf.rename()
  end,
  'rename all references to the symbol under the cursor',
}

M.hover = {
  function()
    vim.lsp.buf.hover()
  end,
  'display hover information about the symbol under the cursor',
}

M.declaration = {
  function()
    vim.lsp.buf.declaration()
  end,
  'jump to the declaration of the symbol under the cursor',
}

M.action = {
  function()
    vim.lsp.buf.code_action()
  end,
  'run lsp code_action'
}

return M
