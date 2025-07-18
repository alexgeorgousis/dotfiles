-- Tokyonight theme for Neovim.
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
return {
	"folke/tokyonight.nvim",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	init = function()
		-- Load the colorscheme here.
		-- Like many other themes, this one has different styles, and you could load
		-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
		vim.cmd.colorscheme("tokyonight-night")

		-- Clear background for transparency (transparency is configured by Terminal emulator)
		vim.cmd.hi([[Normal guibg=none ctermbg=none]])

		-- You can configure highlights by doing something like:
		vim.cmd.hi("Comment gui=none")
	end,
}
