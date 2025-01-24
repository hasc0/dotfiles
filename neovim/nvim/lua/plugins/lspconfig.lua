return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true }, -- must load first
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- lsp status
      { 'j-hui/fidget.nvim', opts = {} },

      -- configures lua lsp for neovim config, runtime, and plugins
      -- used for completion, annotations and signatures of neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },

    config = function()
      -- this function gets run when an lsp attaches to a particular buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- function defining lsp specific mappings
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- jump to the definition of the word under your cursor
          -- to jump back, press <C-t>
          map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')

          -- find references for the word under cursor
          map('gr', require('telescope.builtin').lsp_references, 'Goto References')

          -- jump to the implementation of the word under cursor
          map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')

          -- jump to the type of the word under your cursor
          -- useful when you're not sure what type a variable is and you want to see the definition of its type, not where it was defined
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type Definition')

          -- fuzzy find all the symbols in your current document
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')

          -- fuzzy find all the symbols in your current workspace
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

          -- rename the variable under your cursor
          map('<leader>rn', vim.lsp.buf.rename, 'Rename')

          -- execute a code action, usually cursor needs to be on top of an error or a suggestion from your lsp for this to activate
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

          -- opens a popup that displays documentation about the word under cursor
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- goto declaration
          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

          -- the following two autocommands are used to highlight references of the word under cursor when cursor rests there for a while
          -- when cursor is moved the highlights will be cleared (the second autocommand)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
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
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- the following autocommand is used to enable inlay hints in code if the language server you are using supports them
          -- this may be unwanted, since they displace some code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, 'Toggle Inlay Hints')
          end
        end,
      })

      -- lsp servers and clients are able to communicate to each other what features they support
      -- by default, neovim doesn't support everything that is in the lsp specification
      -- so, create new capabilities with nvim cmp, and then broadcast that to the servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- configurations for certain lsps
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },

              diagnostics = {
                disable = { 'missing-fields' },
              },
            },
          },
        },

        -- ocaml-lsp-server will not work properly unless configured here and installed via mason
        ocamllsp = {
          cmd = { 'ocamllsp' },
          filetypes = { 'ocaml', 'ocaml.menhir', 'ocaml.interface', 'ocaml.ocamllex', 'reason', 'dune' },
          root_dir = function(fname)
            return require('lspconfig.util').root_pattern(
              '*.opam',
              'esy.json',
              'package.json',
              '.git',
              'dune-project',
              'dune-workspace',
              '*.ml'
            )(fname)
          end,
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
