if not pcall(require, "plenary") then
  return
end

vim.notify = require("notify")
-- vim.notify = function(msg, level, opts)
--   log.info(msg, level, opts)
--
--   require "notify"(msg, level, opts)
-- end
