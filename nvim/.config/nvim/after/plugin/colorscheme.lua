-- if not pcall(require, "colorbuddy") then
--   return
-- end
--
-- vim.opt.termguicolors = true
--
-- require("colorbuddy").colorscheme "gruvbuddy"
-- require("colorizer").setup()
--
-- local c = require("colorbuddy.color").colors
-- local Group = require("colorbuddy.group").Group
-- local g = require("colorbuddy.group").groups
-- local s = require("colorbuddy.style").styles
--
-- Group.new("GoTestSuccess", c.green, nil, s.bold)
-- Group.new("GoTestFail", c.red, nil, s.bold)
--
-- -- Group.new('Keyword', c.purple, nil, nil)
--
-- Group.new("TSPunctBracket", c.orange:dark())
--
-- Group.new("StatuslineError1", c.red:light():light(), g.Statusline)
-- Group.new("StatuslineError2", c.red:light(), g.Statusline)
-- Group.new("StatuslineError3", c.red, g.Statusline)
-- Group.new("StatuslineError3", c.red:dark(), g.Statusline)
-- Group.new("StatuslineError3", c.red:dark():dark(), g.Statusline)
--
-- -- Group.new("pythonTSType", c.red)
-- -- Group.new("goTSType", g.Type.fg:dark(), nil, g.Type)
--
-- -- Group.new("typescriptTSConstructor", g.pythonTSType)
-- Group.new("typescriptTSProperty", c.blue)
--
-- -- vim.cmd [[highlight WinSeparator guifg=#4e545c guibg=None]]
-- Group.new("WinSeparator", nil, nil)
--
-- -- I don't think I like highlights for text
-- -- Group.new("LspReferenceText", nil, c.gray0:light(), s.bold)
-- -- Group.new("LspReferenceWrite", nil, c.gray0:light())
--
-- -- Group.new("TSKeyword", c.purple, nil, s.underline, c.blue)
-- -- Group.new("LuaFunctionCall", c.green, nil, s.underline + s.nocombine, g.TSKeyword.guisp)
--
-- -- Hello
-- Group.new("TSTitle", c.blue)

local catppuccin = require("catppuccin")
local settings = {
  transparent_background = false,
  term_colors = true,
  styles = {
      comments = "italic",
      conditionals = "italic",
      loops = "NONE",
      functions = "NONE",
      keywords = "NONE",
      strings = "NONE",
      variables = "NONE",
      numbers = "NONE",
      booleans = "NONE",
      properties = "NONE",
      types = "NONE",
      operators = "NONE",
  },
  integrations = {
      treesitter = true,
      native_lsp = {
          enabled = true,
          virtual_text = {
              errors = "italic",
              hints = "italic",
              warnings = "italic",
              information = "italic",
          },
          underlines = {
              errors = "underline",
              hints = "underline",
              warnings = "underline",
              information = "underline",
          },
      },
      coc_nvim = false,
      lsp_trouble = true,
      cmp = true,
      lsp_saga = false,
      gitgutter = false,
      gitsigns = true,
      telescope = true,
      nvimtree = {
          enabled = true,
          show_root = false,
          transparent_panel = false,
      },
      neotree = {
          enabled = false,
          show_root = false,
          transparent_panel = false,
      },
      which_key = false,
      indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
      },
      dashboard = true,
      neogit = true,
      vim_sneak = false,
      fern = false,
      barbar = false,
      bufferline = true,
      markdown = true,
      lightspeed = false,
      ts_rainbow = false,
      hop = true,
      notify = true,
      telekasten = true,
      symbols_outline = true,
  }
}

catppuccin.setup(settings)
