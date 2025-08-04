return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("lualine").setup({
            theme = "catppuccin",

            -- globalstatus = true
            sections = {
                lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 3) end } },
                lualine_b = { 'branch', 'diff' },
                lualine_c = { 'filename' },
                -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_x = {
                    {
                        require("noice").api.status.search.get,
                        cond = require("noice").api.status.search.has,
                        color = { fg = "#8888FF" },
                    },
                    {
                        require("noice").api.status.command.get,
                        cond = require("noice").api.status.command.has,
                        color = { fg = "#ff9e64" },
                    },
                    'diagnostics',
                    -- 'lsp_status'
                },
                -- lualine_x = { 'lsp_status' },
                lualine_y = { 'filetype' },
                lualine_z = { 'location' }

            },
        })
    end
}
