-- Fast build && run keybinding
vim.keymap.set('n', '<M-b>', function()
  vim.cmd('write')  -- Save the file first
  quick_build()
end, { desc = 'Quick build and run' })

-- Quick build and run function with improvements
local function quick_build()
  local filetype = vim.bo.filetype
  
  -- Save file before building (no need for separate keymap step)
  vim.cmd('write')
  
  -- Use a more maintainable table-based approach
  local build_commands = {
    cpp = function()
      if vim.fn.filereadable("Makefile") == 1 then
        local target = vim.fn.expand("%:t:r")
        return string.format("make %s && ./%s", target, target)
      else
        return "clang++ -std=c++17 -pthread % && ./a.out"
      end
    end,
    
    c = function()
      return "gcc % && ./a.out"
    end,
    
    python = function()
      return "python3 %"
    end,
    
    markdown = function()
      return "pandoc % --standalone --toc --mathjax --css ~/dotfiles/style.css --filter=mermaid-filter -o %<.html"
    end,
  }
  
  local command_fn = build_commands[filetype]
  
  if command_fn then
    local cmd = command_fn()
    
    -- Use vim.fn.system() or jobstart() for better error handling and output
    -- Option 1: Simple blocking execution
    vim.cmd("!" .. cmd)
    
    -- Option 2: Async with better output (commented out, use if preferred)
    -- vim.fn.jobstart(cmd, {
    --   on_exit = function(_, exit_code)
    --     if exit_code == 0 then
    --       vim.notify("Build successful!", vim.log.levels.INFO)
    --     else
    --       vim.notify("Build failed with code: " .. exit_code, vim.log.levels.ERROR)
    --     end
    --   end,
    -- })
  else
    vim.notify("No build command configured for filetype: " .. filetype, vim.log.levels.WARN)
  end
end

-- Fast build && run keybinding
vim.keymap.set('n', '<M-b>', quick_build, { desc = 'Quick build and run' })
