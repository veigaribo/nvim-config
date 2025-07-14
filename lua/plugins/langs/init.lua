local langs = {}

local lang_modules = {
	require('plugins.langs.c'),
	require('plugins.langs.css'),
	require('plugins.langs.lua'),
	require('plugins.langs.go'),
	require('plugins.langs.python'),
	require('plugins.langs.rust'),
	require('plugins.langs.scala'),
	require('plugins.langs.typescript'),
}

langs.plugin = {}
langs.lsp = {}
langs.formatters = {}
langs.global_setups = {}

for _, lang in ipairs(lang_modules) do
	for _, plugin in ipairs(lang.plugin) do
		langs.plugin[#langs.plugin + 1] = plugin
	end

	if lang.lsp ~= nil then
		langs.lsp[#langs.lsp + 1] = lang.lsp
	end

	langs.formatters =
		vim.tbl_extend('error', langs.formatters, lang.formatters or {})

	if lang.global_setup ~= nil then
		langs.global_setups[#langs.global_setups + 1] =
			lang.global_setup
	end
end

function langs.global_setup()
	for _, setup in ipairs(langs.global_setups) do
		setup()
	end
end

return langs
