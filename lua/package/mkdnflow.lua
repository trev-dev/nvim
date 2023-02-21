local ok, mdf = pcall(require, "mkdnflow")
if not ok then return end

mdf.setup({
  filetypes = {md = true, markdown = true, org = true},
  mappings = {
    MkdnNewListItem = {'i', '<CR>'},
    MkdnYankAnchorLink = {'n', 'yl'},
    MkdnYankFileAnchorLink = {'n', 'yfl'},
  }
})
