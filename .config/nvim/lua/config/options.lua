vim.keymap.set("", "<Up>", "<Nop>", { noremap = true })
vim.keymap.set("", "<Down>", "<Nop>", { noremap = true })
vim.keymap.set("", "<Left>", "<Nop>", { noremap = true })
vim.keymap.set("", "<Right>", "<Nop>", { noremap = true })

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0  -- use tabstop value for autoindent
vim.opt.softtabstop = 4

vim.opt.scrolloff = 999

vim.opt.cursorline = true

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.opt.colorcolumn = "80"
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = "yellow", bg = "#444400" })

vim.o.timeout = false

vim.diagnostic.config({
    virtual_lines = true
})

-- Netrw config

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
-- vim.g.netrw_altv = 1
-- vim.g.netrw_winsize = 25

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

