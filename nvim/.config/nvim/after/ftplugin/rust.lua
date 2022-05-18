-- Don't do comment stuffs when I use o/O
vim.opt_local.formatoptions:remove "o"

lsp = require"lsp.extensions"

vim.cmd [[  autocmd CursorHold,CursorHoldI,CursorMoved *.rs :lua lsp.show_line_hints()]]
vim.keymap.set("n", "<F5>", function()
  if require("dap").session() then
    require("dap").continue()
  else
    R("lsp.dap").select_rust_runnable()
  end
end)
