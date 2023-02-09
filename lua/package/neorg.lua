local ok, neorg = pcall(require, 'neorg')
if not ok then return end

neorg.setup {
  load = {
    ['core.defaults'] = {},
    ['core.export'] = {},
    ['core.norg.concealer'] = {},
    ['core.norg.completion'] = {
      config = {
        engine = 'nvim-cmp'
      }
    },
    ['core.mode'] = {},
    ['core.neorgcmd'] = {},
    ['core.highlights'] = {},
    ['core.integrations.treesitter'] = {},
    ['core.norg.dirman'] = {
      config = {
        workspaces = {
          work = '~/Norg/work',
          home = '~/Norg/home'
        }
      }
    }
  }
}

local bind = vim.keymap.set
bind('n', '<leader>n', ':Neorg<cr>')
