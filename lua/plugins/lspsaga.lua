return {
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup({
      ui = {
        border = 'rounded',
      },
      lightbulb = {
        enable = true,
      },
      outline = {
        win_width = 30,
      },
    })

    local builtin = require('telescope.builtin')
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local nmap = function(modes, keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          KEYMAP.set(modes, keys, func, { buffer = ev.buf, desc = desc })
        end

        -- Diagnostic Movements
        nmap('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', 'Goto Previous [D]iagnostic Message')
        nmap('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', 'Goto Next [D]iagnostic Message')
        nmap(
          'n',
          '<leader>e',
          '<cmd>Lspsaga show_workspace_diagnostics ++float<cr>',
          'Open Diagnostics List (Floating)'
        )
        nmap('n', '<leader>q', '<cmd>Lspsaga show_workspace_diagnostics ++normal<cr>', 'Open Diagnostics List (Normal)')
        nmap('n', '<leader>o', '<cmd>Lspsaga outline<cr>', 'Open [O]utline')

        -- [[ non-Lspsaga keymaps ]]
        -- nmap('n', '[d', vim.diagnostic.goto_prev, 'Goto Previous [D]iagnostic Message')
        -- nmap('n', ']d', vim.diagnostic.goto_next, ''Goto Next [D]iagnostic Message')
        -- nmap('n', '<leader>e', vim.diagnostic.open_float, 'Open Diagnostics List (Floating)')
        -- nmap('n', '<leader>q', vim.diagnostic.setloclist, 'Open Diagnostics List (Normal)')

        -- Actions
        nmap('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('n', '<leader>prn', '<cmd>Lspsaga lsp_rename ++project<cr>', '[P]roject [R]e[n]ame')
        nmap({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<cr>', '[C]ode [A]ction')

        -- [[ non-Lspsaga keymaps ]]
        -- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- Definition/Declaration/Implementation Movements
        nmap('n', 'gd', '<cmd>Lspsaga goto_definition<cr>', '[G]oto [D]efinition')
        nmap('n', 'gtd', '<cmd>Lspsaga goto_type_definition<cr>', '[G]oto [T]ype [D]efinition')
        nmap('n', 'gr', builtin.lsp_references, '[G]oto [R]eferences')
        nmap('n', '<leader>ci', '<cmd>Lspsaga incoming_calls<cr>', '[C]alls - [I]ncoming')
        nmap('n', '<leader>co', '<cmd>Lspsaga outgoing_calls<cr>', '[C]alls - [O]utgoing')
        nmap('n', 'gI', builtin.lsp_implementations, '[G]oto [I]mplementation')

        -- [[ non-Lspsaga keymaps ]]
        -- nmap('n', 'gd', builtin.lsp_definitions, '[G]oto [D]efinition')
        -- nmap('n', 'gtd', builtin.lsp_type_definitions, '[G]oto [T]ype [D]efinition')
        -- nmap('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Symbols
        nmap('n', '<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Finder
        nmap('n', '<leader>f', '<cmd>Lspsaga finder tyd+ref+imp+def<cr>', '[F]inder')

        -- Docs
        nmap('n', 'K', '<cmd>Lspsaga hover_doc<cr>', 'Hover Documentation')

        -- [[ non-Lspsaga keymaps ]]
        -- nmap('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
        -- nmap('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Workspace
        nmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(ev.buf, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end,
    })
  end,
}
