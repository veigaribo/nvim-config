return { -- Autocompletion
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	keys = {
		{
			'<leader>oo',
			'<cmd>Oil --float<cr>',
			desc = 'Open Oil',
		},
	},
}
