return {
    { 'neoclide/coc.nvim', branch = 'release' },
    {
        'iamcco/coc-spell-checker',
        run = 'yarn install --frozen-lockfile',
        config = function()
            vim.keymap.set('v', '<leader>a', '<Plug>(coc-codeaction-selected)', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>a', '<Plug>(coc-codeaction-selected)', { noremap = true, silent = true })
        end
    }
}
