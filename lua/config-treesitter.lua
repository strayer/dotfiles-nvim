local M = {}

M.cfg = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "go",
      "html",
      "javascript",
      "json",
      "just",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "ruby",
      "rust",
      "scss",
      "terraform",
      "toml",
      "typescript",
      "yaml",
    },
    highlight = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    endwise = { enable = true },
  })

  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  vim.opt.foldlevel = 99
end

return M
