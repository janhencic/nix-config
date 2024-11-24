local M = {}

M.set = function()
  vim.api.nvim_set_hl(0, 'InactiveWindow', { bg = '#080707' })
  vim.g.mapleader = ' '
  -- Stay in visual mode after indenting either left or right
  vim.cmd('vnoremap < <gv')
  vim.cmd('vnoremap > >gv')
  vim.g.netrw_banner = false
  vim.g.netrw_keepdir = false
  vim.o.autochdir = true
  vim.o.expandtab = true
  -- Folding with the use of treesitter
  vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
  -- Start with all folds open
  vim.o.foldlevelstart = 99
  vim.o.foldmethod = 'expr'
  vim.o.foldmethod = 'expr'
  vim.o.number = true
  vim.o.relativenumber = true
  -- My default shift width
  vim.o.shiftwidth = 4
  -- If this is not set the column will pop in and out whenever lsp is displaying a warning
  -- see https://github.com/neovim/nvim-lspconfig/issues/195 for more information.
  vim.o.signcolumn = 'yes'
  vim.o.termguicolors = true
  vim.o.updatetime = 300
  vim.o.wrap = false
  vim.o.tabstop = 4
  vim.o.listchars = "tab:>-,space:·"
end

local function toggle_option(option)
	assert(type(option) == "string", "expected string type for option name")

	local ok, info = pcall(vim.api.nvim_get_option_info, option)
	if not ok then
		error(string.format("'%s' is not a valid Neovim option", option))
	end

	local scope = info.scope -- Can be 'global', 'win', or 'buf'

	local current_value
	if scope == "win" then
		current_value = vim.api.nvim_get_option_value(option, { scope = "local" })
	elseif scope == "buf" then
		current_value = vim.api.nvim_get_option_value(option, { scope = "local" })
	else
		current_value = vim.api.nvim_get_option(option)
	end

	if type(current_value) ~= "boolean" then
		error(string.format("'%s' is not a boolean option", option))
	end

	if scope == "win" or scope == "buf" then
		vim.api.nvim_set_option_value(option, not current_value, { scope = "local" })
	else
		vim.api.nvim_set_option(option, not current_value)
	end
end

M.keybinds = {
	{ "<leader>o", group = "option" },
	{
		"<leader>ol",
		function()
			toggle_option("list")
		end,
		desc = "Toggle list option",
	},
	{
		"<leader>ow",
		function()
			toggle_option("wrap")
		end,
		desc = "Toggle wrap option",
	},
}

return M
