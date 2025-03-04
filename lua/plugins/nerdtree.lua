return {
	'preservim/nerdtree',
	config = function()
		vim.keymap.set(
			'n',
			'<leader>ot',
			'<cmd>NERDTree<CR>',
			{ desc = 'Open NERDTree' }
		)
	end
}
