vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Don't show the dumb matching stuff.
vim.opt.shortmess:append "c"

-- Complextras.nvim configuration
vim.api.nvim_set_keymap(
  "i",
  "<C-x><C-m>",
  [[<c-r>=luaeval("require('complextras').complete_matching_line()")<CR>]],
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<C-x><C-d>",
  [[<c-r>=luaeval("require('complextras').complete_line_from_cwd()")<CR>]],
  { noremap = true }
)

local ok, lspkind = pcall(require, "lspkind")
if not ok then
  return
end

lspkind.init()

-- require('copilot').setup({
--   panel = {
--     enabled = true,
--     auto_refresh = false,
--     keymap = {
--       jump_prev = "<C-n>",
--       jump_next = "<C-p>",
--       accept = "<C-y>",
--       refresh = "gr",
--       open = "<leader>go"
--     },
--   },
--   preview = {
--     enabled = true,
--     keymap = {
--       jump_prev = "[[",
--       jump_next = "]]",
--       accept = "<CR>",
--       refresh = "gr",
--       open = "<leader>go"
--     },
--   },
--   suggestion = {
--     enabled = true,
--     auto_trigger = true,
--     debounce = 75,
--     keymap = {
--      accept = "<C-y>",
--      next = "<leader>n",
--      prev = "<leader>p",
--      dismiss = "<C-space>",
--     },
--   },
--   filetypes = {
--     yaml = false,
--     markdown = false,
--     help = false,
--     gitcommit = false,
--     gitrebase = false,
--     hgcommit = false,
--     svn = false,
--     cvs = false,
--     ["."] = false,
--   },
--   copilot_node_command = 'node', -- Node version must be < 18
--   plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
--   server_opts_overrides = {},
-- })

-- Not Currently Recommended

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end


-- clean code and better performance 
-- local ok, _G

local cmp = require "cmp"

cmp.setup {
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item {},
    ["<C-p>"] = cmp.mapping.select_prev_item {},
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-q>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),

    -- ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-Space>"] = cmp.mapping {
      i = cmp.mapping.complete(),
      c = function(
        _ --[[fallback]]
      )
        if cmp.visible() then
          if not cmp.confirm { select = true } then
            return
          end
        else
          cmp.complete()
        end
      end,
    },

    -- ["<tab>"] = false,
    ["<tab>"] = cmp.config.disable,

    -- ["<tab>"] = cmp.mapping {
    --   i = cmp.config.disable,
    --   c = function(fallback)
    --     fallback()
    --   end,
    -- },

    -- Testing
    ["<leader>gq"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    -- If you want tab completion :'(
    --  First you have to just promise to read `:help ins-completion`.
    --
    -- ["<Tab>"] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   else
    --     fallback()
    --   end
    -- end,
    -- ["<S-Tab>"] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   else
    --     fallback()
    --   end
    -- end,
  },

  -- Youtube:
  --    the order of your sources matter (by default). That gives them priority
  --    you can configure:
  --        keyword_length
  --        priority
  --        max_item_count
  --        (more?)
  sources = {
    { name = "gh_issues" },
    { name = "copilot" },

    -- Youtube: Could enable this only for lua, but nvim_lua handles that already.
    { name = "nvim_lua" },
    -- { name = "tn" },

    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "cmp_luasnip" },
    { name = "buffer", keyword_length = 5 },
  },

  sorting = {
    -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,

      -- copied from cmp-under, but I don't think I need the plugin for this.
      -- I might add some more of my own.
      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find "^_+"
        local _, entry2_under = entry2.completion_item.label:find "^_+"
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,

      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  -- Youtube: mention that you need a separate snippets plugin
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  formatting = {
    -- Youtube: How to set up nice formatting for your sources.
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        copilot = "[Copilot]",
        luasnip = "[snip]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        gh_issues = "[issues]",
      },
    },
  },

  experimental = {

    -- I like the new menu better! Nice work hrsh7th
    native_menu = false,

    -- Let's play with this for a day or two
    ghost_text = true,
  },
}

cmp.setup.cmdline("/", {
  completion = {
    autocomplete = false,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp_document_symbol" },
  }, {
    -- { name = "buffer", keyword_length = 5 },
  }),
})

--[[
" Setup buffer configuration (nvim-lua source only enables in Lua filetype).
"
" ON YOUTUBE I SAID: This only _adds_ sources for a filetype, not removes the global ones.
"
" BUT I WAS WRONG! This will override the global setup. Sorry for any confusion.
autocmd FileType lua lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'nvim_lua' },
\     { name = 'buffer' },
\   },
\ }
--]]

_ = vim.cmd [[
  augroup CmpZsh
    au!
    autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
  augroup END
]]

--[[
" Disable cmp for a buffer
autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
--]]

-- Youtube: customizing appearance
--
-- nvim-cmp highlight groups.
-- local Group = require("colorbuddy.group").Group
-- local g = require("colorbuddy.group").groups
-- local s = require("colorbuddy.style").styles
--
-- Group.new("CmpItemAbbr", g.Comment)
-- Group.new("CmpItemAbbrDeprecated", g.Error)
-- Group.new("CmpItemAbbrMatchFuzzy", g.CmpItemAbbr.fg:dark(), nil, s.italic)
-- Group.new("CmpItemKind", g.Special)
-- Group.new("CmpItemMenu", g.NonText)
