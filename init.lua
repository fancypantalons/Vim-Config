-- Install our package manager if it's not already here. Just like my old vim
-- config, this assumes git is installed on the local system.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Load plugin configuration variables that need to be set before loading

local vimrc = vim.fn.stdpath("config") .. "/options.vim"
vim.cmd.source(vimrc) 

-- Now initialize the plugin manager

require("lazy").setup({
  "nvim-neotest/nvim-nio",
  "airblade/vim-rooter",
  "airblade/vim-gitgutter",
  "bling/vim-airline",
  "vim-airline/vim-airline-themes",
  "nvim-tree/nvim-web-devicons",
  "msanders/snipmate.vim",
--  "scrooloose/nerdtree",
--  "Xuyuanp/nerdtree-git-plugin",
  "nvim-tree/nvim-tree.lua",
  "vimwiki/vimwiki",
  "junegunn/goyo.vim",
  "junegunn/limelight.vim",
  "reedes/vim-pencil",
  "famiu/bufdelete.nvim",
  "plasticboy/vim-markdown",
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/nvim-cmp",
  "hrsh7th/vim-vsnip",
  "embear/vim-localvimrc",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "lua", "vim", "vimdoc", "markdown", "ruby", "java", "python", "perl", "html", "css", "bash" },
        sync_install = false,
        highlight = { 
          additional_vim_regex_highlighting = { "ruby" },
          enable = true 
        },
        indent = { 
          enable = true,
          disable = { "ruby" }
        }
      })
    end
  },
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.4",
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 
    "nvim-telescope/telescope-fzf-native.nvim", 
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" 
  },
  "mfussenegger/nvim-jdtls",
--  "hdiniz/vim-gradle", -- Seems to be incompatible with Diffview?
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  {
    "hedyhli/outline.nvim",
    config = function()
      -- Example mapping to toggle outline
      vim.keymap.set("n", "<leader>V", "<cmd>Outline<CR>",
        { desc = "Toggle Outline" })

      require("outline").setup {
        outline_window = {
          position = 'left',
          width = 15
        }
      }
    end,
  },
  "ribelo/taskwarrior.nvim",
  "tools-life/taskwiki",
  "sindrets/diffview.nvim",
  "tpope/vim-fugitive"
})

require('lsp')
require('debugging')
require('nvim-tree-setup')

-- Set our colour scheme, which I've been using for many many years now and is
-- somewhat customized.

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc) 
