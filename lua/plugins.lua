local M = {}

_G.dump = function(...)
  print(vim.inspect(...))
end

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      })
      vim.cmd([[packadd packer.nvim]])
    end
    vim.cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")
    -- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerSync"
  end

  -- Plugins
  local function plugins(use)
    use({ "lewis6991/impatient.nvim" })
    use({ "wbthomason/packer.nvim" })

    -- ui
    use({
      -- "NLKNguyen/papercolor-theme",
      -- "catppuccin/nvim",

      -- "lourenci/github-colors",

      "joshdick/onedark.vim",
      config = function()
        vim.cmd("colorscheme onedark")
      end,
    })

    use({
      "kyazdani42/nvim-web-devicons",
      config = require('ui.nvim-web-devicons').config,
    })

    use({
      "goolord/alpha-nvim", -- startup screen
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
      config = require("ui.alpha").dashboard,
    })

    use({
      "SmiteshP/nvim-gps", -- TODO: use https://github.com/SmiteshP/nvim-navic
      requires = {
        "nvim-treesitter/nvim-treesitter",
        "windwp/nvim-autopairs",
      },
    })

    use({
      "nvim-lualine/lualine.nvim",
      config = require("ui.lualine").config,
      requires = {
        "kyazdani42/nvim-web-devicons",
        opt = true,
      },
    })

    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("ui.gitsigns")
      end,
    })

    use({
      "akinsho/bufferline.nvim",
      requires = {
        "moll/vim-bbye",
      },
      config = function()
        require("ui.bufferline")
      end,
    })

    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("ui.indent-blankline")
      end,
    })

    -- helper
    use({ "editorconfig/editorconfig-vim" }) -- editorconfig, for indent
    use({ "tpope/vim-repeat" })
    use({
      "folke/which-key.nvim",
      config = require("helper.whichkey").config,
    })

    use({
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("helper.nvim-tree")
      end,
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
    })

    use({
      "ahmedkhalf/project.nvim",
      requires = {
        "nvim-telescope/telescope.nvim",
      },
      config = function()
        require("helper.project")
      end,
    })

    -- editor
    use({
      "simrat39/symbols-outline.nvim",
      config = require('editor.symbols-outline').config,
    })

    -- 注释
    use({
      "tpope/vim-commentary",
      config = require("editor.vim-commentary").config,
    })

    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = require("editor.treesitter").config,
    })

    use({
      "RRethy/vim-illuminate",
      config = function()
        vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{reverse=true, wrap=true}<cr>'
          , { noremap = true })
        vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true, wrap=true}<cr>'
          , { noremap = true })
      end,
    }) -- select and move between words under cursor

    -- completion
    use({
      "hrsh7th/nvim-cmp",
      config = function()
        require("completion.cmp")
      end,
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
      },
      disable = false,
    })

    use({
      "hrsh7th/cmp-nvim-lsp",
    })

    use({
      "junnplus/nvim-lsp-setup",
      requires = {
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
    })

    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
      },
      config = function()
        require("helper.telescope")
      end,
    })

    -- Motions
    use({ "andymass/vim-matchup", event = "CursorMoved" }) -- 语法块 tag 跳转
    use({ "chaoren/vim-wordmotion" }) -- 单词移动
    use({ "wellle/targets.vim", event = "CursorMoved" }) -- text object selection
    use({
      "unblevable/quick-scope", -- inline moving
      disable = false,
      config = function()
        vim.g.qs_filetype_blacklist = { 'alpha' }
      end,
    })

    use({
      "phaazon/hop.nvim",
      cmd = { "HopWord", "HopChar1", "HopLine" },
      config = function()
        require("hop").setup({})
      end,
    })

    use({
      "windwp/nvim-autopairs",
      requires = {
        "nvim-cmp",
      },
      config = function()
        require("editor.autopairs")
      end,
    })

    -- use({
    -- 	"jose-elias-alvarez/null-ls.nvim",
    -- })

    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("helper.toggleterm")
      end,
    })

    -- https://xu3352.github.io/linux/2018/10/18/vim-table-format-in-html-or-markdown
    -- https://devhints.io/vim-easyalign
    use({
      "junegunn/vim-easy-align"
    })

    -- https://github.com/mg979/vim-visual-multi/wiki/Quick-start
    -- https://yaocc.cc/2021/05/17/VIM%E5%A4%9A%E5%85%89%E6%A0%87%E6%8F%92%E4%BB%B6%E2%80%94%E2%80%94%E6%95%88%E7%8E%87MAX/
    use({
      'mg979/vim-visual-multi'
    })

    use({
      'folke/trouble.nvim',
      config = require('helper.trouble').config,
    })

    use({
      'linty-org/readline.nvim',
      event = "InsertEnter",
      config = require('editor.readline').config
    })

    -- better substitution
    use({
      'tpope/vim-abolish',
      cmd = 'S',
    })

    if packer_bootstrap then
      print("Restart Neovim required after installation!")
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require("packer")
  packer.init(conf)
  packer.startup(plugins)
end

return M
