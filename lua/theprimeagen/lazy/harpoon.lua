return {
    "ThePrimeagen/harpoon",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        local harpoon_ui = require("harpoon.ui")
        local harpoon_mark = require("harpoon.mark")

        vim.keymap.set("n", "<leader>h", function() harpoon_mark.add_file() end)
        vim.keymap.set("n", "<C-p>", function() harpoon_ui.toggle_quick_menu() end)

        vim.keymap.set("n", "<C-h>", function() harpoon_ui.nav_file(1) end)
        vim.keymap.set("n", "<C-t>", function() harpoon_ui.nav_file(2) end)
        vim.keymap.set("n", "<C-n>", function() harpoon_ui.nav_file(3) end)
        vim.keymap.set("n", "<C-s>", function() harpoon_ui.nav_file(4) end)

        vim.keymap.set("n", "<leader><C-h>", function() harpoon_mark.set_mark(1) end)
        vim.keymap.set("n", "<leader><C-t>", function() harpoon_mark.set_mark(2) end)
        vim.keymap.set("n", "<leader><C-n>", function() harpoon_mark.set_mark(3) end)
        vim.keymap.set("n", "<leader><C-s>", function() harpoon_mark.set_mark(4) end)
    end


}
