local ls = require "luasnip"

require("luasnip.session.snippet_collection").clear_snippets "rust" 

-- local snippet = ls.s
local snippet_from_nodes = ls.sn

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

local shared = R"user.snips"
local same = shared.same


local shared = R "user.snips"
local same = shared.same
local make = shared.make

local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"

local get_node_text = vim.treesitter.get_node_text


ls.add_snippets(
  "rust",
  make {
    main = {
      t { "fn main() {", "\t" },
      i(0),
      t { "", "}" },
    },
    modtest = {
      t { "#[cfg(test)]", "" },
      t { "mod tests {", "\t"},
      t { "use super::*;", "\t" },
      i(0),
      t { "", "}" },
    },
    test = {
      t { "#[test]", "", "fn " },
      i (1, { "test_func" }),
      t { " {", "\t" }, 
      i(0),
      t { "", "}" },
    }
  }
)

--     --
--     -- modtest = {
--     --     t { "#[cfg(test)]\n" },
--     --     t { "mod tests {{\n" },
--     --     t { "use super::*;\n" },
--     --     i(0)
--     --   }
--   }
-- },
    -- test = fmt(
    --   [[
    --     #[test]
    --     fn {}(){}{{
    --         {}
    --     }}
    --   ]],
    --   {
    --     i(1, "testname"),
    --     c(2, {
    --       t "",
    --       t " -> Result<()> ",
    --       -- fmt(" -> {}<()> ", { i(nil, "Result") }),
    --     }),
    --     i(0),
    --   }
    -- ),
    --
    -- eq = fmt("assert_eq!({}, {});{}", { i(1), i(2), i(0) }),
    --
    -- enum = {
    --   t { "#[derive(Debug, PartialEq)]", "enum " },
    --   i(1, "Name"),
    --   t { " {", "  " },
    --   i(0),
    --   t { "", "}" },
    -- },
    --
    -- struct = {
    --   t { "#[derive(Debug, PartialEq)]", "struct " },
    --   i(1, "Name"),
    --   t { " {", "    " },
    --   i(0),
    --   t { "", "}" },
    -- },
    --
    -- pd = fmt([[println!("{}: {{:?}}", {});]], { same(1), i(1) }),
    -- -- _pd = {
    -- --   t [[println!("{:?}", ]],
    -- --   i(1),
    -- --   t [[);]],
    -- -- },
