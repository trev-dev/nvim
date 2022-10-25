local ok, tdc = pcall(require, "todo-comments")
if not ok then return end

tdc.setup()
