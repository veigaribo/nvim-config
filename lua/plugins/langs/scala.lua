local lang = {}

lang.plugin = {}

lang.lsp = {
	server = 'metals',
	options = {}
}

lang.formatters = {
	scala = { "scalafmt" },
	sbt = { "scalafmt" },
}

return lang
