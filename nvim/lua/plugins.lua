-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require("lazy").setup({
  -- OneDark color scheme
  {
    "navarasu/onedark.nvim",
    config = function()
      require('onedark').setup({
        style = 'dark' -- Options: dark, darker, cool, deep, warm, warmer
      })
      require('onedark').load()
    end
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      -- C++ language support via LSP (using native vim.lsp.config)
      vim.lsp.config('clangd', {
        cmd = { 'clangd' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' },
      })

      -- Enable the LSP for C++ files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'c', 'cpp' },
        callback = function()
          vim.lsp.enable('clangd')
        end,
      })


      -- Svelte LSP
      vim.lsp.config('svelte', {
        cmd = { 'svelteserver', '--stdio' },
        filetypes = { 'svelte' },
        root_markers = { 'package.json', '.git' },
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'svelte',
        callback = function()
          vim.lsp.enable('svelte')
        end,
      })

      -- Lua LSP (especially useful for Neovim config)
      vim.lsp.config('lua_ls', {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT', -- Neovim uses LuaJIT
            },
            diagnostics = {
              globals = { 'vim' }, -- Recognize 'vim' as a global
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true), -- Make LSP aware of Neovim runtime files
              checkThirdParty = false, -- Don't prompt about third-party tools
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'lua',
        callback = function()
          vim.lsp.enable('lua_ls')
        end,
      })
    end
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "cpp", "c", "lua", "svelte", "javascript", "typescript", "html", "css" },
        auto_install = true,
        highlight = { enable = true },
      })
    end
  },

  -- Telescope for fuzzy finding
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')

      telescope.setup({
        defaults = {
          layout_strategy = 'horizontal',
          layout_config = {
            prompt_position = 'top',
          },
          sorting_strategy = 'ascending',
        },
      })

    end,
  },

  -- File explorer sidebar
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- Optional: for file icons
    },
    config = function()
      -- Disable netrw (Vim's built-in file explorer) as recommended by nvim-tree
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require('nvim-tree').setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false, -- Show hidden files
        },
        git = {
          enable = true,
          ignore = false,
        },
      })
    end,
  },

  -- Buffer line (tabs for open buffers)
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup({
        options = {
          mode = "buffers", -- Show buffers instead of tabs
          numbers = "ordinal", -- Show buffer numbers (1, 2, 3...)
          close_command = "bdelete! %d", -- Command to close buffer
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator = {
            style = 'icon',
            icon = '▎',
          },
          buffer_close_icon = '󰅖',
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          diagnostics = "nvim_lsp", -- Show LSP diagnostics in buffer tabs
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            }
          },
          separator_style = "slant", -- Options: "slant", "thick", "thin", "padded_slant"
          show_buffer_close_icons = true,
          show_close_icon = false,
          show_tab_indicators = true,
          persist_buffer_sort = true,
          always_show_bufferline = true,
        },
      })
    end,
  },


})
