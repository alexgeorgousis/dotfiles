-- Makes the quickfix list prettier
return {
	"yorickpeterse/nvim-pqf",
	config = function()
		require("pqf").setup()
	end,
}
