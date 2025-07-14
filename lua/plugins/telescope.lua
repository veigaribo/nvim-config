return { -- Fuzzy finder
	'nvim-telescope/telescope.nvim',
	event = 'VimEnter',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
			cond = function()
				return vim.fn.executable('make') == 1
			end,
		},
		{ 'nvim-telescope/telescope-ui-select.nvim' },
		{
			'nvim-tree/nvim-web-devicons',
			enabled = vim.g.have_nerd_font,
		},
	},
	config = function()
		require('telescope').setup({
			extensions = {
				['ui-select'] = {
					require('telescope.themes').get_dropdown(),
				},
			},
		})

		pcall(require('telescope').load_extension, 'fzf')
		pcall(require('telescope').load_extension, 'ui-select')

		local builtin = require('telescope.builtin')
		vim.keymap.set(
			'n',
			'<leader>sh',
			builtin.help_tags,
			{ desc = 'Search help' }
		)
		vim.keymap.set(
			'n',
			'<leader>sk',
			builtin.keymaps,
			{ desc = 'Search keymaps' }
		)
		vim.keymap.set(
			'n',
			'<leader>sf',
			function() builtin.find_files({ hidden = true }) end,
			{ desc = 'Search files' }
		)
		vim.keymap.set(
			'n',
			'<leader>sw',
			builtin.grep_string,
			{ desc = 'Search current word' }
		)
		vim.keymap.set(
			'n',
			'<leader>sg',
			builtin.live_grep,
			{ desc = 'Search by grep' }
		)
		vim.keymap.set(
			'n',
			'<leader>sr',
			builtin.resume,
			{ desc = 'Search resume' }
		)
		vim.keymap.set(
			'n',
			'<leader>s.',
			builtin.oldfiles,
			{ desc = 'Search recent files' }
		)
		vim.keymap.set(
			'n',
			'<leader>sb',
			builtin.buffers,
			{ desc = 'List buffers' }
		)

		vim.keymap.set(
			'n',
			'<leader>pf',
			builtin.git_files,
			{ desc = 'Search file in project' }
		)
		vim.keymap.set(
			'n',
			'<leader><leader>',
			builtin.git_files,
			{ desc = 'Search file in project' }
		)
		vim.keymap.set(
			'n',
			'<M-x>',
			builtin.commands,
			{ desc = 'List commands' }
		)

		vim.keymap.set(
			'n',
			'<leader>/',
			builtin.current_buffer_fuzzy_find,
			{ desc = 'Fuzzily search in current buffer' }
		)
	end,
}
