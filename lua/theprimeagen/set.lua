vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

-- Function to check if macOS is in dark mode
local function is_dark_mode()
    local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
    if handle == nil then
        return
    end
    local result = handle:read("*a")
    handle:close()
    return result:match("Dark")
end

-- Set Neovim background based on macOS dark mode
if is_dark_mode() then
    vim.o.background = 'dark'
    print("Setting background to dark mode")
else
    vim.o.background = 'light'
    print("Setting background to light mode")
end

-- Spell
vim.cmd [[
  set spell
  set spelllang=en_us
  set spelloptions=noplainbuffer
  set spellcapcheck=
  set spellsuggest=best

  autocmd FileType go setlocal spell spelllang=en_us spelloptions=noplainbuffer spellcapcheck= spellsuggest=best
]]

-- Save on blur
-- Write all writable buffers when changing buffers or losing focus.
vim.opt.autowriteall = true  -- Save when doing various buffer-switching things.

-- Save anytime we leave a buffer or Neovim loses focus.
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command('silent update')
    end
  end,
})

-- White space
vim.opt.list = true
vim.opt.listchars:append("tab:▸\\ ")
vim.opt.listchars:append("extends:>")
vim.opt.listchars:append("precedes:<")
vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("space:·")
