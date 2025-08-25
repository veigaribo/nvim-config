local lsp = {}

function lsp.setup_keymaps(client, bufnr)
	local telescope = require('telescope.builtin')
-- stylua: ignore start
	local bind = function(mode, keys, func, desc)
		vim.keymap.set(mode, keys, func,
			{ buffer = bufnr, desc = 'LSP: ' .. desc })
	end

	bind('n', 'gd', telescope.lsp_definitions,
		'Go to definition')
	bind('n', 'gD', vim.lsp.buf.declaration,
		'Go to declaration')
	bind('n', '<leader>cr', telescope.lsp_references,
		'Go to references')
	bind('n', '<leader>cI', telescope.lsp_implementations,
		'Go to implementation')
	bind('n', '<leader>cD', telescope.lsp_type_definitions,
		'Type definition')
	bind('n', '<leader>csd', telescope.lsp_document_symbols,
		'Document symbols')
	bind('n', '<leader>cr', vim.lsp.buf.rename,
		'Rename')
	bind({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action,
		'Code action')

	bind(
		'n',
		'<leader>csw',
		telescope.lsp_dynamic_workspace_symbols,
		'Workspace symbols'
	)
	-- stylua: ignore end

	if
		client
		and client.supports_method(
			vim.lsp.protocol.Methods.textDocument_documentHighlight
		)
	then
		local highlight_augroup = vim.api.nvim_create_augroup(
			'lsp-highlight',
			{ clear = false }
		)

		vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
			buffer = bufnr,
			group = highlight_augroup,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
			buffer = bufnr,
			group = highlight_augroup,
			callback = vim.lsp.buf.clear_references,
		})

		vim.api.nvim_create_autocmd('LspDetach', {
			group = vim.api.nvim_create_augroup('lsp-detach', {
				clear = true,
			}),
			callback = function(event2)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({
					group = 'lsp-highlight',
					buffer = event2.buf,
				})
			end,
		})
	end

	if
		client
		and client.supports_method(
			vim.lsp.protocol.Methods.textDocument_inlayHint
		)
	then
		bind('n', '<leader>ch', function()
			vim.lsp.inlay_hint.enable(
				not vim.lsp.inlay_hint.is_enabled({
					bufnr = bufnr,
				})
			)
		end, 'Toggle inlay hints')
	end
end

lsp.plugin = {
	'neovim/nvim-lspconfig',
	dependencies = {
		-- LSP status updates
		{ 'j-hui/fidget.nvim', opts = {} },
		-- Completions
		'hrsh7th/cmp-nvim-lsp',
	},
	config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('lsp-attach', {
				clear = true,
			}),
			callback = function(event)
				local client =
					vim.lsp.get_client_by_id(event.data.client_id)

				lsp.setup_keymaps(client, event.buf)
			end,
		})

		local default_capabilities =
			vim.lsp.protocol.make_client_capabilities()

		local capabilities_with_completion = vim.tbl_deep_extend(
			'force',
			default_capabilities,
			require('cmp_nvim_lsp').default_capabilities()
		)

		local setup = function(server_name, options)
			options.capabilities = vim.tbl_deep_extend(
				'force',
				options.capabilities or {},
				capabilities_with_completion
			)

			-- require('lspconfig')[server_name].setup(
			-- 	vim.tbl_extend('force', { autostart = false }, options)
			-- )

			-- Do NOT autostart
			vim.lsp.config(
				server_name,
				vim.tbl_extend('force', { autostart = false }, options)
			)
		end

		local langs = require('plugins.langs')
		for _, lang in ipairs(langs.lsp) do
			setup(lang.server, lang.options)
		end
	end,
}

return lsp
