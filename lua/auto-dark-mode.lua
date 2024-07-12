-- Source: https://github.com/jascha030/macos-nvim-dark-mode/blob/cc7f35a/README.md#neovim

local os_is_dark = function()
  local f = assert(io.open(vim.env.HOME .. "/.cache/system-theme.txt", "r"))
  local current_system_theme = f:read("*all")
  f:close()

  return current_system_theme == "dark"
end

local is_dark = function()
  return vim.o.background == "dark"
end

-- local set_scheme_for_style = function(dark)
--     vim.g = vim.tbl_deep_extend('force', vim.g, {
--         tokyonight_colors = vim.tbl_deep_extend(
--             'force',
--             theme_colors,
--             dark and color_overrides.dark or color_overrides.light
--         ),
--         tokyonight_style = dark and 'storm' or 'day',
--         tokyonight_italic_functions = true,
--         tokyonight_italic_comments = true,
--         tokyonight_sidebars = { 'terminal', 'packer' },
--     })
--
--     vim.cmd([[colorscheme tokyonight]])
-- end

local set_from_os = function()
  if os_is_dark() then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end

  if package.loaded['tiny-inline-diagnostic'] then
    require("config-tiny-inline-diagnostic").cfg()
  end

  -- reconfigure lualine to load correct theme
  if package.loaded['lualine'] then
    require("config-lualine").cfg()
  end

  -- set_scheme_for_style(os_is_dark())
end

local init = function()
  set_from_os()

  vim.api.nvim_create_autocmd("Signal", {
    pattern = "*",
    callback = function()
      set_from_os()
    end,
  })
end

return {
  init = init,
}
