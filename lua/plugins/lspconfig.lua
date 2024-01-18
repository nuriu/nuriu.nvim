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
        'markdownlint',
        'prettierd',
        'omnisharp',
        'clangd',
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

    lspconfig.omnisharp.setup({
      capabilities = capabilities,

      cmd = { 'omnisharp' },

      -- Enables support for reading code style, naming convention and analyzer
      -- settings from .editorconfig.
      enable_editorconfig_support = true,

      -- If true, MSBuild project system will only load projects for files that
      -- were opened in the editor. This setting is useful for big C# codebases
      -- and allows for faster initialization of code navigation features only
      -- for projects that are relevant to code that is being edited. With this
      -- setting enabled OmniSharp may load fewer projects and may thus display
      -- incomplete reference lists for symbols.
      enable_ms_build_load_projects_on_demand = false,

      -- Enables support for roslyn analyzers, code fixes and rulesets.
      enable_roslyn_analyzers = true,

      -- Specifies whether 'using' directives should be grouped and sorted during
      -- document formatting.
      organize_imports_on_format = true,

      -- Enables support for showing unimported types and unimported extension
      -- methods in completion lists. When committed, the appropriate using
      -- directive will be added at the top of the current file. This option can
      -- have a negative impact on initial completion responsiveness,
      -- particularly for the first few completion sessions after opening a
      -- solution.
      enable_import_completion = false,

      -- Specifies whether to include preview versions of the .NET SDK when
      -- determining which version to use for project loading.
      sdk_include_prereleases = false,

      -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
      -- true
      analyze_open_documents_only = true,
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
