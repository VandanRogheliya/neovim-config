return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        view_options = {
            show_hidden = true,
        },
        columns = {
            "size",
            "icon",
        },
    },
    cmd = { "Oil" },
    keys = {
        { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
        {
            "^",
            function()
                require("oil").open(vim.fn.getcwd())
            end,
            desc = "Open cwd",
        },
    },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
}
