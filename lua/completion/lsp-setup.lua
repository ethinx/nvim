local M = {}

function M.config()
	local mappings = {
		gd = 'lua require"telescope.builtin".lsp_definitions()',
		-- gi = 'lua require"telescope.builtin".lsp_implementations()',
		-- gr = 'lua require"telescope.builtin".lsp_references()',
		gi = "Telescope lsp_implementations theme=ivy",
		gr = "Telescope lsp_references theme=ivy",
	}

	local settings = {
		mappings = mappings,
		on_attach = function(client, bufnr)
			if client.name == "tsserver" then
				require("nvim-lsp-setup.utils").disable_formatting(client)
			end
			require("nvim-lsp-setup.utils").format_on_save(client)
			require("illuminate").on_attach(client)
			-- TODO: check the alt key on macOS
			-- vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
			-- vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})
		end,
		servers = {
			ansiblels = {},
			bashls = {},
			cmake = {},
			cssls = {},
			dockerls = {},
			dotls = {},
			-- groovyls = {},
			gopls = {},
			html = {},
			jsonls = {},
			jsonnet_ls = {},
			tsserver = {}, -- javascript
			sumneko_lua = require("lua-dev").setup({
				lspconfig = {
					diagnostics = { globals = { "vim", "packer_plugins" } },
					on_attach = function(client, _)
						require("nvim-lsp-setup.utils").disable_formatting(client)
					end,
					telemetry = { enable = false },
				},
			}),
			taplo = {}, -- toml
			tailwindcss = {},
			terraformls = {},
			pyright = {},
			rust_analyzer = {},
			vimls = {},
			vuels = {},
			yamlls = {},
		},
	}

	require("nvim-lsp-setup").setup(settings)

	require("lsp_signature").setup({})

	local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

	require("completion.null-ls")

	-- local saga = require("lspsaga")
	-- saga.init_lsp_saga({})
end

return M
