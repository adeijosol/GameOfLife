# Game of Life
An implementation of Conway's Game of Life in Processing.

![Screenshot of GameOfLife](https://github.com/adeijosol/GameOfLife/raw/master/screenshot.png)

## Controls
`p` - Resume/pause the simulation  
`c` - Clear the grid  
`r` - Randomise the grid (generate a new seed)  
`q` - Quit

When the simulation is paused, you can move the mouse pointer around to highlight cells and to add/remove live ones.

`left-click` - Add live cell  
`right-click` - Remove live cell

Mouse events are ignored when the simulation is running.

## Parameters
Modify the following in [`GameOfLife.pde`](https://github.com/adeijosol/GameOfLife/raw/master/GameOfLife.pde) to your preferences:
- `SCREEN_WIDTH` (default: 1366)
- `SCREEN_HEIGHT` (defaul: 768)
- `ANIMATION_DELAY` (default: 100)
- `CELL_SIZE` (default: 5)
- `CELL_PROBABILITY_TO_LIVE` (default: 10)
  - Relevant only when randomising the grid
  - Must be greater than 0
  - 1 = 100%, 2 = 50%, 4 = 25%, etc.

## Notes
- The simulation starts with a random seed.
- When there are many live cells, flashes of random background colours occur occasionally.

## License
[MIT License](https://github.com/adeijosol/GameOfLife/raw/master/LICENSE)
