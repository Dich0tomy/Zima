local M = {}

---Splits the string by a given value and returns a table
---@param str string String to splitmpare against
---@param delim string Delimiter to split by
---@return string[] # Table of split elements
function M.split(str, delim)
	return vim.iter(str:gmatch(("[^%%%s]+"):format(delim))):totable()
end

---Partitions the given range into one satisfying the pred and one not satisfying the pred
---@generic T
---@param range [`T`] The range to partition
---@param pred fun(T): boolean The predicate by which to partition
---@return [T] satisfying satisfying the predicate, [T] not satisfying the predicate
function M.partition(range, pred)
  local nah = require('zima-config.fp').nah

  return
    vim.iter(range):filter(pred):totable(),
    vim.iter(range):filter(nah(pred)):totable()
end

return M
