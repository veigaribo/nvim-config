return { -- Autoformat
	'stevearc/conform.nvim',
	event = { 'BufWritePre' },
	cmd = { 'ConformInfo' },
	keys = {
		{
			'<leader>cf',
			function()
				require('conform').format({
					async = true,
					lsp_format = 'fallback',
				})
			end,
			mode = '',
			desc = 'Format buffer',
		},
	},
	opts = {
		notify_on_error = false,
		formatters_by_ft = vim.tbl_extend(
			'error',
			require('plugins.langs').formatters,
			{ ["_"] = { "trim_whitespace" } }
		),
	},
}
