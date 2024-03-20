return {
	"charludo/projectmgr.nvim",
	lazy = false, -- important!
	config = function()
		local project = require("projectmgr")

		project.setup({
			autogit = {
				enabled = false,
				command = "git pull --ff-only",
			},
			reopen = false,
			session = { enabled = true, file = "Session.vim" },
			shada = { enabled = false, file = "main.shada" },
			scripts = {
				enabled = true,
				file_startup = "startup.sh",
				file_shutdown = "shutdown.sh",
			},
		})

		vim.api.nvim_set_keymap("n", "<leader>p", ":ProjectMgr<CR>", {})
	end,
}
