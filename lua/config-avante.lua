local M = {}

M.config = function()
  local config = {}

  local ok, private_config = pcall(require, "config-avante-private")
  if ok then
    config = vim.tbl_deep_extend("force", config, private_config.config)
  else
    vim.notify("Failed to load config-avante-private.lua. Using default configuration.", vim.log.levels.WARN)
  end

  return config
end

return M
