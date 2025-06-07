-- harpoon2
-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end, { desc = "Add file to list" })
		vim.keymap.set("n", "<leader>hr", function()
			harpoon:list():remove()
		end, { desc = "Remove file from list" })
		vim.keymap.set("n", "<leader>hm", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Menu" })
		vim.keymap.set("n", "<C-]>", function()
			-- ui_nav_wrap makes harpoon wrap around to the first file in the menu if it's currently on the last one
			harpoon:list():next({ ui_nav_wrap = true })
		end, { desc = "Next file" })
		vim.keymap.set("n", "<C-[>", function()
			-- ui_nav_wrap makes harpoon wrap around to the first file in the menu if it's currently on the first one
			harpoon:list():prev({ ui_nav_wrap = true })
		end, { desc = "Previous file" })

		harpoon:extend({
			UI_CREATE = function(cx)
				vim.keymap.set("n", "<C-v>", function()
					harpoon.ui:select_menu_item({ vsplit = true })
				end, { buffer = cx.bufnr })
			end,
		})
	end,
}
