local ok, hop = pcall(require, "hop")
if not ok then return end

vim.keymap.set("n", "<leader>s", ":HopChar1<cr>", { silent = true })

hop.setup({ keys = "etovxqpdygfblzhckisuran", case_insensitive = false })
