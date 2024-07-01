--2024.06.30 @ 00:49
--cmp
return function()
	-- SEE: `:help cmp`
	local cmp = require 'cmp'
	local luasnip = require 'luasnip'
	luasnip.config.setup {}

	cmp.setup {
		snippet = {
			expand = function(args) luasnip.lsp_expand(args.body) end,
		},
		completion = { completeopt = 'menu,menuone,noinsert' },

		-- WARN: read `:help ins-completion`
		mapping = cmp.mapping.preset.insert {
			['<C-n>'] = cmp.mapping.select_next_item(),
			['<C-p>'] = cmp.mapping.select_prev_item(),

			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete {},

			['<CR>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					if luasnip.expandable() then
						luasnip.expand()
					else
						cmp.confirm {
							select = true,
						}
					end
				else
					fallback()
				end
			end),

			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.locally_jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, { 'i', 's' }),

			['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i', 's' }),
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			{ name = 'path' },
		},
	}
end
