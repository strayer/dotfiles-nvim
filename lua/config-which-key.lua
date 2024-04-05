local M = {}

M.cfg = function()
  local wk = require("which-key")

  wk.register({
    ["?"] = { "<CMD>NvimTreeFindFile<CR>", "find current file" },
    -- e = { "<CMD>NvimTreeToggle<CR>", "explorer" },
    e = {
      name = "+explore",
      e = { "<CMD>Neotree filesystem reveal toggle<CR>", "filesystem" },
      b = { "<CMD>Neotree buffers toggle<CR>", "buffers" },
      g = { "<CMD>Neotree git_status toggle<CR>", "git status" },
    },
    f = { function() require('fzf-lua').files() end, "files" },
    r = { "<CMD>RnvimrToggle<CR>", "ranger" },
    h = { "<C-W>s", "split below" },
    v = { "<C-W>v", "split right" },
    -- [' '] = {'<CMD>lua require\'config-telescope\'.project_files()<CR>', 'search project files'},
    d = {
      name = "+debug",
      b = { '<CMD>lua require"dap".toggle_breakpoint()<CR>', "toggle breakpoint" },
      c = { '<CMD>lua require"dap".continue()<CR>', "continue" },
      o = { '<CMD>lua require"dap".step_over()<CR>', "step over" },
      i = { '<CMD>lua require"dap".step_into()<CR>', "step into" },
      r = { '<CMD>lua require"dap".repl.open()<CR>', "repl" },
    },
    s = {
      name = "+search",
      b = { function() require('fzf-lua').buffers() end, "buffers" },
      B = { function() require('fzf-lua').git_branches() end, "git branches" },
      d = { function() require('fzf-lua').diagnostics_document() end, "document_diagnostics" },
      D = { function() require('fzf-lua').diagnostics_workspace() end, "workspace_diagnostics" },
      f = { function() require('fzf-lua').files() end, "files" },
      h = { function() require('fzf-lua').command_history() end, "history" },
      m = { function() require('fzf-lua').marks() end, "marks" },
      t = { function() require('fzf-lua').live_grep() end, "text" },
      r = { function() require('neoclip.fzf')() end, "registers" },
      u = { function() require('fzf-lua').colorschemes() end, "colorschemes" },
    },
    l = {
      name = "+lsp",
      d = { function() require('fzf-lua').diagnostics_document() end, "document_diagnostics" },
      D = { function() require('fzf-lua').diagnostics_workspace() end, "workspace_diagnostics" },
      f = { "<CMD>LspFormat<CR>", "format" },
      I = { "<CMD>LspInfo<CR>", "lsp info" },
      v = { "<CMD>LspVirtualTextToggle<CR>", "lsp toggle virtual text" },
      t = { "<CMD>Trouble<CR>", "trouble" },
      T = { "<CMD>LspTypeDefinition<CR>", "type defintion" },
      x = { "<CMD>cclose<CR>", "close quickfix" },
      s = { function() require('fzf-lua').lsp_document_symbols() end, "document symbols" },
      S = { function() require('fzf-lua').lsp_workspace_symbols() end, "workspace symbols" },
      r = { "<CMD>Lspsaga rename<cr>", "rename symbol" },
      K = { "<cmd>Lspsaga hover_doc<cr>", "hover doc" },
      a = { function() require('fzf-lua').lsp_code_actions() end, "code actions" },
    },
    w = {
      name = "+window",
      q = { "<C-W>q", "close" },
      o = { "<C-W>o", "other" },
      h = { "<C-W>h", "left" },
      j = { "<C-W>j", "down" },
      k = { "<C-W>k", "up" },
      l = { "<C-W>l", "right" },
      f = { "<CMD>NoNeckPain<CR>", "focus" },
    },
    t = {
      name = "+terminal",
      f = { "<CMD>FloatermToggle<CR>", "floating" },
      v = { "<CMD>bo vsplit term://$SHELL<CR>" },
      h = { "<CMD>bo split term://$SHELL<CR>" },
    },
  }, { prefix = "<leader>" })
end

return M
