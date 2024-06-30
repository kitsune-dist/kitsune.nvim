--2024.06.29 @ 23:25
local use_24bpc = true
local leader = ';'
local indent = 4

vim.g.have_nerd_font = true

--# cmd
Cmd 'filetype plugin indent on'
pcall(function()
	Cmd 'aunmenu PopUp.How-to\\ disable\\ mouse'
	Cmd 'aunmenu PopUp.-1-'
end)

--# opt
if os.getenv 'TERM_PROGRAM' ~= 'Apple_Terminal' then
	Set('termguicolors', use_24bpc)
end

Set('showcmd', true)
Set('signcolumn', 'yes')
Set('splitbelow', true)

Set('encoding', 'utf-8')
--Set ('syntax', 'enable')
Set('matchpairs', { "':'", '":"', '(:)', '{:}', '[:]', '<:>' })

Set('ttyfast', true)
Set('updatetime', 300)
Set('ttimeout', true)
Set('ttimeoutlen', 50)

Set('incsearch', true)
Set('hlsearch', true)

Set('mouse', 'a')
Set('number', true)
Set('rnu', true)

Set('tabstop', indent)
Set('softtabstop', indent)
Set('shiftwidth', indent)
Set('breakindent', true)
Set('expandtab', false)
Set('backspace', { 'indent', 'eol', 'start' })
Set('cursorline', true)
Set('smartcase', true)

--# keymap
vim.g.mapleader = leader
vim.g.maplocalleader = leader
Map({ 'n', 'v' }, leader, '<nop>')

--## nav
Map('n', '<C-k>', '<C-w><C-k>', 'nav north')
Map('n', '<C-j>', '<C-w><C-j>', 'nav south')
Map('n', '<C-l>', '<C-w><C-l>', 'nav east')
Map('n', '<C-h>', '<C-w><C-h>', 'nav west')

--## buffers
Map('n', '<S-l>', ':bnext<CR>', 'next buf')
Map('n', '<S-h>', ':bprevious<CR>', 'prev buf')

--## tabs
Map('n', '<C-S-l>', ':tabnext<CR>', 'next tab')
Map('n', '<C-S-h>', ':tabprevious<CR>', 'prev tab')

--## resize
Map('n', '<A-k>', ':resize u2<CR>', 'resize north')
Map('n', '<A-j>', ':resize +2<CR>', 'resize south')
Map('n', '<A-h>', ':vertical resize -2<CR>', 'resize east')
Map('n', '<A-l>', ':vertical resize +2<CR>', 'resize west')

--## file
Map('n', '<leader>fw', ':w<CR>', 'w')
Map('n', '<leader>fa', ':wa<CR>', 'wa')
Map('n', '<leader>qq', ':q<CR>', 'q')
Map('n', '<leader>qa', ':qa!<CR>', 'qa')
Map('n', '<leader>dw', ':close<CR>', 'close')

--## misc
Map('n', '<leader>h', ':nohl<CR>', 'reset hl')

--# autocmd
Autocmd('TextYankPost', 'clhl', vim.highlight.on_yank, 'Blink when copying text')
