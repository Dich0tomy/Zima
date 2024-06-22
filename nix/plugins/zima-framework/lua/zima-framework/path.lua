local M = {}

---@alias Path string Filesystem path

---OS specific directory separator
---@type string 
M.separator = (function()
  if vim.fn.has('unix') then
    return '/'
  else
    -- Technically windows also uses `/` but
    -- some people and tools don't know that
    -- and assume only `\` is valid
    return '\\'
  end
end)()

---Checks if a given path exists
---@param path Path
---@return boolean
function M.exists(path)
  return vim.fn.exists(path) == 1
end

return M
