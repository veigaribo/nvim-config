local lang = {}

lang.plugin = {
	{
		'folke/lazydev.nvim',
		ft = 'lua',
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = 'luvit-meta/library', words = { 'vim%.uv' } },
			},
		},
	},
	{ 'Bilal2453/luvit-meta', lazy = true },
}

lang.lsp = {
	server = 'lua_ls',
	options = {
		settings = {
			Lua = {
				completion = { callSnippet = 'Replace' },
				format = { enable = false },
			},
		},
	}
}

return lang
