local tfs = {}

tfs.kind_dir = 'd'
tfs.kind_file = 'f'
tfs.kind_link = 'l'

function tfs.file_picker(opts)
	local actions = require 'telescope.actions'
	local action_state = require 'telescope.actions.state'
	local finders = require 'telescope.finders'
	local pickers = require 'telescope.pickers'
	local sorters = require 'telescope.sorters'

	opts = opts or {}

	local cwd = opts.cwd
	local allow_insert = opts.allow_insert or false
	local insert_symbol = true

	local fs_nodes_raw = vim
		.system({ 'ls', '-la', cwd }, { text = true })
		:wait()
	assert(
		fs_nodes_raw.code == 0,
		'Error running ls: ' .. fs_nodes_raw.stderr
	)

	---@type (string|boolean)[]
	local results =
		vim.split(fs_nodes_raw.stdout, '\n', { trimempty = true })
	table.remove(results, 1) -- Header
	table.remove(results, 1) -- Irrelevant .

	if allow_insert then results[#results + 1] = insert_symbol end

	local to_entry = function(entry)
		if entry == insert_symbol then
			return {
				value = insert_symbol,
				display = '* Insert',
				ordinal = '',
			}
		end

		-- TODO: How to express `\s+`?
		local cut = vim.split(entry, ' +')
		local perms = cut[1]
		local name = cut[9]

		local perms_head = string.sub(perms, 1, 1)
		local is_dir = perms_head == 'd'
		local is_link = perms_head == 'l'
		local node_kind

		if is_dir then
			node_kind = tfs.kind_dir
		elseif is_link then
			node_kind = tfs.kind_link
		else
			node_kind = tfs.kind_file
		end

		local value = { name = name, kind = node_kind }
		local display

		if is_dir then
			display = entry .. '/'
		else
			display = entry
		end

		return {
			value = value,
			display = display,
			ordinal = name,
		}
	end

	local base_sorter = sorters.get_substr_matcher()
	local sorter = sorters.Sorter:new {
		highlighter = base_sorter.highlighter,
		scoring_function = function(sorter, prompt, line, entry)
			if entry.value == insert_symbol then return 0 end
			local base_score =
				base_sorter.scoring_function(sorter, prompt, line, entry)

			-- Make directories more easily accessible
			if entry.kind == tfs.kind_file then
				return base_score + 50
			else
				return base_score
			end
		end,
	}

	local function attach_mappings(_, map)
		local reload_picker
		local close_picker = actions.close

		-- CR
		actions.select_default:replace(function(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			assert(selection ~= nil, 'Unexpected nil selection')

			if selection.value == insert_symbol then
				local line = action_state.get_current_line()
				local path = vim.fs.joinpath(cwd, line)
				close_picker(prompt_bufnr)
				opts.callback(path)
				return
			end

			local kind = selection.value.kind
			local path = vim.fs.joinpath(cwd, selection.value.name)

			if kind == tfs.kind_dir or kind == tfs.kind_link then
				reload_picker(prompt_bufnr, path)
			else
				close_picker(prompt_bufnr)
				opts.callback(path)
			end
		end)

		local function cd_into(prompt_bufnr)
			local selection = action_state.get_selected_entry()

			if selection then
				local kind = selection.value.kind

				if kind == tfs.kind_dir or kind == tfs.kind_link then
					local path = vim.fs.joinpath(cwd, selection.value.name)
					reload_picker(prompt_bufnr, path)
				end
			end
		end

		local function cd_back(prompt_bufnr)
			local path = vim.fs.dirname(cwd)
			reload_picker(prompt_bufnr, path)
		end

		map('n', '<BS>', cd_back)
		map('i', '<BS>', function(prompt_bufnr)
			local line = action_state.get_current_line()
			if line == '' then
				cd_back(prompt_bufnr)
			else
				local key =
					vim.api.nvim_replace_termcodes('<BS>', true, false, true)
				vim.api.nvim_feedkeys(key, 'n', false)
			end
		end)

		map('n', '<Tab>', cd_into)
		map('i', '<Tab>', cd_into)

		reload_picker = function(prompt_bufnr, path)
			close_picker(prompt_bufnr)
			path = vim.fs.normalize(path)

			local new_opts = vim.tbl_extend('force', opts, {
				-- Would be better if it was made relative
				prompt_title = path,
				cwd = path,
				initial_mode = 'normal',
			})

			tfs.file_picker(new_opts)
		end

		return true
	end

	pickers
		.new(opts, {
			prompt_title = opts.cwd,
			finder = finders.new_table {
				results = results,
				entry_maker = to_entry,
			},
			sorter = sorter,
			attach_mappings = attach_mappings,
		})
		:find()
end

function tfs.prompt_path_existing(cwd, callback)
	tfs.file_picker {
		cwd = cwd,
		allow_insert = false,
		callback = callback,
	}
end

function tfs.prompt_path_new(cwd, callback)
	tfs.file_picker {
		cwd = cwd,
		allow_insert = true,
		callback = callback,
	}
end

return tfs
