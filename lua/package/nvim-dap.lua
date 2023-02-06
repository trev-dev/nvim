local dap_status_ok, dap = pcall(require, "dap")
local dapui_status_ok, dapui = pcall(require, "dapui")
if not dap_status_ok and not dapui_status_ok then return end

dapui.setup {
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Use this to override mappings for specific elements
  element_mappings = {
    -- Example:
    -- stacks = {
    --   open = "<CR>",
    --   expand = "o",
    -- }
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
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
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
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
