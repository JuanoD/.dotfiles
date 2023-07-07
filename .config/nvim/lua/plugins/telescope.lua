--- @type LazySpec
local M = {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("fzf")
    end,
  },
  -- {
  --   "Equilibris/nx.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   opts = function(_, opts)
  --     return {
  --       nx_cmd_root = "pnpm nx",
  --       command_runner = require("nx.command-runners").terminal_cmd(),
  --       form_renderer = require("nx.form-renderers").telescope(),
  --       read_init = true,
  --     }
  --   end,
  --   config = function(_, opts)
  --     require("nx").setup(opts)
  --   end,
  -- },
  -- {
  --   "tpope/vim-fugitive",
  -- },
}

return M
