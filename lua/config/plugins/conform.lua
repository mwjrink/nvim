return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "gofmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                elixir = { "mix" },
                rust = { "rustfmt", lsp_format = "fallback" },
            }
        })
    end
}
