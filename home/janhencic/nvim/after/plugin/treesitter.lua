-- Defines a read-write directory for treesitters in nvim's cache dir
local parser_install_dir = vim.fn.stdpath('cache') .. '/treesitters'
vim.fn.mkdir(parser_install_dir, 'p')
-- Prevents reinstall of treesitter plugins every boot
vim.opt.runtimepath:append(parser_install_dir)

local parsers = {
  'bash',
  'c',
  'javascript',
  'lua',
  'nix',
  'rust',
  'typescript',
  'vimdoc',
  'hyprlang',
  'markdown',
  'markdown_inline'
}

require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all"
  ensure_installed = parsers,
  parser_install_dir = parser_install_dir,

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,


  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})

require('treesitter-context').setup({
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 1, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = false,
  multiline_threshold = 1, -- Maximum number of lines to collapse for a single context line
  trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'topline', -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
})

vim.filetype.add({
  pattern = { [".*/hyprland/.*%.conf"] = "hyprlang" },
})

