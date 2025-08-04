return {
    'RRethy/vim-illuminate',
    config = function()
        require("catppuccin").setup({
            providers = {
                'lsp',
                'treesitter',
                'regex',
            },
            delay = 100,
            modes_denylist = { "Insert", "i" }
        })
    end
}
