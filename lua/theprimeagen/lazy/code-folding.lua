return
{
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            -- local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                -- configuration goes here, for example:
                -- relculright = true,
                -- segments = {
                --   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                --   {
                --     sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },
                --     click = "v:lua.ScSa"
                --   },
                --   { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
                --   {
                --     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
                --     click = "v:lua.ScSa"
                --   },
                -- }
            })
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        event = "VeryLazy",
        opts = {
            -- INFO: Uncomment to use treeitter as fold provider, otherwise nvim lsp is used
            -- provider_selector = function(bufnr, filetype, buftype)
            --   return { "treesitter", "indent" }
            -- end,
            open_fold_hl_timeout = 400,
            close_fold_kinds_for_ft = { "imports", "comment" },
            preview = {
                win_config = {
                    border = { "", "─", "", "", "", "─", "", "" },
                    -- winhighlight = "Normal:Folded",
                    winblend = 0,
                },
                mappings = {
                    scrollU = "<C-u>",
                    scrollD = "<C-d>",
                    jumpTop = "[",
                    jumpBot = "]",
                },
            },
        },
        init = function()
            vim.o.fillchars = [[eob: ,fold: ,foldopen:-,foldsep: ,foldclose:+]]
            -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
            vim.o.foldcolumn = '1' -- '0' is not bad
            vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
        end,
        config = function(_, opts)
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local totalLines = vim.api.nvim_buf_line_count(0)
                local foldedLines = endLnum - lnum
                local suffix = (" 󰁂 %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                local rAlignAppndx =
                    math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
                suffix = (" "):rep(rAlignAppndx) .. suffix
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end
            opts["fold_virt_text_handler"] = handler
            require("ufo").setup(opts)
            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
            vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
            vim.keymap.set("n", "K", function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    -- vim.lsp.buf.hover()
                    vim.cmd [[ Lspsaga hover_doc ]]
                end
            end)
        end,
    },
}
--     {
--         "lukas-reineke/indent-blankline.nvim",
--         main = "ibl",
--         opts = {},
--         config = function()
--             require("ibl").setup()
--             -- require("ibl").setup {
--                 -- char = "▏",
--                 -- buftype_exclude = { "terminal" },
--                 -- show_trailing_blankline_indent = false,
--                 -- show_current_context = true,
--                 -- filetype_exclude = { "help", "terminal" },
--                 -- -- default : {'class', 'function', 'method'}
--                 -- context_patterns = {
--                 --     "class",
--                 --     "function",
--                 --     "method",
--                 --     "^if",
--                 --     "^while",
--                 --     "^for",
--                 --     "^object",
--                 --     "^table",
--                 --     "^type",
--                 --     "^import",
--                 --     "block",
--                 --     "arguments"
--                 -- }
--                 -- -- disabled now for performance hit.
--                 -- -- use_treesitter = true
--             -- }
--         end,
--     }
-- }
--
-- -- local handler = function(virtText, lnum, endLnum, width, truncate)
--     local newVirtText = {}
--     local suffix = (' 󰁂 %d '):format(endLnum - lnum)
--     local sufWidth = vim.fn.strdisplaywidth(suffix)
--     local targetWidth = width - sufWidth
--     local curWidth = 0
--     for _, chunk in ipairs(virtText) do
--         local chunkText = chunk[1]
--         local chunkWidth = vim.fn.strdisplaywidth(chunkText)
--         if targetWidth > curWidth + chunkWidth then
--             table.insert(newVirtText, chunk)
--         else
--             chunkText = truncate(chunkText, targetWidth - curWidth)
--             local hlGroup = chunk[2]
--             table.insert(newVirtText, {chunkText, hlGroup})
--             chunkWidth = vim.fn.strdisplaywidth(chunkText)
--             -- str width returned from truncate() may less than 2nd argument, need padding
--             if curWidth + chunkWidth < targetWidth then
--                 suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
--             end
--             break
--         end
--         curWidth = curWidth + chunkWidth
--     end
--     table.insert(newVirtText, {suffix, 'MoreMsg'})
--     return newVirtText
-- end
--
-- return {
--     'kevinhwang91/nvim-ufo',
--     dependencies = { 'kevinhwang91/promise-async' },
--     config = function()
--         require('ufo').setup({
--             provider_selector = function(bufnr, filetype, buftype)
--                 return { 'treesitter', 'indent' }
--             end,
--             fold_virt_text_handler = handler
--         })
--         vim.o.foldcolumn = '1' -- '0' is not bad
--         vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
--         vim.o.foldlevelstart = 99
--         vim.o.foldenable = true
--
--         -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
--         vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
--         vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
--     end
--
-- }
