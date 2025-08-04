vim.g.mapleader = " "       -- Set leader key before Lazy
vim.g.maplocalleader = "\\" -- Set leader key before Lazy

require("config.lazy_init")
require("config.remap")
require("config.set")
require("config.neovide")
