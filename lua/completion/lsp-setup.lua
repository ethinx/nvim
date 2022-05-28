local M = {}


function M.config()
  local mappings = {
    gd = 'lua require"telescope.builtin".lsp_definitions()',
    gi = 'lua require"telescope.builtin".lsp_implementations()',
    gr = 'lua require"telescope.builtin".lsp_references()',
  }

  local settings = {
    -- mappings = mappings,
    on_attach = function(client, bufnr)
      require('nvim-lsp-setup.utils').format_on_save(client)
      require('illuminate').on_attach(client)
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
      sumneko_lua = require('lua-dev').setup({
        lspconfig = {
          on_attach = function(client, _)
            require('nvim-lsp-setup.utils').disable_formatting(client)
          end,
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
    }
  }

  require('nvim-lsp-setup').setup(settings)

  require('lsp_signature').setup({})

  local border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
end

return M
