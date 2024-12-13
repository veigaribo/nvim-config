local fs = {}

local tfs = require 'fs.telescope'

local function create_parents(path)
	local dirname = vim.fs.dirname(path)
	vim.fn.mkdir(dirname, 'p')
end

local function write_to_file(path)
	create_parents(path)
	local lines = vim.api.nvim_buf_get_lines(
		0,
		0,
		vim.api.nvim_buf_line_count(0),
		false
	)
	vim.fn.writefile(lines, path)
end

local function file_exists(path)
	return vim.fn.empty(vim.fn.glob(path)) == 0
end

local function get_buffer_file()
	local bufnr = vim.api.nvim_get_current_buf()
	local path = vim.api.nvim_buf_get_name(bufnr)

	if not file_exists(path) then
		vim.print(
			'Current buffer '
				.. path
				.. ' does not correspond to a valid file.'
		)
		return nil
	end

	return path
end

local function get_buffer_dir()
	local file = get_buffer_file()

	if file == nil then
		return vim.fn.getcwd()
	else
		return vim.fs.dirname(file)
	end
end

function fs.save_file()
	tfs.prompt_path_new(get_buffer_dir(), function(path)
		if file_exists(path) then
			local result = vim.fn.confirm(
				'Override file ' .. path .. '?',
				'&Yes\n&No',
				2
			)
			if result ~= 1 then
				vim.print 'Aborted.'
				return
			end
		end

		write_to_file(path)
		vim.cmd('e ' .. path)
	end)
end

function fs.delete_file()
	local path = get_buffer_file()

	if path ~= nil then
		vim.fn.delete(path)
		require('bufdelete').bufdelete(vim.api.nvim_get_current_buf(), true)
	end
end

function fs.move_file()
	tfs.prompt_path_new(get_buffer_dir(), function(path)
		if file_exists(path) then
			local result = vim.fn.confirm(
				'Override file ' .. path .. '?',
				'&Yes\n&No',
				2
			)
			if result ~= 1 then
				vim.print 'Aborted.'
				return
			end
		end

		write_to_file(path)

		local previous_buf = vim.api.nvim_get_current_buf()
		vim.cmd('e ' .. path)
		require('bufdelete').bufdelete(previous_buf, true)
	end)
end

function fs.find_file()
	tfs.prompt_path_existing(get_buffer_dir(), function(path)
		vim.cmd('e ' .. path)
	end)
end

return fs
