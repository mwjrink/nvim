if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.g.neovide_padding_top = 8
    vim.g.neovide_padding_bottom = 8
    vim.g.neovide_padding_right = 8
    vim.g.neovide_padding_left = 8

    vim.g.neovide_theme = 'catppuccin'
    vim.g.neovide_refresh_rate = 120
    vim.g.neovide_cursor_animation_length = 0.05
    vim.g.neovide_cursor_short_animation_length = 0.05
    vim.g.neovide_cursor_trail_size = 0.2
    vim.g.neovide_cursor_antialiasing = false
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_vfx_mode = ""
    vim.opt.termguicolors = true

    vim.g.neovide_scroll_animation_length = 0
    vim.g.neovide_scroll_animation_far_lines = 0
end
