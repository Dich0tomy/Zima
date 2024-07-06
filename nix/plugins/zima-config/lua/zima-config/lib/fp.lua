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
---@generic T, U
---@param fun fun(lhs: `T`, rhs: `U`): any Function to flip
---@return fun(rhs: U, lhs: `T`): any # Flipped function
local function flip(fun)
	return function(lhs, rhs)
		fun(rhs, lhs)
	end
end

---Partially applies some function arguments
---@param fun fun(...: any): any Function to apply args to
---@param ... any Args to apply
---@return fun(...: any): any # Function with args applied
local function partial(fun, ...)
	local passed = { ... }
	return function(...)
		return fun(unpack(passed), ...)
	end
end

---Partially applies some function arguments to the back
---@param fun fun(...: any): any Function to apply args to
---@param ... any Args to apply
---@return fun(...: any): any # Function with args applied to the back
local function partial_(fun, ...)
	local passed = { ... }
	return function(...)
		return fun(..., unpack(passed))
	end
end

---Wraps the function an discards N first arguments
---@param n number
---@param fun fun(...: any): any Function to discard args from
---@return fun(...: any): any # Func with discarded args
local function discard(n, fun)
	return function(...)
		return fun(select(n + 1, ...))
	end
end
--
---Wraps the function an discards the first argument
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
	return ({ ... })[n]
end

---Returns the first argument passed to this function
---@generic T
---@param a `T` The first arg
---@return T # The first argument
local function first(a)
	return a
end

---Returns the second argument passed to this function
---@generic T
---@param _a any First arg, discarded
---@param b `T` Second arg, returned
---@return T # Second arg
local function second(_a, b)
	return b
end

---Returns a function that compares its argument to `value`
---@generic T
---@param value `T` Value to compare against
---@return fun(x: T): boolean
local function equal(value)
	return function(x)
		return x == value
	end
end

---If it's a function, calls it, otherwise returns id
---@generic R, V
---@param value fun(any...): `R`|V Value to call/return
---@param ... any Possible values to pass to the function
---@return R|V
local function eval(value, ...)
  if type(value) == "function" then
    return value(...)
  else
    return value
  end
end

---Returns the result of a function wrapped in an array
---@generic Ts
---@param f fun(any...): `Ts` Function to wrap
---@return fun(...): [Ts]
local function arraified(f)
  return function(...)
    return { f(...) }
  end
end

---Returns the args untouched
---@param ... any Args to return
---@return ... any
local function id(...)
  return ...
end

---Returns `nil` if arg is nil, otherwise the function
---@generic Rs, Ts
---@param value fun(...: `Ts`): `Rs`|nil Value to call/return
---@return fun(...: Ts): `Rs`|fun(...: any): ...
local function maybe_fn(value)
  assert(type(value) == 'function' or value == nil)

  if type(value) == "function" then
    return value
  else
    return id
  end
end

---Reduces the result over a function
---@generic T, U, R
---@param f fun(arg1: T, arg2: U): `R` The applied function
---@param acc R The accumulator and initial value
---@return R
local function foldl(f, acc, ...)
  if select("#", ...) == 0 then
    return acc
  end
  local l = ...
  return foldl(f, f(acc, l), select(2, ...))
end

---Composes two functions f, g and into `g(f(...))`
---@generic FirstR, SecondR
---@param f fun(...: any): `FirstR`
---@param g fun(...: FirstR): `SecondR`
---@return fun(...: any): SecondR
local function compose(f, g)
  return function(...)
    return g(f(...))
  end
end

---Chains several functions invocations together
---chain(a, b, c) results in c(b(a(...)))
---@param ... fun(...: any): ...
---@return fun(...: any): ...
local function chain(...)
  return foldl(compose, id, ...)
end

---Returns `not f(...)`
---@param f fun(...: any): boolean func to inverse
---@return fun(...: any): boolean
local function nah(f)
  return function(...)
    return not f(...)
  end
end

---Formats the arguments
---@param str string The format string
---@return fun(...: any): string
local function fmt(str)
  return function(...)
    return str:format(...)
  end
end

return {
	match = match,
	lazy_string_concat = lazy_string_concat,
	flip = flip,
	discard = discard,
	discard_first = discard_first,
	partial = partial,
	partial_ = partial_,
	nth = nth,
	first = first,
	second = second,
	equal = equal,
  eval = eval,
  arraified = arraified,
  id = id,
  compose = compose,
  chain = chain,
  nah = nah,
  fmt = fmt,
  maybe_fn = maybe_fn
}
