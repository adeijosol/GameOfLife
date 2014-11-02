# Game of Life
An implementation of Conway's Game of Life in Processing.

![Screenshot of GameOfLife](https://github.com/adjl/GameOfLife/raw/master/screenshot.png)

## Controls
`p` - Resume/pause the simulation  
`c` - Clear the grid  
`r` - Randomise the grid (generate a new seed)  
`q` - Quit

When the simulation is paused, you can move the mouse pointer around to highlight cells and to add/kill live ones.

`left-click` - Add live cell  
`right-click` - Kill cell

Mouse events are ignored when the simulation is running.

## Parameters
Modify the following in [`GameOfLife.pde`](https://github.com/adjl/GameOfLife/raw/master/GameOfLife.pde) to your preferences:
- `COLOURS` (default: red, green, blue, cyan, magenta, yellow)
- `ANIMATION_DELAY` (default: 100)
- `CELL_CHANCE_TO_LIVE` (default: 10)
  - Relevant only when randomising the grid
  - Must be greater than 0
  - 1 = 100%, 2 = 50%, 4 = 25%, etc.
- `CELL_SIZE` (default: 5)

## Note
- The simulation starts with a random seed.

## License
[MIT License](https://github.com/adjl/GameOfLife/raw/master/LICENSE)
