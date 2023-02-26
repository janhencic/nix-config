local ls = require('luasnip')
local jan_snips = require('jan.snips')

ls.config.set_config({
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = false,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = 'TextChanged,TextChangedI',

  delete_check_events = 'TextChanged',
  enable_autosnippets = true,
})

-- <C-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ 'i', 's' }, '<C-j>', function()
  if ls.expand_or_jumpable() then
    local res = ls.expand_or_jump()
    print(res)
  end
end, { silent = true })

-- <C-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ 'i', 's' }, '<C-k>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- <C-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set('i', '<c-l>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

jan_snips.lua()
jan_snips.bash()
jan_snips.js()
