local M = {}
local api = require('nvim-tree.api')

local function cr_keymap()
  local node = api.tree.get_node_under_cursor()
  assert(node, 'Could not get nvim-tree node under cursor')

  if node.type == 'file' or node.type == 'link' then
    api.node.open.edit(node)
    print('file')
  elseif node.type == 'directory' then
    api.tree.change_root_to_node(node)
    api.tree.collapse_all()
  else
    print('Unknown node type')
  end
end

local function tab_keymap()
  local node = api.tree.get_node_under_cursor()
  assert(node, 'Could not get nvim-tree node under cursor')

  -- I want to only expand an nvim-tree directory with <Tab>
  if node.type == 'directory' then
    api.node.open.edit(node)
  end
end

local function dash_keymap()
  api.tree.change_root_to_parent()
  api.tree.collapse_all()
end

function M.on_attach(bufnr)
  vim.keymap.set('n', '<CR>', cr_keymap, {
    buffer = bufnr,
    noremap = true,
    nowait = true,
    desc = 'Change root to node under cursor',
  })

  vim.keymap.set('n', '<Tab>', tab_keymap, {
    buffer = bufnr,
    noremap = true,
    nowait = true,
    desc = 'Preview node under cursor',
  })

  vim.keymap.set('n', '-', dash_keymap, {
    buffer = bufnr,
    noremap = true,
    nowait = true,
    desc = 'Preview node under cursor',
  })
end

M.open_current_dir = {
  function()
    vim.cmd('NvimTreeToggle')
    local cwd = vim.fn.getcwd()
    api.tree.open(cwd)
    api.tree.change_root(cwd)
  end,
  'Open nvim-tree in current working directory',
}

M.open = {
  function()
    api.tree.open()
  end,
  'Open nvim-tree',
}

M.close = {
  function()
    api.tree.close()
  end,
  'Close nvim-tree',
}

return M
