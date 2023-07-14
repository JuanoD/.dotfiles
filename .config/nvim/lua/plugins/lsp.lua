local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local map = vim.keymap.set

  -- Buffer
  map("n", "<M-.>", vim.lsp.buf.definition, bufopts)
  map("n", "<leader>gr", vim.lsp.buf.rename, bufopts)
  map("n", "<leader>gR", vim.lsp.buf.references, bufopts)
  map("n", "K", vim.lsp.buf.hover, bufopts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)

  -- Diagnostic
  map("n", "<leader>dr", vim.diagnostic.reset, bufopts)
  map("n", "<leader>de", vim.diagnostic.enable, bufopts)
  map("n", "<leader>dd", vim.diagnostic.disable, bufopts)
  map("n", "<leader>dp", vim.diagnostic.goto_prev, bufopts)
  map("n", "<leader>dn", vim.diagnostic.goto_next, bufopts)
  map("n", "<leader>df", vim.diagnostic.open_float, bufopts)

  map("n", "<leader>cf", function()
    vim.lsp.buf.format({
      -- async = true,
      timeout_ms = 3000,
    })
  end, bufopts)

  vim.diagnostic.config({
    signs = true,
    underline = true,
    virtual_text = true,
    severity_sort = false,
    update_in_insert = false,
  })
end

--- @type LazySpec
local M = {
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --   },
  --   opts = {
  --     automatic_installation = true,
  --     ensure_installed = {
  --       -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
  --       "rust_analyzer",
  --       "taplo", -- TOML
  --       -- Back
  --       "jedi_language_server",
  --       "ruff_lsp",
  --       "sqlls",
  --       -- Front
  --       "tsserver",
  --       "tailwindcss",
  --       -- "remark_ls",
  --       "marksman",
  --       "jsonls",
  --       "html",
  --       "emmet_ls",
  --       "eslint",
  --       "cssls",
  --       "grammarly",
  --       -- Environment
  --       "docker_compose_language_service",
  --       "dockerls",
  --       "bashls",
  --       --
  --       "lua_ls",
  --     },
  --     handlers = {
  --       function(server_name)
  --         require("lspconfig")[server_name].setup({
  --           on_attach = on_attach,
  --           capabilities = require("cmp_nvim_lsp").default_capabilities(),
  --         })
  --       end,
  --     },
  --   },
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     "williamboman/mason-lspconfig.nvim",
  --     "hrsh7th/nvim-cmp",
  --     "hrsh7th/cmp-nvim-lsp",
  --     -- "jose-elias-alvarez/null-ls.nvim",
  --   },
  --   -- config = function()
  --   --   require("plugins.configs.lsp")
  --   -- end,
  -- },
}

return M
