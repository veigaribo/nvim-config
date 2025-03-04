vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false

vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.signcolumn = 'no'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = {
	tab = '» ',
	trail = '·',
	nbsp = '␣',
}

vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.cmd('colorscheme firewatch')
vim.cmd('highlight Normal guibg=none')

-- stylua: ignore start
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>',
	{ desc = 'Exit terminal mode' })

-- `:help wincmd`
vim.keymap.set('n', '<C-h>', '<C-w><C-h>',
	{ desc = 'Move focus to the window on the left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>',
	{ desc = 'Move focus to the window on the right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>',
	{ desc = 'Move focus to the window below' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>',
	{ desc = 'Move focus to the window above' })

vim.keymap.set('n', '<leader>wh', '<C-w><C-h>',
	{ desc = 'Move focus to the window on the left' })
vim.keymap.set('n', '<leader>wl', '<C-w><C-l>',
	{ desc = 'Move focus to the window on the right' })
vim.keymap.set('n', '<leader>wj', '<C-w><C-j>',
	{ desc = 'Move focus to the window below' })
vim.keymap.set('n', '<leader>wk', '<C-w><C-k>',
	{ desc = 'Move focus to the window above' })
vim.keymap.set('n', '<leader>wv', '<C-w><C-v>',
	{ desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>ws', '<C-w><C-s>',
	{ desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>wd', '<C-w>q',
	{ desc = 'Delete window' })

vim.keymap.set('n', '<leader>th', '<cmd>tabprevious<CR>',
	{ desc = 'Move to previous tab' })
vim.keymap.set('n', '<leader>tl', '<cmd>tabnext<CR>',
	{ desc = 'Move to next tab' })
vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>',
	{ desc = 'Create tab' })
vim.keymap.set('n', '<leader>td', '<cmd>tabclose<CR>',
	{ desc = 'Close current tab' })

vim.keymap.set('n', '<leader>b[', '<cmd>bprevious<CR>',
	{ desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>b]', '<cmd>bNext<CR>',
	{ desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bN', '<cmd>enew<CR>',
	{ desc = 'Create buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>Bdelete<CR>',
	{ desc = 'Next buffer' })

vim.keymap.set('n', '<leader>oe', '<cmd>Sex<CR>', { desc = 'Sex' })

vim.keymap.set('n', '<leader>cn', '<cmd>LspStart<CR>',
	{ desc = 'Start LSP' })
vim.keymap.set('n', '<leader>cd', '<cmd>LspStop<CR>',
	{ desc = 'Stop LSP' })
-- stylua: ignore end

-- `:help lazy.nvim.txt` / https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'--branch=stable',
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:\n' .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('plugins.langs').global_setup()

require('lazy').setup({
	require('plugins.which_key'),
	require('plugins.telescope'),
	require('plugins.nerdtree'),
	require('plugins.treesitter'),
	require('plugins.formatting'),
	require('plugins.completion'),
	require('plugins.trouble'),
	require('plugins.flair'),
	require('plugins.util'),

	require('plugins.lsp').plugin,
	require('plugins.langs').plugin,
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = '⌘',
			config = '🛠',
			event = '📅',
			ft = '📂',
			init = '⚙',
			keys = '🗝',
			plugin = '🔌',
			runtime = '💻',
			require = '🌙',
			source = '📄',
			start = '🚀',
			task = '📌',
			lazy = '💤 ',
		},
	},
})
