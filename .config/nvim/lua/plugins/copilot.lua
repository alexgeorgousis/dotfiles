-- copilot
-- https://github.com/github/copilot.vim

return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_filetypes = {
			ruby = false,
		}
	end,
}
