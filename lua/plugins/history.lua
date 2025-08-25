---@module 'lazy'
---@type LazyPluginSpec
return {
	'veigaribo/winhist.nvim',
	lazy = false,
	---@module 'winhist'
	---@type WinHistOptions
	opts = {},
	config = function()
		local winhist = require('winhist')
		winhist.setup()

		vim.keymap.set('n', '<leader>b[', winhist.previous)
		vim.keymap.set('n', '<leader>b]', winhist.next)
		vim.keymap.set('n', '<leader>b?', winhist.dump)
	end,
}
