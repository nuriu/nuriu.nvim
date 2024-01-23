require('globals')

return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
  config = function()
    -- [[ Diagnostic icons ]]
    vim.fn.sign_define({
      {
        name = 'DiagnosticSignError',
        text = ICONS.error,
        texthl = 'DiagnosticSignError',
        linehl = 'ErrorLine',
      },
      {
        name = 'DiagnosticSignWarn',
        text = ICONS.warning,
        texthl = 'DiagnosticSignWarn',
        linehl = 'WarningLine',
      },
      {
        name = 'DiagnosticSignInfo',
        text = ICONS.info,
        texthl = 'DiagnosticSignInfo',
        linehl = 'InfoLine',
      },
      {
        name = 'DiagnosticSignHint',
        text = ICONS.hint,
        texthl = 'DiagnosticSignHint',
        linehl = 'HintLine',
      },
    })

    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers. (mason -> mason-lspconfig -> mason-tool-installer)
    require('mason').setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })

    require('mason-lspconfig').setup({})

    require('mason-tool-installer').setup({
      ensure_installed = {
        'vim-language-server',
        'stylua',
        'lua_ls',
        'markdownlint-cli2',
        'yaml-language-server',
        'prettierd',
        'html-lsp',
        'json-lsp',
        'omnisharp',
        'clangd',
        'goimports-reviser',
        'golines',
        'gopls',
        'rust-analyzer',
      },
    })

    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local lspconfig = require('lspconfig')

    -- [[ SERVERS ]]
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          semantic = { enable = false },
          hint = { enable = true },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          diagnostics = {
            globals = { 'vim' },
            disable = { 'missing-fields' },
          },
        },
      },
    })
    -- JSON
    lspconfig.jsonls.setup({})

    -- HTML
    lspconfig.html.setup({})

    -- YAML
    lspconfig.yamlls.setup({})

    lspconfig.omnisharp.setup({
      capabilities = capabilities,
      cmd = { 'omnisharp' },
      -- enable_roslyn_analysers = true,
      enable_import_completion = true,
      organize_imports_on_format = true,
      filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props' },
    })

    lspconfig.clangd.setup({
      capabilities = capabilities,
      cmd = {
        'clangd',
        -- "--all-scopes-completion",
        -- "--suggest-missing-includes",
        -- "--background-index",
        -- "--pch-storage=disk",
        -- "--cross-file-rename",
        -- "--log=info",
        -- "--completion-style=detailed",
        -- "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
        -- "--clang-tidy",
        '--offset-encoding=utf-16',
        -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
        -- "--fallback-style=Google",
        -- "--header-insertion=never",
        -- "--query-driver=<list-of-white-listed-complers>"
      },
    })

    lspconfig.gopls.setup({
      capabilities = capabilities,
      settings = {
        gopls = {
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    })

    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
    })
  end,
}
