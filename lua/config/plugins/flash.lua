local function format(opts)
    -- always show first and second label
    return {
        { opts.match.label1, opts.hl_group },
        { opts.match.label2, opts.hl_group },
        -- { opts.match.label1, "FlashLabel" },
        -- { opts.match.label2, "FlashLabel" },
    }
end

-- jump to line
-- require("flash").jump({
--   search = { mode = "search", max_length = 0 },
--   label = { after = { 0, 0 } },
--   pattern = "^"
-- })
--
-- jump to word under cursor
-- require("flash").jump({
--   pattern = vim.fn.expand("<cword>"),
-- })

local label_opts = {
    after = false,
    before = { 0, -2 },
    -- before = { 0, 0 },
    uppercase = false,
    format = format,
    rainbow = {
        enabled = true,
        shade = 9,
    },
}

local jumper_opts = {
    search = {
        mode = "search"
    },
    highlight = {
        backdrop = true,
        matches = true
    },
    label = label_opts,
    pattern = [[\<]],
    action = function(match, state)
        state:hide()
        require("flash").jump({
            search = {
                max_length = 0
            },
            highlight = {
                backdrop = true,
                matches = true
            },
            label = label_opts,
            matcher = function(win)
                -- limit matches to the current label
                return vim.tbl_filter(function(m)
                    return m.label == match.label and m.win == win
                end, state.results)
            end,
            labeler = function(matches)
                for _, m in ipairs(matches) do
                    m.label = m.label2 -- use the second label
                end
            end,
        })
    end,
    labeler = function(matches, state)
        local labels = state:labels()
        for m, match in ipairs(matches) do
            match.label1 = labels[math.floor((m - 1) / #labels) + 1]
            match.label2 = labels[(m - 1) % #labels + 1]
            match.label = match.label1
        end
    end,
};

local modes_opts = {
    char = { jump_labels = true },
    treesitter = jumper_opts,
    treesitter_search = (function()
        local opts = jumper_opts
        opts.remote_op = { restore = true }
        return opts
    end)(),
    remote = (function()
        local opts = jumper_opts
        opts.remote_op = { restore = true, motion = true }
        return opts
    end)(),
};

local final_opts = (function()
    local opts = jumper_opts
    opts.mode = modes_opts
    return opts
end)()

return {
    "folke/flash.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump(final_opts) end, desc = "Flash" },
        -- { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter(jumper_opts) end,        desc = "Flash Treesitter" },
        -- { "r", mode = "o",               function() require("flash").remote(final_opts) end, desc = "Remote Flash" },
        -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search(jumper_opts) end, desc = "Treesitter Search" },
        -- { "<c-s>", mode = { "c" },           function() require("flash").toggle(jumper_opts) end,            desc = "Toggle Flash Search" },
    },
}
