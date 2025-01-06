local langs = {}

local lang_modules = {
	require 'plugins.langs.css',
	require 'plugins.langs.lua',
	require 'plugins.langs.rust',
	require 'plugins.langs.scala',
}

langs.plugin = {}
langs.lsp = {}
langs.formatters = {}

for _, lang in ipairs(lang_modules) do
	for _, plugin in ipairs(lang.plugin) do
		langs.plugin[#langs.plugin+1] = plugin
	end

	langs.lsp[#langs.lsp+1] = lang.lsp

	langs.formatters = vim.tbl_extend(
		'error',
		langs.formatters,
		lang.formatters or {}
	)
end

return langs
