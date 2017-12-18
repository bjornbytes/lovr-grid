local grid = require('grid')

function lovr.load()
  floor = grid.new(8, 8, .5, { 1, .25, .5, .25 }, { .12, .12, .12 })
end

function lovr.draw()
  lovr.graphics.cube('fill', 0, 0, 0, .05)
  floor:draw()
end
