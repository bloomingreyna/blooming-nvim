require('config.plugin_manager')
require('config.keymaps')
require('config.options')

require('nvim-tree').setup({
    filters = {
        git_ignored = false
    }
})

local cmp = require('cmp')

local ELLIPSIS = '…'
local MAX_NAME_WIDTH = 25
local MAX_KIND_WIDTH = 15
local MAX_MENU_WIDTH = 15

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<C-l>'] = cmp.mapping.close()
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }
    }, {
        { name = 'buffer' }
    }),
    formatting = {
        fields = {'abbr', 'kind', 'menu'},
        format = function(entry, item)
            local abbr_length = vim.fn.strdisplaywidth(item.abbr)
            local kind_length = vim.fn.strdisplaywidth(item.kind)
            local menu_length = vim.fn.strdisplaywidth(item.menu)

            if abbr_length > MAX_NAME_WIDTH then
                item.abbr = string.sub(item.abbr, 1, MAX_NAME_WIDTH) .. ELLIPSIS
            end

            if kind_length > MAX_KIND_WIDTH then
                item.kind = string.sub(item.kind, 1, MAX_KIND_WIDTH) .. ELLIPSIS
            end

            if menu_length > MAX_MENU_WIDTH then
                item.menu = string.sub(item.menu, 1, MAX_MENU_WIDTH) .. ELLIPSIS
            end

            return item
        end
    }
})

local default_capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('clangd', {
    capabilities = default_capabilities,
    cmd = {
        'clangd',
        '--header-insertion=never'
    }
})

vim.lsp.enable('clangd')

require('lualine').setup({})

require('telescope').setup({
    pickers = {
        live_grep = {
            layout_config = {
                horizontal = {
                    preview_cutoff = 0
                },
                vertical = {
                    preview_cutoff = 0
                }
            }
        }
    }
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>tf', builtin.find_files)
vim.keymap.set('n', '<leader>tg', builtin.live_grep)
vim.keymap.set('n', '<leader>tb', builtin.buffers)
vim.keymap.set('n', '<leader>th', builtin.help_tags)

local current_term_window = nil
local current_term_buffer = nil
function create_terminal()
    if type(current_term_window) ~= 'number' or not vim.api.nvim_win_is_valid(current_term_window) then
        if type(current_term_buffer) ~= 'number' or not vim.api.nvim_buf_is_valid(current_term_buffer) then
            current_term_buffer = vim.api.nvim_create_buf(false, true)
        end

        local width = math.floor(vim.o.columns * 0.45)
        local height = math.floor(vim.o.lines * 0.5)

        local opts = {
            relative = 'editor',
            width = width,
            height = height,
            row = 1,
            col = vim.o.columns - width - 5,
            border = 'double'
        }

        current_term_window = vim.api.nvim_open_win(current_term_buffer, true, opts)

        vim.cmd.term()
        vim.cmd('startinsert')
    else
        vim.api.nvim_win_close(current_term_window, true)
    end
end

vim.keymap.set('n', '<leader>cmd', create_terminal)

require('everforest').setup({
    background = 'hard'
})
vim.cmd.colorscheme('everforest')
