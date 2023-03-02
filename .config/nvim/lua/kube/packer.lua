vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use("folke/tokyonight.nvim")

	-- Fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
			},
			{ "nvim-telescope/telescope-file-browser.nvim" },
		},
	})

	-- Buffer handling
	use({
		"crispgm/nvim-tabline",
		config = function()
			require("tabline").setup({})
		end,
	})

	-- Bar
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use("tpope/vim-commentary")

	use("github/copilot.vim")

	-- Auto complete
	use({
		"williamboman/mason.nvim",
		requires = {
			-- LSP
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Snippet
			{ "hrsh7th/cmp-vsnip" },
			{ "hrsh7th/vim-vsnip" },

			-- AutoComplete
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "glepnir/lspsaga.nvim", branch = "main" },
		},
	})
	use("jose-elias-alvarez/null-ls.nvim")
	use({ "nvim-treesitter/nvim-treesitter" })
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("windwp/nvim-ts-autotag")

	-- Code Actions
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	-- Git
	use("lewis6991/gitsigns.nvim")
end)
