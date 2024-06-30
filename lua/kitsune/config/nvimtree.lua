--2024.06.30 @ 01:48
--nvim-tree
return function()
	require('nvim-tree').setup {
		filters = {
			dotfiles = false,
		},
		disable_netrw = true,
		hijack_netrw = true,
		hijack_cursor = true,
		hijack_unnamed_buffer_when_opening = false,
		sync_root_with_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = false,
		},
		view = {
			adaptive_size = false,
			side = 'left',
			width = 30,
			preserve_window_proportions = true,
		},
		git = {
			enable = true,
			ignore = true,
		},
		filesystem_watchers = {
			enable = true,
		},
		actions = {
			open_file = {
				resize_window = true,
			},
		},
		renderer = {
			root_folder_label = false,
			highlight_git = true,
			highlight_opened_files = 'none',

			indent_markers = {
				enable = true,
			},

			icons = {
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
				},

				glyphs = {
					default = '󰈚',
					symlink = '',
					folder = {
						default = '',
						empty = '',
						empty_open = '',
						open = '',
						symlink = '',
						symlink_open = '',
						arrow_open = '',
						arrow_closed = '',
					},
					git = {
						unstaged = '✗',
						staged = '✓',
						unmerged = '',
						renamed = '➜',
						untracked = '★',
						deleted = '',
						ignored = '◌',
					},
				},
			},
		},
		on_attach = function(bufnr)
			local function opts(desc)
				return {
					desc = 'nvim-tree: ' .. desc,
					buffer = bufnr,
					noremap = true,
					silent = true,
					nowait = true,
				}
			end
			local ok, api = pcall(require, 'nvim-tree.api')
			assert(ok, 'api module is not found')
			vim.keymap.set('n', '<CR>', api.node.open.tab_drop, opts 'Tab drop')
		end,
	}

	Map('n', '<leader>ff', '<cmd>NvimTreeToggle<CR>', 'focus nvimtree')

	-- Make :bd and :q behave as usual when tree is visible
	Autocmd({ 'BufEnter', 'QuitPre' }, 'nvimtree-bdelete', function(e)
		local tree = require('nvim-tree.api').tree

		-- Nothing to do if tree is not opened
		if not tree.is_visible() then
			return
		end

		-- How many focusable windows do we have? (excluding e.g. incline status window)
		local winCount = 0
		for _, winId in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_config(winId).focusable then
				winCount = winCount + 1
			end
		end

		-- We want to quit and only one window besides tree is left
		if e.event == 'QuitPre' and winCount == 2 then
			vim.api.nvim_cmd({ cmd = 'qall' }, {})
		end

		-- :bd was probably issued an only tree window is left
		-- Behave as if tree was closed (see `:h :bd`)
		if e.event == 'BufEnter' and winCount == 1 then
			-- Required to avoid "Vim:E444: Cannot close last window"
			vim.defer_fn(function()
				-- close nvim-tree: will go to the last buffer used before closing
				tree.toggle { find_file = true, focus = true }
				-- re-open nivm-tree
				tree.toggle { find_file = true, focus = false }
			end, 10)
		end
	end)
end
