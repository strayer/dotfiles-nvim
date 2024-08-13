local M = {}

M.find_git_root = function(path)
  local function is_git_repo(p)
    local git_path = p .. "/.git"
    local stat = vim.loop.fs_stat(git_path)
    return stat and stat.type == "directory"
  end

  local current_path = path or vim.fn.getcwd()

  while current_path ~= "/" do
    if is_git_repo(current_path) then
      return current_path
    end
    current_path = vim.fn.fnamemodify(current_path, ":h")
  end

  return nil
end

M.get_git_root_or_cwd = function()
  local git_root = M.find_git_root()
  if git_root then
    return git_root
  else
    return vim.fn.getcwd()
  end
end

M.basename = function(path)
  return vim.fn.fnamemodify(path, ":t")
end

M.input_prompt_with_default = function(prompt, default, callback)
  vim.ui.input({ prompt = prompt, default = default }, function(input)
    if not input then
      -- If the input was cancelled, pass nil to the callback
      callback(nil)
    else
      -- Pass the user input to the callback
      callback(input)
    end
  end)
end

return M
