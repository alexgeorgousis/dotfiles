local options = {
  backup = false,
  writebackup = false,
  swapfile = false,
  clipboard = "unnamedplus",
  number = true,
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  wrap = false,
  scrolloff = 8,        -- always show min 8 lines above and below cursor
  sidescrolloff = 8,    -- same as scrolloff but horizontally (works only if wrap is false)
  smartcase = true,     -- only care about case if search pattern includes capital letters
  mouse = "a",
  showmode = false,     -- hide mode at the bottom of the window (-- INSERT --, -- VISUAL -- etc.)
  splitbelow = true,    -- create new horizontal splits below
  splitright = true,    -- create new vertical splits right
  termguicolors = true,
  cursorline = true,
  numberwidth = 2,      -- set number column width (default: 4)
  signcolumn = "yes",     -- always shows sign column (otherwise the text shifts when a sign pops up)
  hlsearch = false,
}

vim.opt.shortmess:append "c"  -- hides some annoying messages (see :help shortmess for more info)

for k, v in pairs(options) do
  vim.opt[k] = options[k]
end

