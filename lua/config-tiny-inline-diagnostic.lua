local function cfg()
  vim.diagnostic.config({ virtual_text = false })

  require("tiny-inline-diagnostic").setup({
    hi = {
      mixing_color = vim.o.background == "light" and "#e7e7e7" or "None",
    },
    blend = {
      factor = 0.27,
    },
  })
end

return {
  cfg = cfg,
}
