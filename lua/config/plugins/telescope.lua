return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzy-native.nvim' },
    config = function()
        local telescope = require('telescope')
        telescope.setup({})
        telescope.load_extension('fzy_native')
    end
}
