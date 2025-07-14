local lang = {}

lang.plugin = {}

lang.lsp = {
	server = 'basedpyright',
	options = {
		settings = {},
	},
}

lang.formatters = {
	python = { 'yapf' },
}

return lang
