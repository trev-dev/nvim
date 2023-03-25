local g = vim.g

-- This plugin won't load properly without an init
local init_func = function()
  g.wiki_root = "/home/trev/Wiki/"
  g.wiki_filetypes = {"md"}
  g.wiki_link_extension = ".md"
  g.wiki_link_target_type = "md"
end

vim.cmd [[
func s:frontMatterTagParser(str)
  return a:str
    \ ->substitute('"\|''', '', 'g')
    \ ->matchstr('^tags:\s*\[\zs.*\ze]')
    \ ->split('[ , ]\+')
endfunc

let g:wiki_tag_parsers = [{ 'match': { x -> x =~# '^tags: \+[' },
                         \  'parse': { x -> s:frontMatterTagParser(x) }}]

func s:formatJournalTitle(isodate, path)
  let l:time = strptime("%Y-%m-%d", a:isodate)
  return strftime("%b %d", l:time) . ": " . wiki#toc#get_page_title(a:path)
endfunc

func s:formatJournalLink(path)
  return wiki#paths#relative(wiki#get_root() . a:path, expand('#:p:h'))
endfunc

let g:wiki_journal_index = {
      \ 'link_text_parser': {_basename, date, path -> s:formatJournalTitle(date, path)},
      \ 'link_url_parser': {_basename, _date, path -> s:formatJournalLink(path)} }
]]

vim.keymap.set("n", "<leader>fwp", ":WikiPages<CR>")
vim.keymap.set("n", "<leader>fwt", ":WikiTags<CR>")

return {
  init = init_func
}
