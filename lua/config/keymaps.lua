vim.g.mapleader = " "
vim.g.maplocalleader = "="

vim.keymap.set('n', '<leader>fe', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>fs', ':w<CR>')
vim.keymap.set('n', '<leader>fd', ':e!<CR>')

vim.keymap.set('n', '<leader>q', '<C-w>h')
vim.keymap.set('n', '<leader>e', '<C-w>l')

vim.keymap.set('i', ';;', '<Esc>')
vim.keymap.set('i', ';:', ';<Esc>')

vim.keymap.set('t', ';;', '<C-\\><C-n>')
vim.keymap.set('t', ';b', 'cmake --build build<CR>')

vim.keymap.set('n', '<leader>nh', ':noh<CR>')

vim.keymap.set('n', '<leader>de', ':lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '<leader>di', ':lua vim.lsp.buf.hover()<CR>')

vim.keymap.set('n', '<leader>nu', ':set rnu!<CR>')

vim.keymap.set('n', '<leader>hm', ':lua require(\'harpoon.ui\').toggle_quick_menu()<CR>')
vim.keymap.set('n', '<leader>ha', ':lua require(\'harpoon.mark\').add_file()<CR>')
vim.keymap.set('n', '<leader>hr', ':lua require(\'harpoon.mark\').rm_file()<CR>')
vim.keymap.set('n', '<leader>hf', ':lua require(\'harpoon.ui\').nav_file()<Left>')
vim.keymap.set('n', '<leader>ht', ':lua require(\'harpoon.term\').gotoTerminal()<Left>')
vim.keymap.set('n', '<leader>hq', ':lua require(\'harpoon.ui\').nav_prev()<CR>')
vim.keymap.set('n', '<leader>he', ':lua require(\'harpoon.ui\').nav_next()<CR>')
