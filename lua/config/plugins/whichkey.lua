return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { 'echasnovski/mini.nvim' },
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}

-- - `opts.hidden`: option is deprecated.
-- - `opts.window`: option is deprecated. see `opts.win`
-- - `opts.triggers_blacklist`: option is deprecated. see `opts.triggers`
-- - `opts.operators`: option is deprecated. see `opts.defer`
-- - `opts.popup_mappings`: option is deprecated. see `opts.keys`
-- - `opts.key_labels`: option is deprecated. see `opts.replace`
-- - `opts.ignore_missing`: option is deprecated. see `opts.filter`
-- - `opts.triggers`: triggers must be a table
