---@module 'lazy'
---@type LazyPluginSpec
return {
	'veigaribo/winhist.nvim',
	lazy = false,
	---@module 'winhist'
	---@type WinHistOptions
	opts = {},
	config = function(_, opts)
		local winhist = require('winhist')
		winhist.setup(opts)

		vim.keymap.set(
			'n',
			'<leader>b[',
			winhist.previous,
			{ desc = 'Go to previous buffer' }
		)
		vim.keymap.set(
			'n',
			'<leader>b]',
			winhist.next,
			{ desc = 'Go to next buffer' }
		)
		vim.keymap.set(
			'n',
			'<leader>b?',
			winhist.dump,
			{ desc = 'Print window histories' }
		)
	end,
}
