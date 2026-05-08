--- @type LazySpec
local M = {
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "plugins.langs.tailwind" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.python" },
  {
    "linux-cultist/venv-selector.nvim",
    opts = { name = { "venv", ".venv" } }
  },
  { import = "lazyvim.plugins.extras.dap.core" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { eslint = {} },
      setup = {
        eslint = function()
          require("lazyvim.util").on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
}

return M
