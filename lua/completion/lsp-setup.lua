local M = {}

function M.config()
  local settings = {
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
end

return M
