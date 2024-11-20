return {
	{ -- Highlight todo, notes, etc.
		'folke/todo-comments.nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = { signs = false },
	},
	{ -- Status line
		'echasnovski/mini.statusline',
	},
	{ -- Add indentation guides on blank lines
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		opts = {},
	},
}
