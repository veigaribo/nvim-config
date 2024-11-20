return { -- Autoformat
	'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
	{ -- Delete buffers like a normal person
		'famiu/bufdelete.nvim',
		keys = {
			{
				'<leader>bd',
				'<cmd>Bdelete<CR>',
				mode = 'n',
				desc = 'Delete buffer',
			},
		},
	},
}
