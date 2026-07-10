local M = {}

M.cfg = function()
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.INFO] = " ",
        [vim.diagnostic.severity.HINT] = "󰌵",
      },
    },
  })

  require("neo-tree").setup({
    enable_git_status = true,
    enable_diagnostics = true,
    -- log_level = "trace",
    -- log_to_file = true,
    filesystem = {
      use_libuv_file_watcher = true,
      -- Preserve the old `false` behavior using Neo-tree v3's named setting.
      async_directory_scan = "never",
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
          -- Auto-close the tree after choosing a file.
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  })
end

return M
