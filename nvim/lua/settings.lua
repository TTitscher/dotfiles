-- show line numbers
vim.opt.number = true 

-- convert tabs to spaces
vim.opt.expandtab = true

-- number of spaces for indentation
vim.opt.shiftwidth = 2

-- number of spaces for <tab> 
vim.opt.tabstop = 2

-- indent follows previous lines
vim.opt.smartindent = true

-- 24-bit RGB colors (required by fancy color schemes)
vim.opt.termguicolors = true

-- Set leader key (optional but recommended)
vim.g.mapleader = ' '

-- keep cursor centered 
vim.opt.scrolloff = 10

-- highlight cursor line
vim.opt.cursorline = true

-- enable mouse support in all modes
vim.opt.mouse = 'a'

-- undo
vim.opt.undofile = true

-- Ignore case when searching...
vim.opt.ignorecase = true
-- ...unless the search pattern contains uppercase letters
vim.opt.smartcase = true

-- Show search results as you type
vim.opt.incsearch = true

-- Show a vertical line at column 80 to indicate line length limit
vim.opt.colorcolumn = '80'

-- Set backup directory to keep backup files organized (instead of cluttering working directory)
-- The double slash (//) at the end makes Vim use full path in backup filenames to avoid conflicts
vim.opt.backupdir = vim.fn.stdpath('data') .. '/backup//'
-- Create the backup directory if it doesn't exist
vim.fn.mkdir(vim.fn.stdpath('data') .. '/backup', 'p')

-- Enable backup files
vim.opt.backup = true

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Use system clipboard for yank/paste operations
vim.opt.clipboard = 'unnamedplus'
