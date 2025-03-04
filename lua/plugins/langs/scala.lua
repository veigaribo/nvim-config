local lang = {}

-- Cache
lang._metals_config = nil

local function get_metals_config()
	if lang._metals_config ~= nil then
		return lang._metals_config
	end

	local metals_config = require('metals').bare_config()

	metals_config.settings = {
		showImplicitArguments = true,
		useGlobalExecutable = true,
	}

	metals_config.init_options.statusBarProvider = 'off'
	metals_config.capabilities =
		require('cmp_nvim_lsp').default_capabilities()

	metals_config.on_attach = function(client, bufnr)
		require('plugins.lsp').setup_keymaps(client, bufnr)
	end

	lang._metals_config = metals_config
	return metals_config
end

lang.plugin = {
	{
		'scalameta/nvim-metals',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ -- LSP status updates
				'j-hui/fidget.nvim',
				opts = {},
			},
		},
		ft = { 'scala', 'sbt', 'java' },
		opts = get_metals_config,
		config = function() end,
	},
}

-- No LSP, as we're using nvim-metals

lang.formatters = {
	scala = { 'scalafmt' },
	sbt = { 'scalafmt' },
}

function lang.global_setup()
	vim.api.nvim_create_user_command('MetalsStart', function()
		require('metals').initialize_or_attach(get_metals_config())
	end, { desc = 'Start Metals (Scala)' })
end

return lang
