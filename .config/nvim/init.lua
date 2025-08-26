require("config.lazy")
require("config.options")
require("config.lsp")
require("config.keymaps")

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = true
vim.o.foldlevel = 0
vim.o.foldlevelstart = 99

vim.cmd([[highlight ExtraWhitespace ctermbg=red guibg=red]])
vim.cmd([[match ExtraWhitespace /[\u00a0\u200b\u200c\u200d\u200e\u200f]/]])
