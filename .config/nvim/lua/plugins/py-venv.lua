return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    local venv_selector = require("venv-selector")

    venv_selector.setup({
      name = { ".env", ".venv", "venv" },
      fd_binary_name = "fd",
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Auto select virtualenv Nvim open",
      pattern = "*",
      callback = function()
        local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
        if venv ~= "" then
          venv_selector.retrieve_from_cache()
          vim.cmd("LspRestart")
        end
      end,
      once = true,
    })
  end,
  ft = { "python" },
  keys = {
    { "<leader>vs", "<CMD>VenvSelect<CR>" },
    { "<leader>vc", "<CMD>:VenvSelectCached<CR>" },
  },
}
