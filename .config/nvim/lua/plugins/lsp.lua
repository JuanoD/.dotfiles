
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      {
        "jose-elias-alvarez/null-ls.nvim",
        opts = function ()
          return require('plugins.configs.null-ls')
        end,
      }
    },
    config = function ()
      require('plugins.configs.lsp')
    end
  },
}
