local M = {}

M.cfg = function()
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  -- If you want icons for diagnostic errors, you'll need to define them somewhere:
  vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

  require("neo-tree").setup({
    enable_git_status = true,
    enable_diagnostics = true,
    -- log_level = "trace",
    -- log_to_file = true,
    filesystem = {
      use_libuv_file_watcher = true,
      async_directory_scan = false,
      filtered_items = {
        always_show = {
          ".github",
        },
      },
    },
    window = {
      mappings = {
        ["S"] = "split_with_window_picker",
        ["s"] = "vsplit_with_window_picker",
      },
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          --auto close
          require("neo-tree").close_all()
        end,
      },
    },
  })
end

return M
