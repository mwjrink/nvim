vim.keymap.set("n", "<leader>a", "<cmd>Telescope aerial<CR>")

vim.keymap.set("n", "<leader>p", "<cmd>vsplit<CR>")
vim.keymap.set("n", "<leader>h", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<leader>l", "<cmd>wincmd l<CR>")

local which_key = require("which-key")
local builtin = require("telescope.builtin")

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
    callback = function(event)
        local opts = { buffer = event.buf }

        local mappings = {
            { "<leader>l",  group = "LSP" },
            { "<leader>la", vim.lsp.buf.code_action,      desc = "Code action" },
            { "<leader>ld", vim.diagnostic.open_float,    desc = "Open diagnostic float" },
            { "<leader>ln", vim.lsp.buf.rename,           desc = "Rename" },
            { "<leader>lr", vim.lsp.buf.references,       desc = "References" },
            { "<leader>lw", vim.lsp.buf.workspace_symbol, desc = "Workspace symbol" },
            { "K",          vim.lsp.buf.hover,            desc = "Show hover information" },
            { "[d",         vim.diagnostic.goto_next,     desc = "Go to next diagnostic" },
            { "]d",         vim.diagnostic.goto_prev,     desc = "Go to previous diagnostic" },
            { "gd",         vim.lsp.buf.definition,       desc = "Go to definition" },
            { "gl",         vim.diagnostic.open_float,    desc = "Open diagnostic float" },
        }

        which_key.add(mappings, opts)

        -- vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
        -- vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
        -- vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
        -- vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
        -- vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
        -- vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
        -- vim.keymap.set('n', '<leader>lca', function() vim.lsp.buf.code_action() end, opts)
        -- vim.keymap.set('n', '<leader>lrr', function() vim.lsp.buf.references() end, opts)
        -- vim.keymap.set('n', '<leader>lrn', function() vim.lsp.buf.rename() end, opts)
        -- vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)

        -- https://www.mitchellhanberg.com/modern-format-on-save-in-neovim/
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = event.buf,
            callback = function()
                vim.lsp.buf.format { async = false, id = event.data.client_id }
            end

        })
    end,
})

local non_lsp_mappings = {
    { "<C-d>",     "<C-d>zz",                                              desc = "Half page down and center" },
    { "<C-u>",     "<C-u>zz",                                              desc = "Half page up and center" },
    { "<leader>/", "<Plug>(comment_toggle_linewise_current)",              desc = "Toggle comment" },
    { "<leader>e", vim.cmd.Ex,                                             desc = "Open file explorer" },
    -- { "<leader>p", '"_dP',                                                 desc = "Paste without overwrite" },
    { "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", desc = "Search and replace word under cursor" },
    { "<leader>t", ":Today<CR>",                                           desc = "Open today's note" },
    { "J",         "mzJ`z",                                                desc = "Join lines and keep cursor position" },
    { "N",         "Nzzzv",                                                desc = "Previous search result and center" },
    { "Q",         "<nop>",                                                desc = "Disable Ex mode" },
    { "n",         "nzzzv",                                                desc = "Next search result and center" },
}

which_key.add(non_lsp_mappings)

-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
-- vim.keymap.set("n", "J", "mzJ`z")       -- Keep cursor in same position on line join
-- vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Keep cursor in middle on half page jump down
-- vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Keep cursor in middle on half page jump down
-- vim.keymap.set("n", "n", "nzzzv")       -- Keep searched term in middle
-- vim.keymap.set("n", "N", "Nzzzv")       -- Keep reverse searched term in middle
-- vim.keymap.set("n", "Q", "<nop>")       --- Just undo capital Q support
-- vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)")
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>t", ":Today<CR>")

-- -- Telescope Commands

local telescope_mappings = {
    { "<leader>f",  group = "Find" },
    { "<leader>ff", builtin.find_files, desc = "Find files" },
    { "<leader>fg", builtin.git_files,  desc = "Find git files" },
    { "<leader>fl", builtin.live_grep,  desc = "Live grep" },
}

which_key.add(telescope_mappings, { prefix = "<leader>" })

-- Register the semicolon mapping separately as it doesn't use the leader prefix
which_key.add({
    { ";", builtin.buffers, desc = "Find buffers" },
})

-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
-- vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
-- vim.keymap.set('n', ';', builtin.buffers, {})

-- Use move command while highlighted to move text
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)")

local visual_mappings =
{
    { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", mode = "v", desc = "Toggle comment" },
    { "J",         ":m '>+1<CR>gv=gv",                       mode = "v", desc = "Move selection down" },
    { "K",         ":m '<-2<CR>gv=gv",                       mode = "v", desc = "Move selection up" },
}

which_key.add(visual_mappings, { mode = "v" })

--- Don't overwrite pastes in visual mode
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Format command
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- insert commands
vim.keymap.set('i', '<Right>', '<Right>', { noremap = true }) -- Make the right arrow behave normally in insert mode
