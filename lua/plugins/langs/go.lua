local lang = {}

lang.plugin = {}

lang.lsp = {
	server = 'gopls',
	options = {
		settings = {},
	},
}

lang.formatters = {
	go = { 'gofmt' },
}

return lang
