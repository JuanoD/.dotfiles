-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local M = {}

M.mappings = {
  { "i", "jj", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" } },
  { "n", "<C-P>", ":Telescope keymaps<CR>", { noremap = true, silent = true, desc = "Command palette" } },
  { "n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { noremap = true, silent = true, desc = "Window left" } },
  { "n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { noremap = true, silent = true, desc = "Window down" } },
  { "n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { noremap = true, silent = true, desc = "Window up" } },
  { "n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { noremap = true, silent = true, desc = "Window right" } },
}

M.register_mappings = function(self)
  -- https://stackoverflow.com/a/51757357
  table.unpack = table.unpack or unpack
  for _, mapping in ipairs(self.mappings) do
    if table then
      vim.keymap.set(table.unpack(mapping))
    end
  end
end

M:register_mappings()
