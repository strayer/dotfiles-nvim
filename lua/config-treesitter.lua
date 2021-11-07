local M = {}

M.cfg = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "go",
      "html",
      "javascript",
      "json",
      "lua",
      "python",
      "ruby",
      "rust",
      "toml",
      "typescript",
      "yaml",
      "vue",
      "scss",
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
  })

  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr"

  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.pug = {
    install_info = {
      url = "~/.config/nvim/tree-sitter-pug", -- local path or git repo
      files = { "src/parser.c", "src/scanner.cc" },
    },
    filetype = "pug", -- if filetype does not agrees with parser name
    used_by = { "bar", "baz" }, -- additional filetypes that use this parser
  }
end

return M
