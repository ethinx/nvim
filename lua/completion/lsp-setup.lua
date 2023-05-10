local M = {}

function M.config()
  local mappings = {
    gd = 'lua require"telescope.builtin".lsp_definitions()',
    gi = ":Telescope lsp_implementations theme=ivy<cr>",
    gr = ":Telescope lsp_references theme=ivy<cr>",
    -- gr = "lua vim.lsp.buf.references()"
  }

  require('neodev').setup({})

  -- local util = require 'lspconfig.util'
  -- local root_pattern = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", "CMakeLists.txt", "src");

  local settings = {
    mappings = mappings,
    on_attach = function(client, bufnr)
      if client.name == "tsserver" then
        require("lsp-setup.utils").disable_formatting(client)
      end

      if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
        vim.diagnostic.disable()
      end

      require("lsp-setup.utils").format_on_save(client)
      require("illuminate").on_attach(client)
      -- TODO: check the alt key on macOS
      -- vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
      -- vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})
    end,
    servers = {
      beancount = {
        init_options = {
          journal_file = "/Users/ethinx/repo/beancount/beans/main.bean",
          journalFile = "/Users/ethinx/repo/beancount/beans/main.bean"
        }
        -- on_attach = require('polarmutex.lsp.attach').default_custom_on_attach
      },
      ansiblels = {},
      bashls = {},
      cmake = {},
      cssls = {},
      -- clangd = require("lsp-setup.clangd_extensions").setup({
      --   -- root_dir = require('lspconfig.util').root_pattern("compile_commands.json", "compile_flags.txt", ".git", "CMakeLists.txt", "src")
      --   -- root_dir =    function(fname)
      --   --   local filename = util.path.is_absolute(fname) and fname or util.path.join(vim.loop.cwd(), fname)
      --   --   vim.notify(filename, vim.log.levels.INFO)
      --   --   return root_pattern(filename)
      --   -- end,
      -- }),
      dockerls = {},
      dotls = {},
      -- groovyls = {},
      gopls = {},
      html = {},
      jsonls = {},
      jsonnet_ls = {},
      tsserver = {}, -- javascript
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = {
                "globals",
                "vim",
                "packer_plugins",
              }
            },
            telemetry = { enable = false },
            workspace = {
              checkThirdParty = false,
              preloadFileSize = 5000,
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      },
      taplo = {}, -- toml
      tailwindcss = {},
      terraformls = {},
      pyright = {},
      rust_analyzer = {},
      rnix = {},
      vimls = {},
      vuels = {},
      yamlls = {},
    },
  }
  local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

  -- disable virtual_text and use whynothugo/lsp_lines.nvim instread
  vim.diagnostic.config({
    update_in_insert = false,
    virtual_text = false,
  })

  require("lsp-setup").setup(settings)

  require("lsp_signature").setup({})

  require('lsp_lines').setup()


  -- require("completion.null-ls")

  -- local saga = require("lspsaga")
  -- saga.init_lsp_saga({})
end

return M
