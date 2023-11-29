--- @type LazySpec
local M = {
  {
    "nvimtools/none-ls.nvim",
    enabled = false,
    -- dependencies = {
    --   "nvim-lua/plenary.nvim",
    -- },
    opts = function(_, opts)
      local none_ls = require("none-ls")
      -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      -- return {
      --   on_attach = function(client, bufnr)
      --     if client.supports_method("textDocument/formatting") then
      --       vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      --       vim.api.nvim_create_autocmd("BufWritePre", {
      --         group = augroup,
      --         buffer = bufnr,
      --         callback = function()
      --           -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
      --           -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
      --           vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
      --         end,
      --       })
      --     end
      --   end,
      -- sources = {
      --   -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
      --   -- Lua
      --   null_ls.builtins.formatting.stylua,
      --   null_ls.builtins.completion.luasnip,
      --   -- Rust
      --   null_ls.builtins.formatting.rustfmt,
      --
      --   -- Python
      --   -- null_ls.builtins.diagnostics.pylint.with({
      --   --   diagnostics_postprocess = function(diagnostic)
      --   --     diagnostic.code = diagnostic.message_id
      --   --   end,
      --   -- }),
      --   null_ls.builtins.formatting.black,
      --   null_ls.builtins.formatting.isort,
      --   -- null_ls.builtins.formatting.ruff,
      --   -- null_ls.builtins.diagnostics.mypy,
      --   null_ls.builtins.diagnostics.ruff.with({
      --     diagnostic_config = {
      --       signs = true,
      --       underline = true,
      --       virtual_text = false,
      --       severity_sort = true,
      --       update_in_insert = false,
      --     },
      --   }),
      --   -- ts
      --   null_ls.builtins.diagnostics.tsc,
      --   null_ls.builtins.diagnostics.eslint,
      --   null_ls.builtins.formatting.prettier,
      --   null_ls.builtins.diagnostics.stylelint,
      --   -- null_ls.builtins.formatting.rome
      --   -- git
      --   null_ls.builtins.diagnostics.gitlint,
      --   null_ls.builtins.code_actions.gitrebase,
      --   null_ls.builtins.code_actions.gitsigns,
      --
      --   -- others
      --   null_ls.builtins.diagnostics.ansiblelint,
      --   null_ls.builtins.diagnostics.buf,
      --   null_ls.builtins.diagnostics.dotenv_linter,
      --   null_ls.builtins.formatting.remark, -- md
      --   null_ls.builtins.diagnostics.markdownlint,
      --   null_ls.builtins.formatting.nginx_beautifier,
      --   null_ls.builtins.diagnostics.shellcheck,
      --   null_ls.builtins.formatting.stylelint,
      --   null_ls.builtins.completion.spell,
      --   null_ls.builtins.formatting.taplo,
      --   null_ls.builtins.diagnostics.yamllint,
      -- },
      vim.list_extend(opts.sources, {
        none_ls.builtins.code_actions.gitrebase,
      })
    end,
  },
}

return M
