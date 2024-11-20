local langs = {}

local lua = require 'plugins.langs.lua'
local rust = require 'plugins.langs.rust'

langs.plugin = {}
langs.lsp = {}

for _, lang in ipairs({ lua, rust }) do
	for _, plugin in ipairs(lang.plugin) do
		langs.plugin[#langs.plugin+1] = plugin
	end

	langs.lsp[#langs.lsp+1] = lang.lsp
end

return langs
