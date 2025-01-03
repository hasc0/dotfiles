return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- automatically install lsps and related tools to stdpath for neovim
      { 'williamboman/mason.nvim', config = true }, -- must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- status updates for lsp
      { 'j-hui/fidget.nvim', opts = {} },

      -- neodev configures lua lsp for neovim config, runtime, and plugins
      -- used for completion, annotations and signatures of neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      --  this function gets run when an lsp attaches to a particular buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- function defining lsp specific mappings
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- jump to the definition of the word under your cursor
          -- to jump back, press <C-t>
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- find references for the word under cursor
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- jump to the implementation of the word under cursor
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- jump to the type of the word under your cursor
          -- useful when you're not sure what type a variable is and you want to see
          -- the definition of its type, not where it was defined
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- fuzzy find all the symbols in your current document
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- fuzzy find all the symbols in your current workspace
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- rename the variable under your cursor
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- execute a code action, usually cursor needs to be on top of an error or a suggestion from your lsp for this to activate
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- opens a popup that displays documentation about the word under cursor
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- goto declaration
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- the following two autocommands are used to highlight references of the word under cursor when cursor rests there for a while
          -- when cursor is moved the highlights will be cleared (the second autocommand)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- the following autocommand is used to enable inlay hints in code if the language server you are using supports them
          -- this may be unwanted, since they displace some code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- lsp servers and clients are able to communicate to each other what features they support
      -- by default, neovim doesn't support everything that is in the lsp specification
      -- so, create new capabilities with nvim cmp, and then broadcast that to the servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- enable the following language servers
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},

        lua_ls = {
          -- cmd = {...},
          -- filetypes = {...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- toggle below to ignore lua_ls `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- ensure the servers and tools above are installed
      require('mason').setup()

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- this handles overriding only values explicitly passed by the server configuration above
            -- useful when disabling certain features of an lsp (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
