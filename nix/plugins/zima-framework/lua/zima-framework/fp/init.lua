-- Most of this is 1:1 lua utils by @Vhyrro
local lu = zima.xpnequire('lua-utils')

---Returns the item that matches the first item in statements.
---@param value any The value to compare against
---@param compare? fun(lhs: any, rhs: any): boolean A custom comparison function
---@return fun(statements: table<any, any>): any # A function to invoke with a table of potential matches.
local function match(value, compare)
	return lu.match(value, compare)
end

---Lazily concatenates a string to prevent runtime errors where an object may not exist
---Consider the following example:
---
---    lib.when(str ~= nil, str .. " extra text", "")
---
---This would fail, simply because the string concatenation will still be evaluated in order
---to be placed inside the variable. You may use:
---
---    lib.when(str ~= nil, lib.lazy_string_concat(str, " extra text"), "")
---
---To mitigate this issue directly.
---@param ... string An unlimited number of strings.
---@return string # The result of all the strings concatenated.
local function lazy_string_concat(...)
	return lu.lazy_string_concat(...)
end

---Takes a function of two arguments and flips their parameters
---@param fun fun(lhs: any, rhs: any): any Function to flip
---@return fun(rhs: any, lhs: any): any # Flipped function
local function flip(fun)
	return function(lhs, rhs)
		fun(rhs, lhs)
	end
end

---Partially applies some function arguments
---@param fun fun(...: any): any Function to apply args to
---@param ... any Args to apply
---@return fun(...: any): any # Flipped function
local function partial(fun, ...)
	local passed = arg
	return function(...)
		fun(unpack(passed), ...)
	end
end

---Partially applies some function arguments to the back
---@param fun fun(...: any): any Function to apply args to
---@param ... any Args to apply
---@return fun(...: any): any # Flipped function
local function partial_back(fun, ...)
	local passed = arg
	return function(...)
		fun(..., unpack(passed))
	end
end

---Discards N first arguments
---@param n number
---@param fun fun(...: any): any Function to discard args from
---@return fun(...: any): any # Func with discarded args
local function discard(n, fun)
	return function(...)
		return fun(select(n + 1, ...))
	end
end
--
---Discards first argument
---@param fun fun(...: any): any Function to discard args from
---@return fun(...: any): any # Func with discarded args
local function discard_first(fun)
	return function(...)
		return fun(select(...))
	end
end

---Returns the nth argument passed to this function
---@param n number Which argument to return
---@param ... any Args
---@return any # Nth arg
local function nth(n, ...)
	return arg[n]
end

---Returns the first argument passed to this function
---@return ... any Args
---@return any first First arg
local function first(...)
	return partial(nth, 1)(...)
end

---Returns the second argument passed to this function
---@return ... any Args
---@return any second First arg
local function second(...)
	return partial(nth, 2)(...)
end

return {
	match = match,
	lazy_string_concat = lazy_string_concat,
	flip = flip,
	discard = discard,
	discard_first = discard_first,
	partial = partial,
	partial_back = partial_back,
	nth = nth,
	first = first,
	second = second,
}
