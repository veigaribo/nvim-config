local lang = {}

lang.plugin = {}

lang.lsp = {
	server = 'denols',
	options = {},
}

lang.formatters = {
	typescript = { 'deno_fmt' },
}

function lang.global_setup()
	vim.g.markdown_fenced_languages = {
		'ts=typescript',
	}
end

return lang
