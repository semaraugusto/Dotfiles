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

require("catppuccin").setup {
 --  	color_overrides = {
	-- 	all = {
	-- 		text = "#ffffff",
	-- 	},
	-- 	latte = {
	-- 		base = "#ff0000",
	-- 		mantle = "#242424",
	-- 		crust = "#474747",
	-- 	},
	-- 	frappe = {},
	-- 	macchiato = {},
	-- 	mocha = {},
	-- },
    flavour = "frappe", -- mocha, macchiato, frappe, latte
    term_colors = true,
    dim_inactive = {
      enabled = true,
      shade = "dark",
      percentage = 0.25,
    },
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      telescope = true,
      treesitter = true,
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    }
}

vim.api.nvim_command "colorscheme catppuccin"
