return {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- Optional
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    config = function()
      require("mason-lspconfig").setup()
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Import the lspconfig module
      local lspconfig = require('lspconfig')

      -- Function to attach common settings and keybindings to LSP servers
      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
				--       vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
	vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

        -- Set some keybindings conditional on server capabilities
        if client.server_capabilities.document_formatting then
          buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        elseif client.server_capabilities.document_range_formatting then
          buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
        end
      end

      -- Configure the Pyright language server
      lspconfig.pyright.setup{
        on_attach = on_attach,
      }
    end
}
