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
    vim.lsp.buf.format({ async = true, timeout_ms = 3000 })
  end, bufopts)

  vim.diagnostic.config({
    signs = true,
    underline = true,
    virtual_text = false,
    severity_sort = false,
    update_in_insert = false,
  })
end

return {
  {
    "williamboman/mason.nvim",
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
      opts = {
        automatic_installation = true,
        ensure_installed = {
          --
          "rust_analyzer",
          "taplo", -- TOML
          -- Back
          "jedi_language_server",
          "sqlls",
          -- Front
          "tsserver",
          "tailwindcss",
          "remark_ls",
          "jsonls",
          "html",
          "emmet_ls",
          "eslint",
          "cssls",
          -- "grammarly",
          -- Environment
          "docker_compose_language_service",
          "dockerls",
          "bashls",

          --
          "lua_ls",
        }
      },
      config = function(_, opts)
        -- require("mason").setup(opts)
        require("mason-lspconfig").setup(opts)

        require("mason-lspconfig").setup_handlers({
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = require("cmp_nvim_lsp").default_capabilities()
            })
          end
        })
      end
    },
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require('plugins.configs.lsp')
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
          -- Lua
          null_ls.builtins.formatting.stylua,
          -- Rust
          null_ls.builtins.formatting.rustfmt,

          -- Python
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.ruff,

          null_ls.builtins.diagnostics.ruff.with({
            diagnostic_config = {
              signs = true,
              underline = true,
              virtual_text = false,
              severity_sort = true,
              update_in_insert = false,
            },
          }),
          -- TS
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.formatting.prettier,
          -- null_ls.builtins.formatting.rome
          -- git
          null_ls.builtins.diagnostics.gitlint,
          -- Others
          null_ls.builtins.formatting.remark, -- MD
          null_ls.builtins.formatting.nginx_beautifier,
          null_ls.builtins.completion.spell
        },
      }
    end,
  }
}
