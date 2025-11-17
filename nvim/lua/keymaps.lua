vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })
vim.keymap.set('n', '<leader><leader>', 'V', { desc = 'Select line' })
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Find current file in explorer' })
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<F4>', ':bdelete<CR>', { desc = 'Close current buffer' })

-- Telescope keybindings (only define these after Telescope is loaded)
local telescope_ok, builtin = pcall(require, 'telescope.builtin')
if telescope_ok then
  -- Leader + o: Search files from current working directory (PWD)
  vim.keymap.set('n', '<leader>o', function()
    builtin.find_files({ cwd = vim.fn.getcwd() })
  end, { desc = 'Find files in PWD' })

  -- Leader + p: Search files from home directory
  vim.keymap.set('n', '<leader>p', function()
    builtin.find_files({ cwd = vim.fn.expand('$HOME') })
  end, { desc = 'Find files in HOME' })
end

-- LSP keybindings (set up when LSP attaches to a buffer)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }

    -- Go to definition
    vim.keymap.set('n', '<M-j>', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to definition' }))

    -- Go to declaration
    vim.keymap.set('n', '<M-k>', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to declaration' }))

    -- Show hover information
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover documentation' }))

    -- Go to implementation
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'Go to implementation' }))

    -- Show signature help
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature help' }))

    -- Rename symbol
    vim.keymap.set('n', '<leader>s', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename symbol' }))

    -- Code action (fix it / quick fix)
    vim.keymap.set('n', '<M-f>', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code action' }))

    -- Show references
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'Show references' }))

    -- Format document
    vim.keymap.set('n', '<leader>fm', function()
      vim.lsp.buf.format({ async = true })
    end, vim.tbl_extend('force', opts, { desc = 'Format document' }))

    -- Show diagnostics
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'Show diagnostics' }))
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'Previous diagnostic' }))
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'Next diagnostic' }))
  end,
})
