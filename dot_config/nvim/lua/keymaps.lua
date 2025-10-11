-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set("i", "jk", "<Esc>", { desc = "Map j-k to Escape" })
vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Use H to move to beginning of the line" })
vim.keymap.set({ "n", "v" }, "L", "$", { desc = "Use L to move to end of the line" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save buffer" })
vim.keymap.set("n", "<leader>q", ":qa<CR>", { desc = "Quit neovim" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })

vim.keymap.set(
	"n",
	"<C-f>",
	"<cmd>silent !tmux neww find-project<CR>",
	{ desc = "Open new tmux window and run find-project" }
)

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>qf", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Create a command to create a quickfix list with all files changed on the current branch compared to master (re-creating the PR view on GitHub).
vim.api.nvim_create_user_command("GitPRView", function()
	local files = vim.fn.systemlist("git diff --name-only master...HEAD")
	local qf_entries = {}
	for _, file in ipairs(files) do
		table.insert(qf_entries, { filename = file })
	end
	vim.fn.setqflist(qf_entries, "r")
	vim.cmd("copen")
	vim.cmd("wincmd H")
	vim.cmd("vertical resize 60")
	vim.cmd("setlocal nowrap")
end, {})
vim.keymap.set("n", "<leader>gdm", "<cmd>Gvdiffsplit master<CR>", { desc = "Show diff of current file against master" })
