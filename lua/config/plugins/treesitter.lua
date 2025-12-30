return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local configs = require("nvim-treesitter")
        configs.install({
            "c", "lua", "vim", "vimdoc", "elixir", "javascript", "html", "python", "typescript", "rust", "markdown",
            "markdown_inline"
        });
    end
}
