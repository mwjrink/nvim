return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        enabled = true,
        whitespace = { SPACE },
        indent = {
            char = '▏',
        },
        scope = {
            enabled = true,
            show_start = false,
            show_end = false,
        },
    },
}
