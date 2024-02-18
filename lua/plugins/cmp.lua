local lspkind = require("lspkind")
local types = require("cmp.types")
local icons = require("utils.icons")

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

-- ╭──────────────────────────────────────────────────────────╮
-- │ Utils                                                    │
-- ╰──────────────────────────────────────────────────────────╯
local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local function deprioritize_snippet(entry1, entry2)
  if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return false
  end
  if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return true
  end
end

local function limit_lsp_types(entry, ctx)
  local kind = entry:get_kind()
  local line = ctx.cursor.line
  local col = ctx.cursor.col
  local char_before_cursor = string.sub(line, col - 1, col - 1)
  local char_after_dot = string.sub(line, col, col)

  if char_before_cursor == "." and char_after_dot:match("[a-zA-Z]") then
    if
        kind == types.lsp.CompletionItemKind.Method
        or kind == types.lsp.CompletionItemKind.Field
        or kind == types.lsp.CompletionItemKind.Property
    then
      return true
    else
      return false
    end
  elseif string.match(line, "^%s+%w+$") then
    if kind == types.lsp.CompletionItemKind.Function or kind == types.lsp.CompletionItemKind.Variable then
      return true
    else
      return false
    end
  end

  return true
end

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup                                                    │
-- ╰──────────────────────────────────────────────────────────╯
local source_mapping = {
  npm = icons.terminal .. "NPM",
  cmp_tabnine = icons.light,
  Copilot = icons.copilot,
  Codeium = icons.codeium,
  nvim_lsp = icons.paragraph .. "LSP",
  buffer = icons.buffer .. "BUF",
  nvim_lua = icons.bomb,
  luasnip = icons.snippet .. "SNP",
  calc = icons.calculator,
  path = icons.folderOpen2,
  treesitter = icons.tree,
  zsh = icons.terminal .. "ZSH",
}

local buffer_option = {
  -- Complete from all visible buffers (splits)
  get_bufnrs = function()
    local bufs = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      bufs[vim.api.nvim_win_get_buf(win)] = true
    end
    return vim.tbl_keys(bufs)
  end,
}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({
      -- this is the important line for Copilot
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<C-l>"] = cmp.mapping(function(fallback)
      if luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<C-h>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Set the highlight group for the Codeium source
      if entry.source.name == "codeium" then
        vim_item.kind_hl_group = "CmpItemKindCopilot"
      end

      -- Get the item with kind from the lspkind plugin
      local item_with_kind = require("lspkind").cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        symbol_map = source_mapping,
      })(entry, vim_item)

      item_with_kind.kind = lspkind.symbolic(item_with_kind.kind, { with_text = true })
      item_with_kind.menu = source_mapping[entry.source.name]
      item_with_kind.menu = vim.trim(item_with_kind.menu or "")
      item_with_kind.abbr = string.sub(item_with_kind.abbr, 1, item_with_kind.maxwidth)

      if entry.source.name == "cmp_tabnine" then
        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
          item_with_kind.kind = " " .. lspkind.symbolic("Event", { with_text = false }) .. " TabNine"
          item_with_kind.menu = item_with_kind.menu .. entry.completion_item.data.detail
        else
          item_with_kind.kind = " " .. lspkind.symbolic("Event", { with_text = false }) .. " TabNine"
          item_with_kind.menu = item_with_kind.menu .. " TBN"
        end
      end

      local completion_context = get_lsp_completion_context(entry.completion_item, entry.source)
      if completion_context ~= nil and completion_context ~= "" then
        item_with_kind.menu = item_with_kind.menu .. [[ -> ]] .. completion_context
      end

      return item_with_kind
    end,
  },
  -- You should specify your *installed* sources.
  sources = {
    {
      name = "nvim_lsp",
      priority = 10,
      -- Limits LSP results to specific types based on line context (FIelds, Methods, Variables)
      entry_filter = limit_lsp_types,
    },
    { name = "npm",         priority = 9 },
    { name = "codeium",     priority = 9 },
    { name = "copilot",     priority = 9 },
    { name = "luasnip",     priority = 7, max_item_count = 5 },
    { name = "buffer",      priority = 7, keyword_length = 5, option = buffer_option, max_item_count = 5 },
    { name = "nvim_lua",    priority = 5 },
    { name = "path",        priority = 4 },
    { name = "calc",        priority = 3 },
  },
  sorting = {
    comparators = {
      deprioritize_snippet,
      cmp.config.compare.exact,
      cmp.config.compare.locality,
      require("copilot_cmp.comparators").prioritize,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.offset,
      cmp.config.compare.sort_text,
      cmp.config.compare.order,
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered({
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    }),
  },
  experimental = {
    ghost_text = true,
  },
})

