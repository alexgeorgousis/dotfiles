return {
	"tpope/vim-fugitive",
	config = function()
		-- Move Fugitive's :G buffer to a vertical split on the left and make it smaller
		vim.cmd([[
        autocmd User FugitiveIndex wincmd H | vertical resize 60
      ]])
	end,
}
