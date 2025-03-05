dap = require("dap")

dap.set_log_level('INFO') -- Helps when configuring DAP, see logs with :DapShowLog
 
dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = function()
      -- Default to debugging an entire module, not just the open file.
      return vim.api.nvim_call_function("FindRootDirectory", {});
    end
  },
}

dap.adapters.go = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. '/mason/bin/dlv',
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

dap.configurations.java = {
  {
    type = "adb",
    name = "Debug",
    request = "launch",
    apk = function()
      return vim.api.nvim_call_function("FindRootDirectory", {}) .. "/build/outputs/apk/debug/Memoria-debug.apk";
    end,
    root = function()
      return vim.api.nvim_call_function("FindRootDirectory", {})
    end,
    source = "/"
  },
}

dap.adapters.adb = {
  type = "server",
  port = "54321",
  executable = {
    command = "true",
    args = { "run", "/home/brettk/adb-adb/*.go" },
  },
}

dapui = require("dapui")

dapui.setup()

vim.keymap.set("n", "<localleader>ds", function()
  dap.continue()
  dapui.toggle({})
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
end)

vim.keymap.set("n", "<localleader>de", function()
  dap.clear_breakpoints()
  ui.toggle({})
  dap.terminate()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
  require("notify")("Debugger session ended", "warn")
end)

vim.fn.sign_define('DapBreakpoint', { text = '🛑' })
