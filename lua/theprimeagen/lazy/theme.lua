return
{
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
    config = function()
        require("catppuccin").setup {}
        vim.cmd.colorscheme "catppuccin"
    end
}
-- {
--     'projekt0n/github-nvim-theme',
--     lazy = false,  -- make sure we load this during startup if it is your main colorscheme
--     priority = 1000, -- make sure to load this before all the other start plugins
--     config = function()
--         require('github-theme').setup({
--             -- ...
--         })
--
--         -- vim.cmd('colorscheme github_dark_high_contrast')
--         vim.cmd('colorscheme github_light_default')
--     end,
-- }
-- {
--     "navarasu/onedark.nvim",
--     name = "onedark",
--     priority = 1000,
--     config = function()
--         require('onedark').setup {
--             style = 'cool'
--         }
--         require('onedark').load()
--     end,
-- }
