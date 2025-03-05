require("mason").setup()
require("mason-lspconfig").setup()

local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "nvim_lsp_signature_help" }
  }),
  window = {
    completion = {
      border = "rounded",
      winhighlight = "Normal:CmpNormal",
    },
    documentation = {
      border = "rounded",
      winhighlight = "Normal:CmpNormal",
    }
  },
  enabled = function()
    local in_prompt = vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' 

    if in_prompt then -- this will disable cmp in the Telescope window (taken from the default config) 
      return false 
    end

    local context = require("cmp.config.context")

    return not(context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment")) 
  end
});

cmp.setup.filetype('vimwiki', {
  sources = cmp.config.sources({
    { name = "nvim_lsp" }
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup_handlers {
  function (server_name)
    require("lspconfig")[server_name].setup {
        capabilities = capabilities
    }
  end
}

require("telescope").setup()
require("telescope").load_extension('fzf')

require("lspconfig").solargraph.setup {
  capabilities = capabilities,
  settings = {
    solargraph = {
      completion = true,
      formatting = true,
      symbols = true,
      definitions = true,
      references = true,
      folding = true,
      highlights = true,
      diagnostics = true,
      rename = true,
      hover=true
    }
  }
}

