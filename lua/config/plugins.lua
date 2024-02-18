return {
--  ╭──────────────────────────────────────────────────────────╮
--  │ Navigation                                               │
--  ╰──────────────────────────────────────────────────────────╯
	{
		"nvim-tree/nvim-tree.lua",
		cmd = {
			"NvimTreeOpen",
			"NvimTreeClose",
			"NvimTreeToggle",
			"NvimTreeFindFile",
			"NvimTreeFindFileToggle",
		},
		keys = {
			{ "<Leader>e", "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>", desc = "NvimTree" },
		},
		config = function()
			require("plugins.tree")
		end,
	},

--  ╭──────────────────────────────────────────────────────────╮
--  │   Comment                                                │
--  ╰──────────────────────────────────────────────────────────╯
	{
		"numToStr/Comment.nvim",
		lazy = false,
		branch = "jsx",
		config = function()
			require("plugins.comment")
		end,
	},

	{ "LudoPinelli/comment-box.nvim" },

	{
		"folke/todo-comments.nvim",
		lazy = false,
		event = "BufEnter",
		config = function()
			require("plugins.todo-comments")
		end,
	},

  {
      "danymat/neogen",
      config = function()
          require('neogen').setup{
            enabled = true,             --if you want to disable Neogen
            input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
          }
      end,
      requires = "nvim-treesitter/nvim-treesitter",
      -- Uncomment next line if you want to follow only stable versions
      -- tag = "*"
  },

--  ╭──────────────────────────────────────────────────────────╮
--  │   UI                                                     │
--  ╰──────────────────────────────────────────────────────────╯
	{
		"ecosse3/galaxyline.nvim",
		config = function()
			require("plugins.galaxyline")
		end,
		event = "VeryLazy",
	},

--  ╭──────────────────────────────────────────────────────────╮
--  │ Treesitter                                               │
--  ╰──────────────────────────────────────────────────────────╯
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPre",
		config = function()
			require("plugins.treesitter")
		end,
		dependencies = {
			"mrjones2014/nvim-ts-rainbow",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"RRethy/nvim-treesitter-textsubjects",
		},
	},

--  ╭──────────────────────────────────────────────────────────╮
--  │ LSP Cmp                                                  │
--  ╰──────────────────────────────────────────────────────────╯
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("plugins.cmp")
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-calc",
			"saadparwaiz1/cmp_luasnip",
			{ "L3MON4D3/LuaSnip", dependencies = "rafamadriz/friendly-snippets" },
			{
				"David-Kunz/cmp-npm",
				config = function()
					require("plugins.cmp-npm")
				end,
			},
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
		},
	},

--  ╭──────────────────────────────────────────────────────────╮
--  │ AI                                                       │
--  ╰──────────────────────────────────────────────────────────╯
	{
		"jcdickinson/codeium.nvim",
		event = "InsertEnter",
		cmd = "Codeium",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = true,
	},

	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		config = function()
			require("plugins.copilot")
		end,
	},

--  ╭──────────────────────────────────────────────────────────╮
--  │ LSP Base                                                 │
--  ╰──────────────────────────────────────────────────────────╯
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		servers = nil,
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = {
			{ "<leader>m", "<cmd>Mason<cr>", desc = "Mason" },
		},
	},

--  ╭──────────────────────────────────────────────────────────╮
--  │ LSP Addons                                               │
--  ╰──────────────────────────────────────────────────────────╯
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		dependencies = "MunifTanjim/nui.nvim",
		config = function()
			require("plugins.dressing")
		end,
	},

	{ "onsails/lspkind-nvim" },
}
