local M = {}

function M.config()
	local whichkey = require("which-key")
	vim.o.timeoutlen = 500

	local conf = {
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
		},
	}

	local opts = {
		mode = "n", -- Normal mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = false, -- use `nowait` when creating keymaps
	}

	local mappings = {
		["w"] = { "<cmd>update!<CR>", "Save" },
		["x"] = { "<cmd>x<CR>", "Save & Quit" },
		["q"] = { "<cmd>q!<CR>", "Quit" },

		b = {
			name = "Buffer",
			c = { "<Cmd>bd!<Cr>", "Close current buffer" },
			D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
			p = { "<Cmd>BufferLinePick<Cr>", "Pick Buffer" },
		},

		z = {
			name = "Packer",
			c = { "<cmd>PackerCompile<cr>", "Compile" },
			C = { "<cmd>PackerClean<cr>", "Clean" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			s = { "<cmd>PackerSync<cr>", "Sync" },
			S = { "<cmd>PackerStatus<cr>", "Status" },
			u = { "<cmd>PackerUpdate<cr>", "Update" },
		},

		-- g = {
		--   name = "Git",
		--   s = { "<cmd>Neogit<CR>", "Status" },
		-- },

		-- -- fzf-lua
		-- f = {
		--   name = "Fzf-lua Find",
		--   -- f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
		--   f = { "<cmd>FzfLua files<cr>", "Files" },
		--   b = { "<cmd>FzfLua buffers<cr>", "Buffers" },
		--   o = { "<cmd>FzfLua oldfiles<cr>", "Old files" },
		--   g = { "<cmd>FzfLua live_grep<cr>", "Live grep" },
		--   c = { "<cmd>FzfLua commands<cr>", "Commands" },
		--   e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
		-- },

		-- hop.nvim
		h = {
			name = "hop motion",
			c = { "<cmd>HopChar1<cr>", "1-char mode" },
			l = { "<cmd>HopLine<cr>", "line mode" },
			w = { "<cmd>HopWord<cr>", "word mode" },
		},

		-- telescope
		f = {
			name = "Telescope Find",
			f = { "<cmd>Telescope find_files<cr>", "Files" },
			-- d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", "Dotfiles" },
			b = { "<cmd>Telescope buffers<cr>", "Buffers" },
			o = { "<cmd>Telescope oldfiles<cr>", "Old Files" },
			g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
			c = { "<cmd>Telescope commands<cr>", "Commands" },
			r = { "<cmd>Telescope file_browser<cr>", "Browser" },
			w = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Current Buffer" },
			e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
			p = { "<cmd>Telescope projects<cr>", "Projects" },
		},

		-- p = {
		--   name = "Project",
		--   p = { "<cmd>lua require'telescope'.extensions.project.project{}<cr>", "List" },
		--   s = { "<cmd>Telescope repo list<cr>", "Search" },
		-- },
	}

	whichkey.setup(conf)
	whichkey.register(mappings, opts)
end

return M
