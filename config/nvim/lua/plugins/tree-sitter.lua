--- @type LazySpec
local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "css",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "json5",
        "jsonc",
        "proto",
        "prql",
        "rust",
        "sql",
      })
    end,
  },
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   requires = { "kevinhwang91/promise-async" },
  --   opts = {
  --     provider_selector = function(bufnr, filetype, buftype)
  --       return { "treesitter", "indent" }
  --     end,
  --   },
  --   keys = function(_, _)
  --     local ufo = require("ufo")
  --     return {
  --       { "zR", ufo.openAllFolds, mode = "n" },
  --       { "zM", ufo.closeAllFolds, mode = "n" },
  --     }
  --   end,
  -- },
  -- { "kevinhwang91/promise-async", name = "promise" },
  {
    "anuvyklack/pretty-fold.nvim",
  },
}

return M
