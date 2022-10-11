local opts = { noremap = true, silent = true }
local terminal_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap  -- create short alias for keymap function

-- Remap space to leader
keymap("", "<Space>", "<Nop>", opts)  -- map space to no-op
vim.g.mapleader = " "

-- Insert --
keymap("i", "jk", "<Esc>", opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<leader>c", "<C-w>c", opts)
keymap("n", "<leader>d", ":bd<CR>", opts)  -- Delete (close) current buffer

keymap("n", "<leader>e", ":Lex 12<CR>", opts)  -- <leader>e opens file explorer with set width

-- Save & exit
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>x", ":x<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)

keymap("n", "Y", "y$", opts)

-- Resize windows with arrow keys
keymap("n", "<C-Up>",    ":resize +2<CR>", opts)
keymap("n", "<C-Down>",  ":resize -2<CR>", opts)
keymap("n", "<C-Left>",  ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", terminal_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", terminal_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", terminal_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", terminal_opts)

