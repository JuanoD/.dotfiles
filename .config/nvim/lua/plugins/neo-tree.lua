--- @type LazySpec
local M = {
  {
    "miversen33/netman.nvim",
    branch = "async-1",
    -- dependencies = { "nvim-neo-tree/neo-tree.nvim" },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
        "netman.ui.neo-tree",
      },
      source_selector = {
        winbar = true,
        statusline = false,
        sources = {
          { source = "filesystem", display_name = " 󰉓 Files " },
          { source = "git_status", display_name = " 󰊢 Git " },
          { source = "remote" },
        },
      },
    },
  },
}

return M
