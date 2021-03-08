local registry = require('lib/registry')
local bindings = require('lib/bindings')

registry.install('mhinz/vim-signify', { lazy = 'vim-signify' })
registry.install('tpope/vim-fugitive', { lazy = 'vim-fugitive' })
registry.post(function ()
  bindings.map.normal('gst', '<cmd>Gstatus<cr>')
end)
registry.install('itchyny/vim-gitbranch')
registry.install('rhysd/git-messenger.vim', { lazy = 'git-messenger.vim' })
