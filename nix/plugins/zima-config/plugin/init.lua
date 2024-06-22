vim.api.nvim_create_autocmd('VimEnter', {
  desc = "Loads zima config only after all other setup (including other plugins) has completed.",
  group = vim.api.nvim_create_namespace('zima-startup'),

  once = true,
  callback = function()
    require('zima-config')
  end
})
