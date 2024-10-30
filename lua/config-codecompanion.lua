local M = {}

M.config = function()
  local config = {
    display = {
      chat = {
        render_headers = false,
      },
    },
  }

  local ok, private_config = pcall(require, "config-codecompanion-private")
  if ok then
    config = vim.tbl_deep_extend("force", config, private_config.config)
  else
    vim.notify("Failed to load config-codecompanion-private.lua. Using default configuration.", vim.log.levels.WARN)
  end

  return config
end

return M
