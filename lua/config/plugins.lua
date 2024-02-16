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
}
