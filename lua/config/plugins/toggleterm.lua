return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
        --[[ things you want to change go here]]
        direction = 'float',
        open_mapping = [[<leader>g]],
        insert_mappings = false,
        float_opts = {
            border = 'curved',
            -- TODO make these functions that use nvim_win_get_width & nvim_win_get_height
            width = 128,
            height = 40,
        }
    }
}
