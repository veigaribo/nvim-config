return {
	'folke/trouble.nvim',
	opts = {},
	cmd = 'Trouble',
	keys = {
		{
			'<leader>xx',
			'<cmd>Trouble diagnostics toggle<cr>',
			desc = 'Diagnostics (Trouble)',
		},
		{
			'<leader>cx',
			'<cmd>Trouble diagnostics toggle<cr>',
			desc = 'Diagnostics (Trouble)',
		},
		{
			'<leader>xX',
			'<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
			desc = 'Buffer diagnostics (Trouble)',
		},
		{
			'<leader>cst',
			'<cmd>Trouble symbols toggle focus=false<cr>',
			desc = 'Symbols (Trouble)',
		},
		{
			'<leader>cl',
			'<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
			desc = 'LSP definitions / references / ... (Trouble)',
		},
		{
			'<leader>xL',
			'<cmd>Trouble loclist toggle<cr>',
			desc = 'Location list (Trouble)',
		},
		{
			'<leader>xQ',
			'<cmd>Trouble qflist toggle<cr>',
			desc = 'Quickfix list (Trouble)',
		},
	},
}
