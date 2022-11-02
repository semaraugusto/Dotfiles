local imap = require("user.keymap").imap
local nmap = require("user.keymap").nmap
local vmap = require("user.keymap").vmap

local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end

local lspconfig_util = require "lspconfig.util"

local ok, nvim_status = pcall(require, "lsp-status")
if not ok then
  nvim_status = nil
end

require('copilot').setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "<C-n>",
      jump_next = "<C-p>",
      accept = "<C-y>",
      refresh = "gr",
      open = "<leader>go"
    },
  },
  preview = {
    enabled = true,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<leader>go"
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = false,
    debounce = 75,
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node version must be < 18
  plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
  server_opts_overrides = {
    trace = "verbose",
    settings = {
      advanced = {
        listCount = 10, -- #completions for panel
        inlineSuggestCount = 3, -- #completions for getCompletions
      }
    },
  }
})

function dump_server_capabilities(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump_server_capabilities(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local buf_vnoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  vmap(opts)
end

local buf_nnoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  nmap(opts)
end

local buf_inoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  imap(opts)
end

-- local neoclip = require"neoclip".setup()
local telescope_mapper = require "user.telescope.mappings"
local handlers = require "user.lsp.handlers"

local ts_util = require "nvim-lsp-ts-utils"

-- Can set this lower if needed.
-- require("vim.lsp.log").set_level "debug"
-- require("vim.lsp.log").set_level "trace"

local status = require "user.lsp.status"
print("STATUS", status)
if status then
  status.activate()
end

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local format_on_save = function(client)
  vim.cmd [[
    augroup lsp_buf_format
      au! BufWritePre <buffer>
      autocmd BufWritePre <buffer> :lua vim.lsp.buf.format()
    augroup END
  ]]
end
local filetype_attach = setmetatable({
  go = format_on_save,
  typescript = format_on_save,
  python = format_on_save,

  rust = function()
    buf_nnoremap{"<space>wf", vim.lsp.buf.workspace_symbol}
    require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/lua/user/snips/snippets/" } })
    require"luasnip".filetype_extend("rust", {"rust-analyzer"})
    format_on_save()
  end,
  }, {
  __index = function()
    return function() end
  end,
})


local custom_attach = function(client)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  if nvim_status then
    nvim_status.on_attach(client)
  end

  buf_nnoremap { "<leader>e", vim.diagnostic.open_float }

  buf_inoremap { "<c-s>", vim.lsp.buf.signature_help }

  buf_nnoremap { "<leader>gr", vim.lsp.buf.rename }
  buf_nnoremap { "<space>ga", vim.lsp.buf.code_action }

  buf_nnoremap { "gd", vim.lsp.buf.definition }
  buf_nnoremap { "gD", vim.lsp.buf.declaration }
  buf_nnoremap { "gi", vim.lsp.buf.implementation }
  buf_nnoremap { "gT", vim.lsp.buf.type_definition }

  buf_nnoremap { "<space>gi", handlers.implementation }
  buf_nnoremap { "<space>lr", "<cmd>lua R('user.lsp.codelens').run()<CR>" }
  buf_nnoremap { "<space>rr", "<cmd>LspRestart<CR>" }

  buf_nnoremap { "[d", vim.diagnostic.goto_prev }
  buf_nnoremap { "]d", vim.diagnostic.goto_next }

  if client.server_capabilities.documentFormattingProvider then
    buf_nnoremap {'<leader>F', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>'}
  end
  -- if client.server_capabilities.documentRangeFormattingProvider then
  --   buf_vnoremap {'<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>'}
  -- end

  -- buf_nnoremap { "gr", vim.lsp.buf.references }
  -- buf_nnoremap { "gI", vim.lsp.buf.implementation }
  telescope_mapper("gr", "lsp_references", nil, true)
  telescope_mapper("gI", "lsp_implementations", nil, true)
  -- telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
  -- telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

  if filetype ~= "lua" then
    buf_nnoremap { "K", vim.lsp.buf.hover, { desc = "lsp:hover" } }
    -- buf_nnoremap { "K", "<cmd>HoverWithActions<CR>", { desc = "lsp:hover" } }
  end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
  -- Attach any filetype specific options to the client
  filetype_attach[filetype](client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
if nvim_status then
  updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
end
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").default_capabilities(updated_capabilities)

-- TODO: check if this is the problem.
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

local servers = {
  gdscript = true,
  graphql = true,
  html = true,
  vimls = true,
  yamlls = true,
  eslint = true,
  hls = true,
  solidity = true,
  bashls = true,
  marksman = true,
  jsonls = true,

  cmake = (1 == vim.fn.executable "cmake-language-server"),
  dartls = pcall(require, "flutter-tools"),

  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            enabled = true;
          };
          pyls_mypy = {
            enabled = true;
          };
        }
      }
    };
  },

  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
    -- Required for lsp-status
    init_options = {
      clangdFileStatus = true,
    },
    handlers = nvim_status and nvim_status.extensions.clangd.setup() or nil,
  },

  gopls = {
    root_dir = function(fname)
      local Path = require "plenary.path"

      local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
      local absolute_fname = Path:new(fname):absolute()

      if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
        return absolute_cwd
      end

      return lspconfig_util.root_pattern("go.mod", ".git")(fname)
    end,

    settings = {
      gopls = {
        codelenses = { test = true },
      },
    },

    flags = {
      debounce_text_changes = 200,
    },
  },

  omnisharp = {
    cmd = { vim.fn.expand "~/build/omnisharp/run", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  },

  rust_analyzer = {
    cmd = { "rustup", "run", "nightly", "rust-analyzer" },
  },
  --   settings = {
  --     ["rust-analyzer"] = {
  --     },
  -- },

  elmls = true,

  tsserver = {
    init_options = ts_util.init_options,
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },

    on_attach = function(client)
      custom_attach(client)

      ts_util.setup { auto_inlay_hints = true }
      ts_util.setup_client(client)
    end,
  },
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {
            -- vim
            "vim",

            -- Busted
            "describe",
            "it",
            "before_each",
            "after_each",
            "teardown",
            "pending",
            "clear",

            -- Colorbuddy
            "Color",
            "c",
            "Group",
            "g",
            "s",

            -- Custom
            "RELOAD",
          },
        },

        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
    on_attach = function(client)
      custom_attach(client)
    end,
  }
}
-- sumneko_env = {
  -- cmd_env = {
  --   PATH = process.extend_path {
  --     path.concat { vim.fn.stdpath "data", "lsp_servers", "sumneko_lua", "extension", "server", "bin" },
  --   },
  -- },
-- }


local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    server_capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end

lspconfig.jedi_language_server.setup {
  on_init = custom_init,
  on_attach = custom_attach,
  server_capabilities = updated_capabilities,
}

-- setup_server("sumneko_lua", {
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--       },
--       diagnostics = {
--         globals = {
--           -- vim
--           "vim",
--
--           -- Busted
--           "describe",
--           "it",
--           "before_each",
--           "after_each",
--           "teardown",
--           "pending",
--           "clear",
--
--           -- Colorbuddy
--           "Color",
--           "c",
--           "Group",
--           "g",
--           "s",
--
--           -- Custom
--           "RELOAD",
--         },
--       },
--
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file("", true),
--       },
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- })

require("null-ls").setup({
    -- sources = {
        -- require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.diagnostics.eslint,
        -- require("null-ls").builtins.completion.spell,
    -- },
})


return {
  on_init = custom_init,
  on_attach = custom_attach,
  server_capabilities = updated_capabilities,
}
