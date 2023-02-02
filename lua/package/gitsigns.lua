local ok, gitsigns = pcall(require, "gitsigns")
if not ok then return end

gitsigns.setup {
  on_attach = function(buff)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    local wkp, wk = pcall(require, "which-key")
    if wkp then
      wk.register {h = {name = "Hunk"}, prefix = "<leader>"}
      wk.register {t = {name = "Toggle"}, prefix = "<leader>"}
    end

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer, { desc = "stage buffer" })
    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "undo stage hunk" })
    map('n', '<leader>hR', gs.reset_buffer, { desc = "reset buffer" })
    map('n', '<leader>hp', gs.preview_hunk, { desc = "preview hunk" })
    map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "blame line" })
    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "toggle line blame" })
    map('n', '<leader>hd', gs.diffthis, { desc = "diff this" })
    map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "diff this ~" })
    map('n', '<leader>td', gs.toggle_deleted, { desc = "toggle deleted" })

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "inside hunk" })
  end
}
