lovr-grid
===

A library for drawing 3D grids with [LÖVR](http://lovr.org).

Usage
---

Drop the `grid.lua` file in your project and require it.

```lua
local Grid = require 'grid'

function lovr.load()
  grid = Grid.new(5, 5)
end

function lovr.draw()
  grid:draw()
end
```

See [`main.lua`](main.lua) for a more complicated example.

API
---

##### `grid.new(width, depth, size, pattern, fill)`

Create a new grid object.

- `width` - The size of the grid on the x axis, in meters.  The default is 10 meters.
- `depth` - The size of the grid on the z axis, in meters.  The default is 10 meters.
- `size` - The size of each cell of the grid, in meters.  The default is 1 meter.
- `pattern` - A pattern to use to vary the opacity of each grid line.  The default is `{ 1 }` which
uses full opacity for each line.  A pattern of `{ 1, .5 }` would cause every other grid line to be
50% opacity.
- `fill` - A table with rgba values to use to fill in the grid.  The default, `nil`, means no fill.

Returns a new grid object.  You can call `:draw` on it to draw it.

##### `:draw(x, y, z, sx, sy, sz, angle, ax, ay, az)`

Draw the grid object.  Takes the usual arguments for drawing functions to allow positioning and
rotation of the grid.  A `Transform` can also be used.  By default, a grid is drawn centered at `0,
0, 0`.

License
---

MIT, see [`LICENSE`](LICENSE) for details.
