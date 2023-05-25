local M = {}

function M.config()
  -- require("nvim-treesitter")
  vim.g.foldmethod = "expr"
  vim.g.foldexpr = "nvim_treesitter#foldexpr()"

  local opts = {
    ensure_installed = {
      "bash",
      "fish",
      "beancount",
      "c",
      "cpp",
      "make",
      "dockerfile",
      "dot",
      "go",
      "gomod",
      "gowork",
      "hcl",
      "html",
      "css",
      "json",
      "yaml",
      "toml",
      "javascript",
      "typescript",
      "tsx",
      "vue",
      "python",
      "perl",
      "lua",
      "ruby",
      "rego",
      "regex",
      "vim",
      "nix",
    },
    sync_install = false,
    auto_install = false,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    indent = { enable = true },

    autopairs = { enable = true },
  }

  require("nvim-treesitter.configs").setup(opts)
end

return M
