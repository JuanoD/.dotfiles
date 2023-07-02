return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    opts = {
      ensure_installed = {
        -- "stylua",
        -- "shellcheck",
        -- "shfmt",
        -- "flake8",
        -- "ansible-language-server",
        -- "black",
        -- "docker-compose-language-service",
        -- "dockerfile-language-server",
        -- "emmet-ls",
        -- "eslint-lsp",
        -- "firefox-debug-adapter",
        -- "grammarly-languageserver",
        -- "isort",
        -- "lua-language-server",
        -- "nginx-language-server",
        -- "prettier",
        -- "rust-analyzer",
        -- "tailwindcss-language-server",
      },
    },
  },
}
