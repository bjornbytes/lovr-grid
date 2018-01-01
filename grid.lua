local grid = {}
grid.__index = grid

local epsilon = 1 / 1e6

local function round(x, n)
  n = n or 1
  return x >= 0 and math.floor(x / n + .5) * n or math.ceil(x / n - .5) * n
end

function grid.new(width, depth, size, pattern, fill)
  local self = setmetatable({}, grid)
  self.width = width or 10
  self.depth = depth or 10
  self.size = size or 1
  self.pattern = pattern or { 1 }
  self.fill = fill or nil

  local vertexFormat = {
    { 'lovrPosition', 'float', 3 },
    { 'lovrVertexColor', 'byte', 4 }
  }

  local vertices = {}
  local w, d, s = round(self.width / 2, self.size), round(self.depth / 2, self.size), self.size

  for x = -w, w + epsilon, s do
    local i = 1 + round(x / s) % #self.pattern
    table.insert(vertices, { x, 0, -d, 255, 255, 255, 255 * self.pattern[i] })
    table.insert(vertices, { x, 0, d, 255, 255, 255, 255 * self.pattern[i] })
  end

  for z = -d, d + epsilon, s do
    local i = 1 + round(z / s) % #self.pattern
    table.insert(vertices, { -w, 0, z, 255, 255, 255, 255 * self.pattern[i] })
    table.insert(vertices, { w, 0, z, 255, 255, 255, 255 * self.pattern[i] })
  end

  self.mesh = lovr.graphics.newMesh(vertexFormat, vertices, 'lines', 'static')

  return self
end

function grid:draw(...)
  local w, d, s = round(self.width / 2, self.size), round(self.depth / 2, self.size), self.size

  lovr.graphics.push()
  lovr.graphics.transform(...)

  if self.fill then
    local r, g, b, a = lovr.graphics.getColor()
    lovr.graphics.setColor(self.fill)
    lovr.graphics.push()
    lovr.graphics.scale(w * 2, d * 2)
    lovr.graphics.plane('fill', 0, -epsilon, 0, 1, math.pi / 2, 1, 0, 0)
    lovr.graphics.pop()
    lovr.graphics.setColor(r, g, b, a)
  end

  self.mesh:draw()

  lovr.graphics.pop()
end

return grid
