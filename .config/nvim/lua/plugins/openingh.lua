-- Opens files in GitHub (optionally at the line under the cursor!)
return {
	"almo7aya/openingh.nvim",
	config = function()
		vim.api.nvim_set_keymap("n", "<leader>go", ":OpenInGHFileLines <CR>", { silent = true, noremap = true })
	end,
}
