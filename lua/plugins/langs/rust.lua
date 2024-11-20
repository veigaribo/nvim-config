local lang = {}

lang.plugin = {}

lang.lsp = {
	server = 'rust_analyzer',
	options = {
		settings = {
			['rust-analyzer'] = {
				cargo = { features = 'all' },
			},
		},
	}
}

return lang