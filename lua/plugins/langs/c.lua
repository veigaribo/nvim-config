local lang = {}

lang.plugin = {}

lang.lsp = {
	server = 'clangd',
	options = {},
}

lang.formatters = {
	c = { 'clang-format' },
	cpp = { 'clang-format' },
	cc = { 'clang-format' },
}

return lang
