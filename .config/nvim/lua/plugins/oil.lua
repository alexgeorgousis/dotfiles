-- Neovim file manager
-- https://github.com/stevearc/oil.nvim

return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
		})
	end,
}
