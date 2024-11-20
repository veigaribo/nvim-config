return { -- Show pending keybinds.
	'folke/which-key.nvim',
	event = 'VimEnter',
	opts = {
		icons = {
			mappings = vim.g.have_nerd_font,
			keys = vim.g.have_nerd_font and {} or {
				Up = '<Up> ',
				Down = '<Down> ',
				Left = '<Left> ',
				Right = '<Right> ',
				C = '<C-…> ',
				M = '<M-…> ',
				D = '<D-…> ',
				S = '<S-…> ',
				CR = '<CR> ',
				Esc = '<Esc> ',
				ScrollWheelDown = '<ScrollWheelDown> ',
				ScrollWheelUp = '<ScrollWheelUp> ',
				NL = '<NL> ',
				BS = '<BS> ',
				Space = '<Space> ',
				Tab = '<Tab> ',
				F1 = '<F1>',
				F2 = '<F2>',
				F3 = '<F3>',
				F4 = '<F4>',
				F5 = '<F5>',
				F6 = '<F6>',
				F7 = '<F7>',
				F8 = '<F8>',
				F9 = '<F9>',
				F10 = '<F10>',
				F11 = '<F11>',
				F12 = '<F12>',
			},
		},

		spec = {
			{ '<leader>b',  group = 'Buffer' },
			{ '<leader>c',  group = 'Code',   mode = { 'n', 'x' } },
			{ '<leader>cs', group = 'Symbols' },
			{ '<leader>f',  group = 'File' },
			{ '<leader>p',  group = 'Project' },
			{ '<leader>s',  group = 'Search' },
			{ '<leader>w',  group = 'Window' },
			{ '<leader>x',  group = 'Errors' },
		},
	},
}

