-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local augroups = function(groups)
  for name, entry in pairs(groups) do
    local group = vim.api.nvim_create_augroup(name, { clear = true })
    for _, command in ipairs(entry) do
      local events, opts = table.unpack(command)
      opts["group"] = group
      print(require("utils.dump")(opts))
      vim.api.nvim_create_autocmd(events, opts)
    end
  end
end

local M = {
  -- open_folds = {
  --   { { "bufReadPost", "FileReadPost" }, { command = "zR" } },
  -- },
}

augroups(M)
