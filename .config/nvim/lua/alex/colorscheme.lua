local colorscheme = "dracula"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- Set background to transparent
-- Note: This needs to be set after the colorscheme, otherwise the colorscheme
-- will override it with its own background color.
vim.cmd "highlight Normal guibg=NONE"

