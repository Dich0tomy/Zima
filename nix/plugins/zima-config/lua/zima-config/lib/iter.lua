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
---@return [T] not satisfying satisfying the predicate, [T] not satisfying the predicate
function M.partition(range, pred, proj_beg, proj_end)
  local fp = require('zima-config.lib.fp')
  proj_beg = fp.maybe_fn(proj_beg)
  proj_end = fp.maybe_fn(proj_end)

  return
    proj_end(vim.iter(range):map(proj_beg):filter(pred):totable()) or {},
    proj_end(vim.iter(range):map(proj_beg):filter(fp.nah(pred)):totable()) or {}
end

return M
