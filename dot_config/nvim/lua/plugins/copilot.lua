-- GitHub Copilot AI assistant
-- https://github.com/github/copilot.vim

return {
	"github/copilot.vim",
	event = "InsertEnter",
	config = function()
		-- Use Tab to accept suggestions
		vim.g.copilot_no_tab_map = true
		vim.api.nvim_set_keymap("i", "<Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

		-- Use Ctrl+] for next suggestion, Ctrl+[ for previous
		vim.api.nvim_set_keymap("i", "<C-]>", "<Plug>(copilot-next)", {})
		vim.api.nvim_set_keymap("i", "<C-[>", "<Plug>(copilot-previous)", {})

		-- Dismiss suggestion with Ctrl+\
		vim.api.nvim_set_keymap("i", "<C-\\>", "<Plug>(copilot-dismiss)", {})
	end,
}