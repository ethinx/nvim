return {
  {
    "towolf/vim-helm",
    lazy = true,
  },
  {
    "joshdick/onedark.vim",
    config = function()
      vim.cmd("colorscheme onedark")
    end,
  },
  {
    "goolord/alpha-nvim", -- startup screen
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    config = require('ui.alpha').dashboard
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      -- "nvim-treesitter/nvim-treesitter",
      "windwp/nvim-autopairs",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    config = require("ui.lualine").config,
    dependencies = {
      {
        "kyazdani42/nvim-web-devicons",
        lazy = true,
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("ui.gitsigns")
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "moll/vim-bbye",
    },
    config = function()
      require("ui.bufferline")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ui.indent-blankline")
    end,
  },

  { "editorconfig/editorconfig-vim" },
  { "tpope/vim-repeat" },
  {
    "folke/which-key.nvim",
    config = require("helper.whichkey").config,
  },
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("helper.nvim-tree")
    end,
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
  },
  {
    "ahmedkhalf/project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("helper.project")
    end,
  },

  -- editor
  {
    "simrat39/symbols-outline.nvim",
    config = require('editor.symbols-outline').config,
  },

  -- comment
  {
    "tpope/vim-commentary",
    config = require("editor.vim-commentary").config,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = require("editor.treesitter").config,
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{reverse=true, wrap=true}<cr>'
        , { noremap = true })
      vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true, wrap=true}<cr>'
        , { noremap = true })
    end,
  }, -- select and move between words under cursor

  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("completion.cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },

  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "junnplus/nvim-lsp-setup",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/nvim-lsp-installer",
      "folke/neodev.nvim",
      "neovim/nvim-lspconfig",
      "ray-x/lsp_signature.nvim",
      "RRethy/vim-illuminate",
      "p00f/clangd_extensions.nvim",
      -- "glepnir/lspsaga.nvim",
      'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    },
    config = require("completion.lsp-setup").config,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    branch = "anticonceal",
    config = function()
      require('helper/lsp-inlayhints')
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
    },
    config = function()
      require("helper.telescope")
    end,
  },

  -- Motions
  -- use({ "andymass/vim-matchup", event = "CursorMoved" }) -- 语法块 tag 跳转
  { "chaoren/vim-wordmotion" }, -- 单词移动
  { "wellle/targets.vim", event = "CursorMoved" }, -- text object selection
  {
    "unblevable/quick-scope", -- inline moving
    config = function()
      vim.g.qs_filetype_blacklist = { 'alpha' }
    end,
  },

  {
    "phaazon/hop.nvim",
    cmd = { "HopWord", "HopChar1", "HopLine" },
    config = function()
      require("hop").setup({})
    end,
  },

  {
    "windwp/nvim-autopairs",
    dependencies = {
      "nvim-cmp",
    },
    config = function()
      require("editor.autopairs")
    end,
  },

  -- use({
  -- 	"jose-elia-alvarez/null-ls.nvim",
  -- })

  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("helper.toggleterm")
    end,
  },

  -- https://xu3352.github.io/linux/2018/10/18/vim-table-format-in-html-or-markdown
  -- https://devhints.io/vim-easyalign
  {
    "junegunn/vim-easy-align"
  },

  -- https://github.com/mg979/vim-visual-multi/wiki/Quick-start
  -- https://yaocc.cc/2021/05/17/VIM%E5%A4%9A%E5%85%89%E6%A0%87%E6%8F%92%E4%BB%B6%E2%80%94%E2%80%94%E6%95%88%E7%8E%87MAX/
  {
    'mg979/vim-visual-multi'
  },

  {
    'folke/trouble.nvim',
    config = require('helper.trouble').config,
  },

  {
    'linty-org/readline.nvim',
    event = "InsertEnter",
    config = require('editor.readline').config
  },

  -- better substitution
  {
    'tpope/vim-abolish',
    cmd = 'S',
  },
}
