local M = {}

function M.cli_run(jobs)
  local config_job
  local n_threads
  local runnable_jobs = vim.iter(jobs):filter(function(job)
    return type(job.command) == "table" and #job.command > 0 and #job.err == 0
  end)
  local n_total, id_started, n_finished = #jobs, 0, 0
  if n_total == 0 then return end
  local run_next = function()
    if n_total <= id_started then
      return
    end
    id_started = id_started + 1
    local job = jobs[id_started]

    local command, cwd, exit_msg = job.command or {}, job.cwd, job.exit_msg

    -- Prepare data for `vim.loop.spawn`
    local executable, args = command[1], vim.list_slice(command, 2, #command)
    local process, stdout, stderr = nil, vim.loop.new_pipe(), vim.loop.new_pipe()
    local spawn_opts = { args = args, cwd = cwd, stdio = { nil, stdout, stderr } }
  end
end


function M.run_jobs()
end

return M
