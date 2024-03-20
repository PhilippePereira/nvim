return {
	"andythigpen/nvim-coverage",
	dependencies = "nvim-lua/plenary.nvim",
	cmd = {
		"Coverage",
		"CoverageSummary",
		"CoverageLoad",
		"CoverageShow",
		"CoverageHide",
		"CoverageToggle",
		"CoverageClear",
	},
	config = function()
		require("coverage").setup()
	end,
}
