local packer = require('packer')
packer.startup({
  function(use)
    -- packer pack manager
    use 'wbthomason/packer.nvim'
    ---------------- Plugins ------------------
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }})
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
    use("arkav/lualine-lsp-progress")
    use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }
    use("glepnir/dashboard-nvim")
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    -- 补全
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/vim-vsnip")
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }

    use("rafamadriz/friendly-snippets")
    ---------------- LSP -----------------
    use({ "neovim/nvim-lspconfig" })
    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })
    -------------- Colorshemes ----------------
    use('folke/tokyonight.nvim')
    use('mhartington/oceanic-next')
    use { "ellisonleao/gruvbox.nvim" }
    -------------------------------------------
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end,
    },
  }
})

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])
