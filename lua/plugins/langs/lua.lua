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
				diagnostics = { disable = { 'lowercase-global' } },
				completion = { callSnippet = 'Replace' },
				format = { enable = false },
				workspace = {
					userThirdParty = {
						vim.fn.expand('~/.local/share/luals-addons/'),
					},
				},
			},
		},
	},
}

lang.formatters = {
	lua = { 'stylua' },
}

return lang
