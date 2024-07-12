local function cfg_values()
  return {
    mixing_color = vim.o.background == "light" and "#e7e7e7" or "None",
    blend_factor = 0.27,
  }
end

local function cfg()
  vim.diagnostic.config({ virtual_text = false })

  local values = cfg_values()

  require("tiny-inline-diagnostic").setup({
    hi = {
      mixing_color = values.mixing_color,
    },
    blend = {
      factor = values.blend_factor,
    },
  })
end

local function change()
  local values = cfg_values()
  require("tiny-inline-diagnostic").change({
    factor = values.blend_factor,
  }, {
    mixing_color = values.mixing_color,
  })
end

return {
  cfg = cfg,
  change = change,
}
