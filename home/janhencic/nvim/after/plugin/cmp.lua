local cmp = require('cmp')
local lspkind = require('lspkind')

local function border(hl_name)
  return {
    { '╭', hl_name },
    { '─', hl_name },
    { '╮', hl_name },
    { '│', hl_name },
    { '╯', hl_name },
    { '─', hl_name },
    { '╰', hl_name },
    { '│', hl_name },
  }
end

local options = {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = {
      border = border('CmpBorder'),
      winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
    },
    documentation = {
      border = border('CmpDocBorder'),
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    --   ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
    --   ['<C-Space>'] = cmp.mapping.complete(),
    --   ['<C-e>'] = cmp.mapping.abort(),
    ['<C-Space>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'nvim_lsp' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        buffer = '[buf]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[api]',
        path = '[path]',
        luasnip = '[snip]',
      },
    }),
  },
}

cmp.setup(options)

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
