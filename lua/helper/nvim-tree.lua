-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

-- Replaces auto_close
local tree_cb = nvim_tree_config.nvim_tree_callback
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd("quit")
    end
  end,
})

local function open_nvim_tree(data)
  local IGNORED_FT = {
    "startify",
    "dashboard",
    "alpha",
  }

  -- buffer is a real file on the disk
  local real_file = vim.fn.filereadable(data.file) == 1

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- &ft
  local filetype = vim.bo[data.buf].ft
  -- only files please
  if not real_file or not no_name then
    return
  end

  -- skip ignored filetypes
  if vim.tbl_contains(IGNORED_FT, filetype) then
    return
  end

  -- open the tree but don't focus it
  require("nvim-tree.api").tree.toggle({ focus = false })
end

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set('n', "o", api.node.open.edit, opts("Go to file"))
  vim.keymap.set('n', "<CR>", api.node.open.edit, opts("Go to file"))
  vim.keymap.set('n', "<C-v>", api.node.open.vertical, opts('Open: vsplit'))
  vim.keymap.set('n', "<C-s>", api.node.open.horizontal, opts('Open: split'))
  vim.keymap.set('n', "v", api.node.open.vertical, opts('Open: vsplit'))
  vim.keymap.set('n', "s", api.node.open.horizontal, opts('Open: split'))
end

nvim_tree.setup({
  on_attach = on_attach,
  disable_netrw = true,
  hijack_netrw = true,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  renderer = {
    icons = {
      glyphs = nvim_tree_icons,
    },
    root_folder_label = false,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  filters = {
    dotfiles = false,
    custom = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    -- height = 30,
    -- hide_root_folder = true,
    -- root_folder_label = true,
    side = "left",
    -- mappings = {
    --   custom_only = false,
    --   list = {
    --     { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
    --     { key = "h", cb = tree_cb("close_node") },
    --     { key = '<C-v>', cb = tree_cb('vsplit') },
    --     { key = '<C-s>', cb = tree_cb('split') },
    --     { key = 'v', cb = tree_cb('vsplit') },
    --     { key = 's', cb = tree_cb('split') },
    --     { key = '-', cb = '<Plug>(choosewin)' },
    --     { key = '<C-t>', cb = ':ToggleTerm<cr>' },
    --   },
    -- },
    number = false,
    relativenumber = false,
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = false,
      },
    },
  },

  --  unknown options as of 22.05
  --
  --  update_to_buf_dir = {
  --    enable = true,
  --    auto_open = true,
  --  },
  --  auto_resize = true,
  --  git_hl = 1,
  --  root_folder_modifier = ":t",
})

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
