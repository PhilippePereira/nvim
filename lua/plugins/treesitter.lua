require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "tsx",
    "typescript",
    "javascript",
    "html",
    "css",
    "vue",
    "astro",
    "svelte",
    "gitcommit",
    "graphql",
    "json",
    "json5",
    "lua",
    "markdown",
    "prisma",
    "python",
  },          -- one of "all", or a list of languages
  sync_install = false,           -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "haskell" }, -- list of parsers to ignore installing
  highlight = {
    enable = true,
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection    = "<Leader>ss",
      node_incremental  = "<Leader>si",
      scope_incremental = "<Leader>sc",
      node_decremental  = "<Leader>sd",
    },
  },

  indent = {
    enable = true
  },

  rainbow = {
    enable = true,
    extended_mode = true,
 },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
