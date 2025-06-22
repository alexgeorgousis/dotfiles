-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", { desc = "Map j-k to Escape" })
vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Use H to move to beginning of the line" })
vim.keymap.set({ "n", "v" }, "L", "$", { desc = "Use L to move to end of the line" })

-- Restore "s" in normal mode to replace a character - it's taken over by Leap.nvim by default (comment this out if you wanna see what that does).
vim.keymap.del("n", "s")
