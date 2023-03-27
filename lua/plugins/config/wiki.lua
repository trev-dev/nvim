local g = vim.g

local function splitOnCommas(str)
  return vim.fn.split(str, '[ , ]\\+')
end

local function stripQuotes(str)
  return vim.fn.substitute(str, '\"\\|\'', '', 'g')
end

local function extractTags(str)
  return vim.fn.matchstr(str, '^tags:\\s*\\[\\zs.*\\ze]')
end

local function FrontMatterTagParser(str)
  return splitOnCommas(stripQuotes(extractTags(str)))
end

local function FrontMatterTagMatch(str)
  return not not vim.regex('^tags: \\+\\['):match_str(str)
end

local function FormatJournalTitle(isodate, path)
  local time = vim.fn.strptime('%Y-%m-%d', isodate)
  return vim.fn.strftime('%b %d', time) .. ': ' .. vim.fn['wiki#toc#get_page_title'](path)
end

local function FormatJournalLink(path)
  return vim.fn['wiki#paths#relative'](
    vim.fn['wiki#get_root']() .. path, vim.fn.expand('%:p:h')
  )
end

vim.keymap.set('n', '<leader>fwp', ':WikiPages<CR>')
vim.keymap.set('n', '<leader>fwt', ':WikiTags<CR>')

-- This plugin won't load properly without an init
return {
  init = function()
    g.wiki_root = '/home/trev/Wiki/'
    g.wiki_filetypes = {'md'}
    g.wiki_link_extension = '.md'
    g.wiki_link_target_type = 'md'
    g.wiki_tag_parsers = {
      {
        match = FrontMatterTagMatch,
        parse = FrontMatterTagParser
      }
    }
    g.wiki_journal_index = {
      link_text_parser = function(_, date, path)
        return FormatJournalTitle(date, path)
      end,
      link_url_parser = function(_, _, path)
        return FormatJournalLink(path)
      end
    }
  end
}
