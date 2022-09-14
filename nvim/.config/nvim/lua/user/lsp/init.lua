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

local filetype_attach = setmetatable({
  go = function(client)
    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.format()
      augroup END
    ]]
  end,

  rust = function()
    buf_nnoremap{"<space>wf", vim.lsp.buf.workspace_symbol}

    require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/lua/user/snips/snippets/" } })
    require"luasnip".filetype_extend("rust", {"rust-analyzer"})
    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.format()
      augroup END
    ]]
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

  buf_inoremap { "<c-s>", vim.lsp.buf.signature_help }

  buf_nnoremap { "<space>gr", vim.lsp.buf.rename }
  buf_nnoremap { "<space>ga", vim.lsp.buf.code_action }

  buf_nnoremap { "gd", vim.lsp.buf.definition }
  buf_nnoremap { "gD", vim.lsp.buf.declaration }
  buf_nnoremap { "gi", vim.lsp.buf.implementation }
  buf_nnoremap { "gT", vim.lsp.buf.type_definition }

  buf_nnoremap { "<space>gi", handlers.implementation }
  buf_nnoremap { "<space>lr", "<cmd>lua R('user.lsp.codelens').run()<CR>" }
  buf_nnoremap { "<space>rr", "<cmd>LspRestart<CR>" }

  buf_nnoremap { "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>" }
  buf_nnoremap { "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>" }

  buf_nnoremap { "<leader>e", vim.lsp.diagnostic.show_line_diagnostics }
  if client.server_capabilities.documentFormattingProvider then
    buf_nnoremap {'<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>'}
  end
  if client.server_capabilities.documentRangeFormattingProvider then
    buf_vnoremap {'<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>'}
  end

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

  if client.server_capabilities.codeLensProvider then
    if filetype ~= "elm" then
      vim.cmd [[
        augroup lsp_document_codelens
          au! * <buffer>
          autocmd BufEnter ++once         <buffer> lua require"vim.lsp.codelens".refresh()
          autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
        augroup END
      ]]
    end
  end

  -- Attach any filetype specific options to the client
  filetype_attach[filetype](client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
if nvim_status then
  -- vim.notify (dump_server_capabilities(updated_capabilities));
  -- vim.notify (dump_server_capabilities(nvim_status.capabilities));
  updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
end
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

-- TODO: check if this is the problem.
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

-- vim.lsp.buf_request(0, "textDocument/codeLens", { textDocument = vim.lsp.util.make_text_document_params() })

local servers = {
  gdscript = true,
  graphql = true,
  html = true,
  pyright = true,
  vimls = true,
  yamlls = true,
  eslint = true,
  hls = true,
  solang = true,
  bashls = true,
  -- jsonls = true,

  cmake = (1 == vim.fn.executable "cmake-language-server"),
  dartls = pcall(require, "flutter-tools"),

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
}

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

local use_null = true
if use_null then
  require("null-ls").setup {
    sources = {
      -- require("null-ls").builtins.formatting.stylua,
      -- require("null-ls").builtins.diagnostics.eslint,
      -- require("null-ls").builtins.completion.spell,
      -- require("null-ls").builtins.diagnostics.selene,
      require("null-ls").builtins.formatting.prettierd,
    },
  }
end


return {
  on_init = custom_init,
  on_attach = custom_attach,
  server_capabilities = updated_capabilities,
}
