vim.cmd.colorscheme("catppuccin-mocha")

vim.o.guifont = "JetBrainsMono Nerd Font:h12"

vim.opt.cmdheight = 0

-- vim.opt.showcmdloc = 'statusline'

vim.opt.clipboard = 'unnamedplus' -- use system keyboard for yank

vim.opt.number = true             -- set line numbers -- set line numbers
vim.opt.relativenumber = true     -- use relative line numbers

vim.opt.jumpoptions = 'stack'

-- set tab size to 2 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.incsearch = true -- incremental search

vim.opt.termguicolors = true

vim.diagnostic.config({
    virtual_text = true,
    --virtual_lines = {
    --  current_line = true
    --},
})

-- vim.api.nvim_set_hl(0, "@foo.bar.lua", { link = "Identifier" })
-- vim.treesitter.query.set("c", "injections", "(comment) @comment")
