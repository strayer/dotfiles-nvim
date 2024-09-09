local M = {}

M.keys = {
  { "<leader>?", "<CMD>NvimTreeFindFile<CR>", desc = "find current file" },
  { "<leader>e", group = "explore" },
  { "<leader>ee", "<CMD>Neotree filesystem reveal toggle<CR>", desc = "filesystem" },
  { "<leader>eb", "<CMD>Neotree buffers toggle<CR>", desc = "buffers" },
  { "<leader>eg", "<CMD>Neotree git_status toggle<CR>", desc = "git status" },
  {
    "<leader>f",
    function()
      require("fzf-lua").files()
    end,
    desc = "files",
  },
  { "<leader>r", "<CMD>RnvimrToggle<CR>", desc = "ranger" },
  { "<leader>h", "<C-W>s", desc = "split below" },
  { "<leader>v", "<C-W>v", desc = "split right" },
  { "<leader>d", group = "debug" },
  { "<leader>db", '<CMD>lua require"dap".toggle_breakpoint()<CR>', desc = "toggle breakpoint" },
  { "<leader>dc", '<CMD>lua require"dap".continue()<CR>', desc = "continue" },
  { "<leader>do", '<CMD>lua require"dap".step_over()<CR>', desc = "step over" },
  { "<leader>di", '<CMD>lua require"dap".step_into()<CR>', desc = "step into" },
  { "<leader>dr", '<CMD>lua require"dap".repl.open()<CR>', desc = "repl" },
  { "<leader>s", group = "search" },
  {
    "<leader>sb",
    function()
      require("fzf-lua").buffers()
    end,
    desc = "buffers",
  },
  {
    "<leader>sB",
    function()
      require("fzf-lua").git_branches()
    end,
    desc = "git branches",
  },
  {
    "<leader>sd",
    function()
      require("fzf-lua").diagnostics_document()
    end,
    desc = "document_diagnostics",
  },
  {
    "<leader>sD",
    function()
      require("fzf-lua").diagnostics_workspace()
    end,
    desc = "workspace_diagnostics",
  },
  {
    "<leader>sf",
    function()
      require("fzf-lua").files()
    end,
    desc = "files",
  },
  {
    "<leader>sh",
    function()
      require("fzf-lua").command_history()
    end,
    desc = "history",
  },
  {
    "<leader>sm",
    function()
      require("fzf-lua").marks()
    end,
    desc = "marks",
  },
  {
    "<leader>st",
    function()
      require("fzf-lua").live_grep()
    end,
    desc = "text",
  },
  {
    "<leader>ss",
    function()
      require("mini.sessions").select()
    end,
    desc = "sessions",
  },
  {
    "<leader>sr",
    function()
      require("neoclip.fzf")()
    end,
    desc = "registers",
  },
  {
    "<leader>su",
    function()
      require("fzf-lua").colorschemes()
    end,
    desc = "colorschemes",
  },
  { "<leader>S", group = "sessions" },
  {
    "<leader>Sn",
    function()
      local MiniSessions = require("mini.sessions")
      local Utils = require("utils")

      local project_path = Utils.get_git_root_or_cwd()
      local proposed_session_name = vim.fs.basename(project_path)

      Utils.input_prompt_with_default("Session name:", proposed_session_name, function(name)
        if name then
          MiniSessions.write(name)
        end
      end)
    end,
    desc = "sessions",
  },
  { "<leader>l", group = "lsp" },
  {
    "<leader>ld",
    function()
      require("fzf-lua").diagnostics_document()
    end,
    desc = "document_diagnostics",
  },
  {
    "<leader>lD",
    function()
      require("fzf-lua").diagnostics_workspace()
    end,
    desc = "workspace_diagnostics",
  },
  { "<leader>lI", "<CMD>LspInfo<CR>", desc = "lsp info" },
  { "<leader>lv", "<CMD>LspVirtualTextToggle<CR>", desc = "lsp toggle virtual text" },
  { "<leader>lt", "<CMD>Trouble<CR>", desc = "trouble" },
  { "<leader>lT", "<CMD>LspTypeDefinition<CR>", desc = "type defintion" },
  { "<leader>lx", "<CMD>cclose<CR>", desc = "close quickfix" },
  {
    "<leader>ls",
    function()
      require("fzf-lua").lsp_document_symbols()
    end,
    desc = "document symbols",
  },
  {
    "<leader>lS",
    function()
      require("fzf-lua").lsp_workspace_symbols()
    end,
    desc = "workspace symbols",
  },
  { "<leader>lr", "<CMD>Lspsaga rename<cr>", desc = "rename symbol" },
  { "<leader>lK", "<cmd>Lspsaga hover_doc<cr>", desc = "hover doc" },
  {
    "<leader>la",
    function()
      require("fzf-lua").lsp_code_actions()
    end,
    desc = "code actions",
  },
  { "<leader>w", group = "window" },
  { "<leader>wq", "<C-W>q", desc = "close" },
  { "<leader>wo", "<C-W>o", desc = "other" },
  { "<leader>wh", "<C-W>h", desc = "left" },
  { "<leader>wj", "<C-W>j", desc = "down" },
  { "<leader>wk", "<C-W>k", desc = "up" },
  { "<leader>wl", "<C-W>l", desc = "right" },
  { "<leader>wf", "<CMD>NoNeckPain<CR>", desc = "focus" },
  { "<leader>t", group = "terminal" },
  { "<leader>tf", "<CMD>FloatermToggle<CR>", desc = "floating" },
  { "<leader>tv", "<CMD>bo vsplit term://$SHELL<CR>", desc = "vertical split terminal" },
  { "<leader>th", "<CMD>bo split term://$SHELL<CR>", desc = "horizontal split terminal" },
}

return M
