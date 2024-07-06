describe('flip', function()
  it('flips a function with two arguments', function()
    local flip = require('zima-config.lib.fp').flip
    local sub = function(a, b) return a - b end

    assert.are.same(sub(5, 3), 2)
    assert.are.same(flip(sub)(3, 5), 2)
  end)
end)
