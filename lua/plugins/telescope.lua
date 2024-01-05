require('globals')

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    local actions = require('telescope.actions')
    local builtin = require('telescope.builtin')

    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['esc'] = actions.close,
          },
        },
        file_ignore_patterns = {
          '.git',
          'lazy-lock.json',
          'node_modules',
          '%.lock',
        },
      },
    })

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

    -- Telescope live_grep in git root
    -- Function to find the git root directory based on the current buffer's path
    local function find_git_root()
      -- Use the current buffer's path as the starting point for the git search
      local current_file = vim.api.nvim_buf_get_name(0)
      local current_dir
      local cwd = vim.fn.getcwd()
      -- If the buffer is not associated with a file, return nil
      if current_file == '' then
        current_dir = cwd
      else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ':h')
      end

      -- Find the Git root directory from the current file's path
      local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')
          [1]
      if vim.v.shell_error ~= 0 then
        print('Not a git repository. Searching on current working directory')
        return cwd
      end
      return git_root
    end

    -- Custom live_grep function to search in git root
    local function live_grep_git_root()
      local git_root = find_git_root()
      if git_root then
        require('telescope.builtin').live_grep({
          search_dirs = { git_root },
        })
      end
    end

    vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
    KEYMAP.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })

    -- See `:help telescope.builtin`
    local function telescope_live_grep_open_files()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      })
    end
    KEYMAP.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })

    local function telescope_local_buffer_fuzzy_find()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end
    KEYMAP.set('n', '<leader>/', telescope_local_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })

    KEYMAP.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    KEYMAP.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    KEYMAP.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    KEYMAP.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
    KEYMAP.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    KEYMAP.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    KEYMAP.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    KEYMAP.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    KEYMAP.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    KEYMAP.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  end
}
