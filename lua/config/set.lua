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
--
-- local function open_floating_window()
--     local window_ids = vim.api.nvim_list_wins()
--     for _, win_id in ipairs(window_ids) do
--         print("Window ID: " .. win_id)
--         local cfg = vim.api.nvim_win_get_config(win_id)
--         if (cfg.relative or cfg.external) then
--             --  this is a floating window
--         end
--     end
--     -- Create a new scratch buffer for the floating window content
--     local buf = vim.api.nvim_create_buf(false, true)
--
--     -- Set buffer content
--     vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
--         "Hello from a floating window!",
--         "This is some custom content."
--     })
--
--     -- Define window configuration
--     local win_config = {
--         relative = "editor", -- Position relative to the editor
--         row = 5,             -- Row position
--         col = 10,            -- Column position
--         width = 50,          -- Width of the window
--         height = 5,          -- Height of the window
--         border = "rounded",  -- Border style (e.g., "rounded", "single", "double")
--         focusable = true,    -- Allow focus on the floating window
--         zindex = 100         -- Z-index for stacking windows
--     }
--
--     -- Open the floating window
--     local win_id = vim.api.nvim_open_win(buf, true, win_config)
--
--     -- Optionally, you can set filetype or other buffer options
--     vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
--     vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
-- end
--
-- -- You can call this function from a command or a keybinding
-- vim.api.nvim_create_user_command("OpenFloatingWindow", open_floating_window, {})
--
-- local function custom_goto_definition()
--     vim.lsp.buf.definition({
--         -- Define a custom handler for the definition response
--         on_list = function(opts)
--             if (#opts.items > 1) then
--
--             else if (#opts.items > 0) then
--                 open_floating_window();
--             else
--                 'definition not found';
--             end
--         end
--     })
-- end
--
-- vim.keymap.set('n', '<leader>gd', custom_goto_definition, { buffer = true, desc = "Custom Go To Definition" })
