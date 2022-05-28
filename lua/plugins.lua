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
		use({ "wbthomason/packer.nvim" })

		-- ui
		use({
			-- "NLKNguyen/papercolor-theme",
			"catppuccin/nvim",
			config = function()
				vim.cmd("colorscheme catppuccin")
			end,
		})

		use({
			"goolord/alpha-nvim", -- startup screen
			requires = {
				"kyazdani42/nvim-web-devicons",
			},
			config = require("ui.alpha").dashboard,
		})

		use({
			"SmiteshP/nvim-gps",
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

		-- helper
		use({ "editorconfig/editorconfig-vim" }) -- editorconfig, for indent
		use({ "tpope/vim-repeat" })
		use({
			"folke/which-key.nvim",
			config = require("helper.whichkey").config,
		})

		-- editor
		use({ "tpope/vim-commentary" })
		-- use { 'tpope/vim-surround' }
		use({
			"nvim-treesitter/nvim-treesitter",
			-- opt = true,
			-- event = {
			--   'BufRead',
			-- },
			run = ":TSUpdate",
			config = require("editor.treesitter").config,
		})

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
				"williamboman/nvim-lsp-installer",
				"folke/lua-dev.nvim",
				"neovim/nvim-lspconfig",
				"ray-x/lsp_signature.nvim",
				"RRethy/vim-illuminate",
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
		use({ "andymass/vim-matchup", event = "CursorMoved" })
		use({ "chaoren/vim-wordmotion" })
		use({ "wellle/targets.vim", event = "CursorMoved" })
		use({ "unblevable/quick-scope", disable = false })

		use({
			"phaazon/hop.nvim",
			cmd = { "HopWord", "HopChar1" },
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

		use({
			"jose-elias-alvarez/null-ls.nvim",
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
