--2024.06.30 @ 00:07
--# lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

--# load
require('lazy').setup({
	'tpope/vim-sleuth',
	'numToStr/Comment.nvim',
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
	},

	{ -- Shows you keybind possibilities.
		'folke/which-key.nvim',
		event = 'VimEnter',
		config = require 'kitsune.config.whichkey',
	},

	{ -- Fuzzy Finder (files, lsp, etc)
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzy-native.nvim',
				config = function() require('telescope').load_extension 'fzy_native' end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },
			{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
		},
		config = require 'kitsune.config.telescope',
	},

	{ -- File tree & picker
		'nvim-tree/nvim-tree.lua',
		config = require 'kitsune.config.nvimtree',
	},

	{ -- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- NOTE: Must be loaded before dependants
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',
			{ 'j-hui/fidget.nvim', opts = {} },
			{ 'folke/neodev.nvim', opts = {} },
		},
		config = require 'kitsune.config.lsp',
	},

	{ -- Autoformat
		'stevearc/conform.nvim',
		lazy = false,
		keys = {
			{
				'<leader>f',
				function() require('conform').format { async = true, lsp_fallback = true } end,
				mode = '',
				desc = '[F]ormat buffer',
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { 'stylua' },
			},
		},
	},

	{ -- Autocompletion
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				'L3MON4D3/LuaSnip',
				build = (function()
					if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
						return
					end
					return 'make install_jsregexp'
				end)(),
				dependencies = {
					{
						'rafamadriz/friendly-snippets',
						config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
					},
				},
			},
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
		},
		config = require 'kitsune.config.cmp',
	},

	{ -- Highlight todo, notes, etc in comments
		'folke/todo-comments.nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {
			keywords = {
				SEE = { icon = '󰈈 ', color = 'info' },
			},
		},
	},

	{ -- Collection of various small independent plugins/modules
		'echasnovski/mini.nvim',
		config = function()
			require('mini.ai').setup { n_lines = 500 }
			require('mini.surround').setup()
			local statusline = require 'mini.statusline'
			statusline.setup { use_icons = vim.g.have_nerd_font }
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function() return '%2l:%-2v' end
		end,
	},
	{ -- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		opts = {
			ensure_installed = {
				'bash',
				'c',
				'diff',
				'html',
				'lua',
				'luadoc',
				'markdown',
				'vim',
				'vimdoc',
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { 'ruby' },
			},
			indent = { enable = true, disable = { 'ruby' } },
		},
		config = function(_, opts)
			require('nvim-treesitter.install').prefer_git = true
			require('nvim-treesitter.configs').setup(opts)
		end,
	},
	{ -- See problems and diagnostics
		'folke/trouble.nvim',
		cmd = 'Trouble',
		opts = {},
		keys = {
			{
				'<leader>xx',
				'<cmd>Trouble diagnostics toggle<cr>',
				desc = 'Diagnostics (Trouble)',
			},
			{
				'<leader>xX',
				'<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
				desc = 'Buffer Diagnostics (Trouble)',
			},
			{
				'<leader>cs',
				'<cmd>Trouble symbols toggle focus=false<cr>',
				desc = 'Symbols (Trouble)',
			},
			{
				'<leader>cl',
				'<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
				desc = 'LSP Definitions / references / ... (Trouble)',
			},
			{
				'<leader>xL',
				'<cmd>Trouble loclist toggle<cr>',
				desc = 'Location List (Trouble)',
			},
			{
				'<leader>xQ',
				'<cmd>Trouble qflist toggle<cr>',
				desc = 'Quickfix List (Trouble)',
			},
		},
	},
	-- { -- Debug adapter
	-- 	'mfussenegger/nvim-dap',
	-- 	dependencies = {
	-- 		'leoluz/nvim-dap-go',
	-- 	},
	-- 	config = require('dap-go').setup,
	-- },

	-- Colorschemes
	{ -- Primary
		'sainnhe/gruvbox-material',
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			vim.g.gruvbox_material_background = 'medium'
			vim.g.gruvbox_material_diagnostic_text_highlight = 1
			vim.g.gruvbox_material_current_word = 'underline'
			vim.g.gruvbox_material_enable_italic = 1
			vim.g.gruvbox_material_enable_bold = 1

			Set('background', 'dark')
			Cmd 'colorscheme gruvbox-material'
		end,
	},
	'HUAHUAI23/nvim-quietlight',
	'folke/tokyonight.nvim',
	'morhetz/gruvbox',
	'nordtheme/nord',
	'rebelot/kanagawa.nvim',
	'sainnhe/edge',
	'sainnhe/everforest',
	'sainnhe/sonokai',
	'savq/melange-nvim',
	'yorik1984/newpaper.nvim',
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
