return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                auto_close = true
            })

            vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle focus=true filter.severity=vim.diagnostic.severity.ERROR<CR>")
            vim.keymap.set("n", "<leader>tT", "<cmd>Trouble diagnostics toggle focus=true<CR>")

            -- vim.keymap.set("n", "[t", function()
            --     require("trouble").next({ skip_groups = true, jump = true });
            -- end)

            -- vim.keymap.set("n", "]t", function()
            --     require("trouble").previous({ skip_groups = true, jump = true });
            -- end)
        end
    },
}
