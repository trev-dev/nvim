local ok, buffl = pcall(require, "bufferline")
if not ok then return end

vim.keymap.set("n", "gb", ':BufferLinePick<cr>', { silent = true })

buffl.setup()
