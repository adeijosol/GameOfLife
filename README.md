# Game of Life
An implementation of Conway's Game of Life in Processing.

![Screenshot of GameOfLife](https://github.com/adeijosol/GameOfLife/raw/master/screenshot.png)

## Controls
`p` - Resume/pause the simulation  
`c` - Clear the grid  
`r` - Randomise the grid (generate a new seed)  
`q` - Quit

When the simulation is paused, the cell pointed to by the cursor becomes highlighted.

`left-click` - Make the highlighted cell live  
`right-click` - Make the highlighted cell die

Mouse events are ignored when the simulation is running.

## Parameters
Modify the following in [`GameOfLife.pde`](https://github.com/adeijosol/GameOfLife/raw/master/GameOfLife.pde) as preferred:
- `SCREEN_WIDTH`
- `SCREEN_HEIGHT`
- `ANIMATION_DELAY`
- `CELL_SIZE`
- `CELL_PROBABILITY_TO_LIVE`
  - Relevant only when randomising the grid
  - Must be greater than 0
  - 1 = 100%, 2 = 50%, 4 = 25%, etc.

## Notes
- The simulation starts with a random seed.
- When there are many live cells, flashes of random background colours occur occasionally.

## License
[MIT License](https://github.com/adeijosol/GameOfLife/raw/master/LICENSE)
