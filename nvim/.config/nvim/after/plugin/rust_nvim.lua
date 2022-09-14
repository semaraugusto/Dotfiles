local has_rust_tools, rust_tools = pcall(require, "rust-tools")

-- local _ = require "lsp.extensions"
if has_rust_tools then
  local lsp = require "user.lsp"
  rust_tools.setup {
tools = {
      autoSetHints = true,
      -- hover_with_actions = true,
      runnables = {
        use_telescope = true,
      },
      debuggables = {
        use_telescope = true,
      },
      -- These apply to the default RustSetInlayHints command
      inlay_hints = {
        auto = true,
        -- Only show inlay hints for the current line
        -- only_current_line = false,

        -- Event which triggers a refersh of the inlay hints.
        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
        -- not that this may cause  higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = "CursorHold",

        -- wheter to show parameter hints with the inlay hints or not
        show_parameter_hints = true,

        -- prefix for parameter hints
        parameter_hints_prefix = "<- ",

        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = "=> ",

        -- -- whether to align to the length of the longest line in the file
        -- max_len_align = false,
        -- -- padding from the left if max_len_align is true
        -- max_len_align_padding = 1,
        -- -- whether to align to the extreme right or not
        -- right_align = false,
        -- -- padding from the right if right_align is true
        -- right_align_padding = 7,

        -- The color of the hints
        -- highlight = "Comment",
      },
      hover_actions = {
        border = {
          { '╭', 'FloatBorder' },
          { '─', 'FloatBorder' },
          { '╮', 'FloatBorder' },
          { '│', 'FloatBorder' },
          { '╯', 'FloatBorder' },
          { '─', 'FloatBorder' },
          { '╰', 'FloatBorder' },
          { '│', 'FloatBorder' },
        },
        auto_focus = true,
      },
    },
    server = {
      capabilities = lsp.capabilities,
      on_init = lsp.on_init,
      on_attach = lsp.on_attach,

      flags = {
        debounce_text_changes = false,
      },
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importGranularity = "module",
            importPrefix = "by_self",
          },
          cargo = {
            loadOutDirsFromCheck = true,
          },
          procMacro = {
            enable = true,
          },
        },
      },
    },
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  }
end
