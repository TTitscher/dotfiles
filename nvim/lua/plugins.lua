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
    "echasnovski/mini.bufremove", version = false,
    config = function()
      require('mini.bufremove').setup()
    end
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      -- C++ language support via LSP (using native vim.lsp.config)
      vim.lsp.config('clangd', {
        cmd = { 'clangd', '--log=error' },
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
        pattern = {'svelte', 'svelte.ts'},
        callback = function()
          vim.lsp.enable('svelte')
        end,
      })

      -- python autocomplete
      vim.lsp.config('pyright', {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'workspace',
            },
          },
        },
      })
      vim.lsp.enable('pyright')

      -- python formatting
      vim.lsp.config('ruff', {
        cmd = { 'ruff', 'server' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
      })

      vim.lsp.enable('ruff')

      -- TypeScript/JavaScript LSP
      vim.lsp.config('ts_ls', {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
        root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayReturnTypeHints = true,
            },
          },
        },
      })

      vim.lsp.enable('ts_ls')

    end,
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',     -- LSP completions
      'hrsh7th/cmp-buffer',       -- Buffer completions
      'hrsh7th/cmp-path',         -- Path completions
      'L3MON4D3/LuaSnip',         -- Snippet engine
      'saadparwaiz1/cmp_luasnip', -- Snippet completions
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),      -- Trigger completion with Ctrl+Space
          ['<Tab>'] = cmp.mapping.select_next_item(),  -- Navigate with Tab
          ['<S-Tab>'] = cmp.mapping.select_prev_item(), -- Navigate with Shift+Tab
          ['<C-e>'] = cmp.mapping.abort(),             -- Close completion menu
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },  -- LSP completions (clangd)
          { name = 'luasnip' },   -- Snippets
          { name = 'buffer' },    -- Text from current buffer
          { name = 'path' },      -- File paths
        })
      })
    end
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        auto_install = true,
        highlight = { enable = true,
        disable = { "html", "csv", "yaml" }
      },
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

        -- passed to rg for live_grep / grep_string
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '-tcpp',
        },

        -- -- telescope-side filter, applies to find_files too
        -- file_ignore_patterns = {
        --   'build/',
        --   '%.o$',
        --   '%.a$',
        --   '%.json'
        -- },
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
{
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = function()
    require('nvim-autopairs').setup({})

    -- If you're using nvim-cmp, integrate it:
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end
},
{
  'windwp/nvim-ts-autotag',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-ts-autotag').setup({
      opts = {
        enable_close = true,          -- Auto close tags
        enable_rename = true,         -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
      },
    })
  end
},
  -- Git signs (colored lines for git changes)
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },

  -- Treesitter context
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
    -- Git conflict highlighting
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
      require("scrollbar.handlers.diagnostic").setup()
	  end,
  },
  {
    "f-person/git-blame.nvim",
    -- load the plugin at startup
    event = "VeryLazy",
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin will only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
        -- your configuration comes here
        -- for example
        enabled = true,  -- if you want to enable the plugin
        message_template = " <author> <<sha>> <date> <summary>", -- template for the blame message, check the Message template section for more options
        date_format = "%m-%d-%Y", -- template for the date, check Date format section for more options
        virtual_text_column = 1,  -- virtual text start column, check Start virtual text at column section for more options
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  {
    "frankroeder/parrot.nvim",
    dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      require("parrot").setup({
        providers = {
          ollama = {
            name = "ollama",
            endpoint = "http://ai-workstation:11434/api/chat", -- Match your host and port from Gen.nvim
            api_key = "", -- Not needed for local Ollama
            params = {
              chat = { temperature = 1.0, top_p = 1, num_ctx = 8192, min_p = 0.05 }, -- Defaults reasonable for Llama3
              command = { temperature = 1.0, top_p = 1, num_ctx = 8192, min_p = 0.05 }, -- Defaults; adjust as per preference
            },
            topic_prompt = [[
  Summarize the chat above and only provide a short headline of 2 to 3
  words without any opening phrase like "Sure, here is the summary",
  "Sure! Here's a shortheadline summarizing the chat" or anything similar.
  ]],
            topic = {
              model = "codellama:70b", -- Use your default from Gen.nvim
              params = { max_tokens = 32 },
            },
            headers = {
              ["Content-Type"] = "application/json",
            },
            models = {
              "codellama:70b", -- Your default
            },
            resolve_api_key = function()
              return true
            end,
            process_stdout = function(response)
              if response:match("message") and response:match("content") then
                local ok, data = pcall(vim.json.decode, response)
                if ok and data.message and data.message.content then
                  return data.message.content
                end
              end
            end,
            get_available_models = function(self)
              local url = self.endpoint:gsub("chat", "")
              local logger = require("parrot.logger")
              local job = Job:new({
                command = "curl",
                args = { "-H", "Content-Type: application/json", url .. "tags" },
              }):sync()
              local parsed_response = require("parrot.utils").parse_raw_response(job)
              self:process_onexit(parsed_response)
              if parsed_response == "" then
                logger.debug("Ollama server not running on " .. endpoint_api)
                return {}
              end

              local success, parsed_data = pcall(vim.json.decode, parsed_response)
              if not success then
                logger.error("Ollama - Error parsing JSON: " .. vim.inspect(parsed_data))
                return {}
              end

              if not parsed_data.models then
                logger.error("Ollama - No models found. Please use 'ollama pull' to download one.")
                return {}
              end

              local names = {}
              for _, model in ipairs(parsed_data.models) do
                table.insert(names, model.name)
              end

              return names
            end,
          },
        },
      })
    end,
  },
})

-- Show diagnostics in a floating window when you hover over an error
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end
})

-- Optional: reduce the delay before showing (default is 4000ms)
vim.opt.updatetime = 250

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})
