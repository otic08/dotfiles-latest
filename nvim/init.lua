-- Set leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Relative
vim.o.relativenumber = true
vim.o.number = true

-- Case insensitive searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- Sync clipboards
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Raise dialog if unsaved buffer
vim.o.confirm = true

-- Snappy escape
vim.o.timeoutlen = 300

-- Vim diagnostics
vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = false,
	float = { source = 'if_many' },
	jump = { float = true },
})

-- Show diagnostics
vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, { desc = 'Show diagnostics' })

-- Easily move between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Better command line movements
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-f>", "<Right>")
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-e>", "<End>")
vim.keymap.set("c", "<M-b>", "<S-Left>")
vim.keymap.set("c", "<M-f>", "<S-Right>")

-- Highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function() vim.highlight.on_yank({ timeout = 300 }) end,
})

-- Plugins
-- Pack guide: https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack#update
vim.pack.add({
	'https://github.com/ibhagwan/fzf-lua',
	'https://github.com/nvim-treesitter/nvim-treesitter', -- also $ brew install tree-sitter-cli
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/karb94/neoscroll.nvim',
	{ src = 'https://github.com/saghen/blink.cmp',     version = vim.version.range('1.x') }, -- pinning so rust binary dependency automatically downloads
	'https://github.com/mfussenegger/nvim-dap',
	{ src = "https://github.com/catppuccin/nvim",      name = "catppuccin" },
	{ src = "https://github.com/folke/tokyonight.nvim"},
	{ src = 'https://github.com/nvim-orgmode/orgmode' }
})


-- FzfLua Setup
local fzf = require('fzf-lua')
fzf.setup({
	fzf_colors = false,
	grep = {
		rg_opts = table.concat({
			"--column --line-number --no-heading --color=always --smart-case --max-columns=4096",
			"--colors 'path:none'",
			"--colors 'line:none'",
			"--colors 'column:none'",
			"--colors 'match:fg:225,255,229'",
			"-e",
		}, " "),
	},
	ui_select = {},
	keymap = {
		builtin = {
			["<C-d>"] = 'preview-page-down', -- Better scrolling within the displays
			["<C-u>"] = 'preview-page-up',
		},
	},
	winopts = {
		height  = 0.95, -- window height
		width   = 0.90, -- window width
		preview = {
			layout   = 'vertical',
			vertical = "down:30%",
		}
	},
	files = {
		formatter = 'path.filename_first',
	},
})

vim.keymap.set('n', '<leader><leader>', '<cmd>FzfLua files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Find live grep' })
vim.keymap.set('n', '<leader>fr', '<cmd>FzfLua resume<cr>', { desc = 'Resume last picker' })
vim.keymap.set('n', '<leader>,', '<cmd>FzfLua buffers<cr>', { desc = 'Buffers' })

vim.keymap.set('n', 'grr', fzf.lsp_references, { desc = 'References' })
vim.keymap.set('n', 'gri', fzf.lsp_implementations, { desc = 'Implementations' })
vim.keymap.set('n', 'gra', fzf.lsp_code_actions, { desc = 'Code actions' })
vim.keymap.set('n', 'gd', fzf.lsp_definitions, { desc = 'Go to definition' })

vim.keymap.set('n', '<leader>fc', '<cmd>FzfLua colorschemes<cr>', { desc = 'Pick colorscheme' })

require('orgmode').setup({
	org_agenda_files = '~/orgfiles/**/*',
	org_default_notes_file = '~/orgfiles/refile.org',
})

-- Treesitter
vim.cmd('syntax off') -- Make it obvious if treesitter is missing
vim.api.nvim_create_autocmd('FileType', {
	callback = function() pcall(vim.treesitter.start) end,
})

vim.lsp.config('rust_analyzer', {
	settings = {
		['rust-analyzer'] = {
			check = {
				command = 'clippy',
			},
		},
	},
})

-- LSP
vim.lsp.enable({
	'basedpyright', -- also $ uv tool install ty@latest
	'ruff', -- also $ uv tool install ruff@latest
	'lua_ls', -- also $ brew install lua-language-server
	'clangd', -- also $ brew install llvm
	'rust_analyzer',
	'org'

})
vim.o.signcolumn = 'yes' -- make lsp warnings not widen the gutter
-- Auto-format ("lint") on save (adapted from neovim docs :help auto-format)
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		if not client:supports_method('textDocument/willSaveWaitUntil')
		    and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('my.lsp.fmt', { clear = false }),
				buffer = ev.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})


-- Blink.cmp
require('blink.cmp').setup({
	signature = {
		enabled = true,
		window = { show_documentation = false },
	},
})

-- Neoscroll
require('neoscroll').setup({
	hide_cursor = false,
	stop_eof = true,
	easing = 'quadratic',
	duration_multiplier = 0.30,
})


-- Dap (debugging)
local dap = require('dap')
dap.adapters.debugpy = function(cb, config) -- also $ uv tool install debugpy@latest
	if config.request == 'attach' then
		cb({
			type = 'server',
			port = config.connect.port,
			host = config.connect.host or '127.0.0.1',
		})
	else
		cb({
			type = 'executable',
			command = 'debugpy-adapter',
		})
	end
end
dap.configurations.python = { -- https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
	{
		type = 'debugpy',
		request = 'launch',
		name = 'Launch file',
		program = '${file}',
		justMyCode = false,
		python = function()
			local root = vim.fs.root(0, '.venv')
			return { root and root .. '/.venv/bin/python' or 'python3' }
		end,
		cwd = function()
			return vim.fs.root(0, '.venv') or vim.fn.getcwd()
		end,
	},
	{
		type = 'debugpy',
		request = 'launch',
		name = 'Pytest current file',
		module = 'pytest',
		args = { '${file}', '-s' },
		justMyCode = false,
		python = function()
			local root = vim.fs.root(0, '.venv')
			return { root and root .. '/.venv/bin/python' or 'python3' }
		end,
		cwd = function()
			return vim.fs.root(0, '.venv') or vim.fn.getcwd()
		end,
	},
	{
		type = 'debugpy',
		request = 'launch',
		name = 'Pytest current file -k',
		module = 'pytest',
		args = function()
			local test_name = vim.fn.input('pytest -k: ')
			return { '${file}', '-s', '-k', test_name }
		end,
		justMyCode = false,
		python = function()
			local root = vim.fs.root(0, '.venv')
			return { root and root .. '/.venv/bin/python' or 'python3' }
		end,
		cwd = function()
			return vim.fs.root(0, '.venv') or vim.fn.getcwd()
		end,
	},
	{
		type = 'python',
		request = 'attach',
		name = 'Attach remote (ckan-dev)',
		connect = {
			host = 'localhost',
			port = 5678,
		},
		pathMappings = {
			{
				localRoot = vim.fn.getcwd(), -- your local src/ checkout
				remoteRoot = '/srv/app', -- matches the mount in ckan-docker
			},
		},
	},
}
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug toggle breakpoint' })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug continue' })
vim.keymap.set('n', '<leader>dq', dap.terminate, { desc = 'Debug terminate' })
vim.keymap.set('n', '<leader>dr', function()
	dap.repl.open({ height = 12 }, 'belowright split')
end, { desc = 'Debug open REPL' })
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'dap-repl',
	callback = function(ev)
		vim.keymap.set('i', '<C-p>', function() require('dap.repl').on_up() end,
			{ buffer = ev.buf, desc = 'DAP REPL previous history' })
		vim.keymap.set('i', '<C-n>', function() require('dap.repl').on_down() end,
			{ buffer = ev.buf, desc = 'DAP REPL next history' })
	end,
})
vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug run last' })
vim.keymap.set({ 'n', 'v' }, '<leader>dh', require('dap.ui.widgets').hover, { desc = 'Debug hover' })
vim.keymap.set('n', '<Down>', dap.step_over, { desc = 'Debug step over' })
vim.keymap.set('n', '<Right>', dap.step_into, { desc = 'Debug step into' })
vim.keymap.set('n', '<Left>', dap.step_out, { desc = 'Debug step out' })
vim.keymap.set('n', '<Up>', dap.restart_frame, { desc = 'Debug restart frame' })

require("catppuccin").setup({
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		notify = false,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
	}
})
vim.cmd.colorscheme "tokyonight-moon"
