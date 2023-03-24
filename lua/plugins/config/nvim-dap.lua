local dapui = require("dapui")
local dap = require ("dap")

dapui.setup {
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        -- "stacks",
        -- "watches",
      },
      size = 40, -- 40 columns
      position = "right",
    },
    {
      elements = {
        "console",
        "repl"
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    }
  },
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = '',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = 'ﮤ'
    }
  }
}

vim.fn.sign_define("DapBreakpoint", {
  text = "", texthl = "DiagnosticSignError", linehl = "", numhl = ""
})

local log_point = function()
  dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end

local wkp, wk = pcall(require, "which-key")
if wkp then
  wk.register {d = {name = "Debug"}, prefix = "<leader>"}
end

local bind = vim.keymap.set
bind('n', '<F5>', dap.continue)
bind('n', '<F10>', dap.step_over)
bind('n', '<F11>', dap.step_into)
bind('n', '<F12>', dap.step_out)
bind('n', '<leader>db', dap.toggle_breakpoint, { desc = "toggle breakpoint" })
bind('n', '<leader>dB', dap.set_breakpoint, { desc = "set breakpoint" })
bind('n', '<leader>dp', log_point, { desc = "log point message" })
bind('n', '<leader>dr', dap.repl.open, { desc = "open repl" })
bind('n', '<leader>dl', dap.run_last, { desc = "run last" })
bind({'v', 'n'}, '<leader>dh', dapui.eval, { desc = "eval cursor/selection" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
