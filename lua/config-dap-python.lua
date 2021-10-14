local M = {}

M.cfg = function()
  local dap_python = require("dap-python")

  dap_python.test_runner = "pytest"
  dap_python.setup(vim.env.HOME .. "/.config/nvim/debugpy-venv/bin/python")
end

return M
