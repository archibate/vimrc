local overseer = require("overseer")

overseer.setup{
    templates = { "builtin", "user.cpp_build", "user.run_script" },
    strategy = {
        "toggleterm",
        -- load your default shell before starting the task
        use_shell = false,
        -- overwrite the default toggleterm "direction" parameter
        direction = nil,
        -- overwrite the default toggleterm "highlights" parameter
        highlights = nil,
        -- overwrite the default toggleterm "auto_scroll" parameter
        auto_scroll = nil,
        -- have the toggleterm window close and delete the terminal buffer
        -- automatically after the task exits
        close_on_exit = false,
        -- have the toggleterm window close without deleting the terminal buffer
        -- automatically after the task exits
        -- can be "never, "success", or "always". "success" will close the window
        -- only if the exit code is 0.
        quit_on_exit = "never",
        -- open the toggleterm window when a task starts
        open_on_start = true,
        -- mirrors the toggleterm "hidden" parameter, and keeps the task from
        -- being rendered in the toggleable window
        hidden = false,
        -- command to run when the terminal is created. Combine with `use_shell`
        -- to run a terminal command before starting the task
        on_create = nil,
    }
}

vim.api.nvim_create_user_command("WatchRun", function()
  overseer.run_template({ name = "run script" }, function(task)
    if task then
      task:add_component({ "restart_on_save", paths = {vim.fn.expand("%:p")} })
      local main_win = vim.api.nvim_get_current_win()
      overseer.run_action(task, "open")
      vim.api.nvim_set_current_win(main_win)
    else
      vim.notify("WatchRun not supported for filetype " .. vim.bo.filetype, vim.log.levels.ERROR)
    end
  end)
end, {})

vim.api.nvim_create_user_command("Grep", function(params)
  -- Insert args at the '$*' in the grepprg
  local cmd, num_subs = vim.o.grepprg:gsub("%$%*", params.args)
  if num_subs == 0 then
    cmd = cmd .. " " .. params.args
  end
  local task = overseer.new_task({
    cmd = vim.fn.expandcmd(cmd),
    components = {
      {
        "on_output_quickfix",
        errorformat = vim.o.grepformat,
        open = not params.bang,
        open_height = 8,
        items_only = true,
      },
      -- We don't care to keep this around as long as most tasks
      { "on_complete_dispose", timeout = 30 },
      "default",
    },
  })
  task:start()
end, { nargs = "*", bang = true, complete = "file" })

vim.api.nvim_create_user_command("Make", function(params)
  -- Insert args at the '$*' in the makeprg
  local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
  if num_subs == 0 then
    cmd = cmd .. " " .. params.args
  end
  local task = require("overseer").new_task({
    cmd = vim.fn.expandcmd(cmd),
    components = {
      { "on_output_quickfix", open = not params.bang, open_height = 8 },
      "default",
    },
  })
  task:start()
end, {
  desc = "Run your makeprg as an Overseer task",
  nargs = "*",
  bang = true,
})

vim.api.nvim_create_user_command("OverseerRestartLast", function()
  local tasks = overseer.list_tasks({ recent_first = true })
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "restart")
  end
end, {})
