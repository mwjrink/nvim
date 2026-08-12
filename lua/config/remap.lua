local which_key = require("which-key")


-- local swap_window = function(direction)
--     local current_win_num = vim.fn.winnr()
--     local target_win = if (direction == 'l') {
--         target_win = current_win_num + 1
--         -- check if target_win is a valid win
--     } else if (direction == 'h') {
--         target_win = min(current_win_num - 1, 0)
--     } else {
--         return;
--     }
--     vim.cmd(target_win .. 'wincmd x')
-- end
local swap_window_h = function()
    local current_win_num = vim.fn.winnr()
    local target_win = current_win_num - 1
    if target_win < 1 then
        return
    end

    vim.cmd(target_win .. 'wincmd x')
end

local swap_window_l = function()
    local current_win_num = vim.fn.winnr()
    local last_win_num = vim.fn.winnr('$') -- Gets the total number of windows
    local target_win = current_win_num + 1
    if target_win > last_win_num then
        return
    end

    vim.cmd(target_win .. 'wincmd x')
end

local window_mappings = {
    { "<leader>v",  "<cmd>vsplit<CR>",   desc = "Split window vertical" },
    { "<leader>h",  "<cmd>wincmd h<CR>", desc = "Focus left" },
    { "<leader>l",  "<cmd>wincmd l<CR>", desc = "Focus right" },
    { "<leader>wh", swap_window_h,       desc = "Swap window left" },
    { "<leader>wl", swap_window_l,       desc = "Swap window right" },
}

which_key.add(window_mappings)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
    callback = function(event)
        local opts = { buffer = event.buf }

        local mappings = {
            { "<leader>d",  group = "LSP" },
            { "<leader>da", vim.lsp.buf.code_action,      desc = "Code action" },
            { "<leader>dd", vim.diagnostic.open_float,    desc = "Open diagnostic float" },
            { "<leader>dn", vim.lsp.buf.rename,           desc = "Rename" },
            { "<leader>dr", vim.lsp.buf.references,       desc = "References" },
            { "<leader>dw", vim.lsp.buf.workspace_symbol, desc = "Workspace symbol" },
            { "K",          vim.lsp.buf.hover,            desc = "Show hover information" },
            { "]d",         vim.diagnostic.goto_next,     desc = "Go to next diagnostic" },
            { "[d",         vim.diagnostic.goto_prev,     desc = "Go to previous diagnostic" },
            { "gd",         vim.lsp.buf.definition,       desc = "Go to definition" },
            { "gl",         vim.diagnostic.open_float,    desc = "Open diagnostic float" },
            { "<C-h>",      vim.lsp.buf.signature_help,   desc = "Signature help" },
        }

        which_key.add(mappings, opts)

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
    { "<leader>e", '<cmd>Yazi<cr>',                                        desc = "Open file explorer" },
    { "<leader>p", '"_dP',                                                 desc = "Paste without overwrite" },
    -- { "p",         '"_dp',                                    desc = "Paste without overwrite" },
    { "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", desc = "Search and replace word under cursor" },
    -- { "<leader>t", ":Today<CR>",                                           desc = "Open today's note" },
    { "J",         "mzJ`z",                                                desc = "Join lines and keep cursor position" },
    { "N",         "Nzzzv",                                                desc = "Previous search result and center" },
    { "Q",         "<nop>",                                                desc = "Disable Ex mode" },
    { "n",         "nzzzv",                                                desc = "Next search result and center" },
}

which_key.add(non_lsp_mappings)

-- Telescope Commands
local builtin = require("telescope.builtin")

local search_word = function()
    local word = vim.fn.expand("<cword>")
    local root = vim.fs.root(0, { '.git', 'justfile', 'package.json', 'Cargo.toml', 'Makefile' })
    builtin.grep_string({ cwd = root, search = word })
    -- builtin.live_grep({ cwd = root, default_text = word })
end

local search_line = function()
    local word = vim.fn.expand("<cWORD>")
    local root = vim.fs.root(0, { '.git', 'justfile', 'package.json', 'Cargo.toml', 'Makefile' })
    builtin.grep_string({ cwd = root, search = word })
    -- builtin.live_grep({ cwd = root, default_text = word })
end

local live_grep_wrap = function()
    local root = vim.fs.root(0, { '.git', 'justfile', 'package.json', 'Cargo.toml', 'Makefile' })
    builtin.live_grep({ cwd = root })
end

local find_files_wrap = function()
    local root = vim.fs.root(0, { '.git', 'justfile', 'package.json', 'Cargo.toml', 'Makefile' })
    builtin.find_files({ cwd = root })
end

local search_fuzzy = function()
    local root = vim.fs.root(0, { '.git', 'justfile', 'package.json', 'Cargo.toml', 'Makefile' })
    builtin.grep_string({ cwd = root, shorten_path = true, word_match = "-w", only_sort_text = true, search = '' })
end

local telescope_mappings = {
    { "<leader>a",  "<cmd>Telescope aerial<CR>", desc = "Telescope aerial" },
    { "<leader>j",  group = "Find" },
    { "<leader>jd", find_files_wrap,             desc = "Find a file" },
    -- { "<leader>fg", builtin.git_files,  desc = "Find git files" },
    { "<leader>jf", live_grep_wrap,              desc = "Fuzzy find in a file" },
    { "<leader>jr", search_fuzzy,                desc = "Find in a file" },
    { "<leader>jw", search_word,                 desc = "Find word under cursor" },
    { "<leader>js", search_line,                 desc = "Find line under cursor" },
    { "<leader>jb", builtin.buffers,             desc = "Find buffers" },
    -- vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
}

which_key.add(telescope_mappings)

-- local trouble = require("trouble")
local trouble_mappings = {
    { "<leader>t",  group = "Trouble" },
    { "<leader>tj", "<cmd>Trouble diagnostics toggle focus=true filter.severity=vim.diagnostic.severity.ERROR<CR>", desc = "Open Trouble" },
    { "<leader>th", "<cmd>Trouble diagnostics toggle focus=true<CR>",                                               desc = "Focus Trouble window" },
    { "<leader>tc", "<cmd>Trouble close<CR>",                                                                       desc = "Close Trouble window" },
    -- { "<leader>t[", function() trouble.next({ skip_groups = true, jump = true }) end,                               desc = "Trouble next issue" },
    -- { "<leader>t]", function() trouble.previous({ skip_groups = true, jump = true }) end,                           desc = "Trouble previous issue" },
}

which_key.add(trouble_mappings)

which_key.add({ { "<leader>u", vim.cmd.UndotreeToggle } })

local visual_mappings =
{
    { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", mode = "v", desc = "Toggle comment" },
    { "J",         ":m '>+1<CR>gv=gv",                       mode = "v", desc = "Move selection down" },
    { "K",         ":m '<-2<CR>gv=gv",                       mode = "v", desc = "Move selection up" },
}

which_key.add(visual_mappings, { mode = "v" })

--- Don't overwrite pastes in visual mode
-- vim.keymap.set('x', 'p', '\"_dp');

-- Format command
which_key.add({ { "<leader>f", vim.lsp.buf.format(), desc = "Format document" } });

-- insert commands
vim.keymap.set('i', '<Right>', '<Right>', { noremap = true }) -- Make the right arrow behave normally in insert mode

-- vim.keymap.set('n', '<leader>vh', '<nop>')
local function switch_case()
    local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
    local word = vim.fn.expand('<cword>')
    local word_start = vim.fn.matchstrpos(vim.fn.getline('.'), '\\k*\\%' .. (col + 1) .. 'c\\k*')[2]

    -- Detect camelCase
    if word:find('[a-z][A-Z]') then
        -- Convert camelCase to snake_case
        local snake_case_word = word:gsub('([a-z0-9])([A-Z0-9])', '%1_%2'):lower()
        vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { snake_case_word })
        -- Detect snake_case
    elseif word:find('_[a-z]') then
        -- Convert snake_case to camelCase
        local camel_case_word = word:gsub('(_)([a-z0-9])', function(_, l) return l:upper() end)
        vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { camel_case_word })
    else
        print("Not a snake_case or camelCase word")
    end
end

local function restart_nvim()
    require("persistence").save()

    vim.cmd('restart lua require("persistence").load()')
    -- TODO the following does not fix the neovide rendering bug, I still need to manually hit a key
    -- vim.cmd([[execute 'restart lua require("persistence").load()' | normal! ]])
end

which_key.add({ { mode = 'nv', '<leader>cr', switch_case, desc = 'Toggle camelCase & snake_case' } })

which_key.add({ { mode = 'n', '<leader>tt', switch_case, desc = 'Toggle camelCase & snake_case' } })

which_key.add({ { mode = 'n', '<leader>qs', function() require("persistence").load() end, desc = 'Load last session.' } })
which_key.add({ { mode = 'n', '<leader>rr', restart_nvim, desc = 'Load last session.' } })
