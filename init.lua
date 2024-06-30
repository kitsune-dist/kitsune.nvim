--2024.06.29 @ 23:15
--# util
Cmd = vim.cmd
function Set(key, value) vim.opt[key] = value end
function Map(mode, map, func, desc) vim.keymap.set(mode, map, func, { silent = true, desc = desc }) end
function Autocmd(events, group, callback, desc)
	vim.api.nvim_create_autocmd(events, {
		group = vim.api.nvim_create_augroup(group, { clear = true }),
		callback = callback,
		desc = desc or '',
	})
end

--# init
require 'nvim'
require 'kitsune.plugin'
