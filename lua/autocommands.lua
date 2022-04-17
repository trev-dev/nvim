local cmd = vim.cmd

local function create_augroup(autocmds, name)
  cmd('augroup '..name)
  cmd('autocmd!')
  for _, autocmd in ipairs(autocmds) do
    cmd('autocmd '..table.concat(autocmd, ' '))
  end
  cmd('augroup END')
end

-- Untoggle relative numbers on buffer switching
create_augroup({
  {'BufEnter,FocusGained,InsertLeave', '*', 'set', 'relativenumber'},
  {'BufLeave,FocusLost,InsertEnter', '*', 'set', 'norelativenumber'}
}, 'numbertoggle')

-- File specific indentation
cmd('autocmd Filetype python setlocal ts=4 sw=4 sts=0 expandtab')
