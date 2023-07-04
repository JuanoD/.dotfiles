--- @type LazySpec
local M = {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      -- "jay-babu/mason-null-ls.nvim",
    },
    -- opts = function()
    --   local null_ls = require("null-ls")
    --   return {
    --     sources = {
    --       -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    --       -- Lua
    --       null_ls.builtins.formatting.stylua,
    --       -- Rust
    --       null_ls.builtins.formatting.rustfmt,
    --
    --       -- Python
    --       null_ls.builtins.formatting.black,
    --       null_ls.builtins.formatting.isort,
    --       null_ls.builtins.formatting.ruff,
    --
    --       null_ls.builtins.diagnostics.ruff.with({
    --         diagnostic_config = {
    --           signs = true,
    --           underline = true,
    --           virtual_text = false,
    --           severity_sort = true,
    --           update_in_insert = false,
    --         },
    --       }),
    --       -- TS
    --       null_ls.builtins.diagnostics.eslint,
    --       null_ls.builtins.formatting.prettier,
    --       -- null_ls.builtins.formatting.rome
    --       -- git
    --       null_ls.builtins.diagnostics.gitlint,
    --       -- Others
    --       null_ls.builtins.formatting.remark, -- MD
    --       null_ls.builtins.formatting.nginx_beautifier,
    --       null_ls.builtins.completion.spell,
    --     },
    --   }
    -- end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      -- "davidmh/cspell.nvim",
    },
    opts = {
      automatic_installation = true,
      ensure_installed = {
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
        "stylua",
        -- "cspell",
        "eslint",
        -- "gitsigns",
        "luasnip",
        "ansiblelint",
        "buf",
        "commitlint",
        -- "dotenv_linter",
        "flake8",
        "jsonlint",
        "markdownlint",
        "mypy",
        "pylint",
        "ruff",
        "shellcheck",
        "stylelint",
        "tidy",
        "tsc",
        "vacuum",
        "yamllint",
        "autoflake",
        -- "autopep8",
        "black",
        "isort",
        "nginx_beautifier",
        "protolint",
        -- "remark",
        "rustfmt",
        "shfmt",
        "taplo",
      },
      handlers = {
        function(source_name, methods)
          -- null_ls.register(null_ls.builtins.***)
          require("mason-null-ls").default_setup(source_name, methods)
        end,
      },
    },
  },
}

return M
