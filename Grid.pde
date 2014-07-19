class Grid {

  int width;
  int height;
  int cellSize;
  Cell[][] cells;
  Cell[][] prevCells;

  Grid(int width, int height, int cellSize) {
    this.width = width / cellSize;
    this.height = height / cellSize;
    this.cellSize = cellSize;
    cells = new Cell[height][width];
    prevCells = new Cell[height][width];

    initialise();
  }

  int getCoordinate(int mouseCoordinate) { // Convert mouse position to grid coordinate
    // x: [0, width / cellSize), y: [0, height / cellSize)
    return (max(mouseCoordinate - cellSize, -1) + 1) / cellSize;
  }

  void initialise() { // Fill grid with cells
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        cells[y][x] = new Cell(x, y, false);
      }
    }
  }

  void clear() {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        cells[y][x].die();
      }
    }
  }

  void randomise() {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        if (int(random(CELL_CHANCE_TO_LIVE)) == 0) {
          cells[y][x].live();
        } else {
          cells[y][x].die();
        }
      }
    }
  }

  void update() {
    for (int y = 0; y < height; y++) { // Copy cells to calculate the next generation
      for (int x = 0; x < width; x++) {
        prevCells[y][x] = new Cell(x, y, cells[y][x].isAlive());
      }
    }

    for (int y = 0; y < height; y++) { // Calculate next generation
      for (int x = 0; x < width; x++) {
        if (isAlive(x, y) && neighbours(x, y) < 2) {
          cells[y][x].die(); // Die of underpopulation
        } else if (isAlive(x, y) && neighbours(x, y) > 3) {
          cells[y][x].die(); // Die of overpopulation
        } else if (!isAlive(x, y) && neighbours(x, y) == 3) {
          cells[y][x].live(); // Live by reproduction
        }
      }
    }
  }

  boolean isAlive(int x, int y) {
    return prevCells[y][x].isAlive();
  }

  int neighbours(int x, int y) {
    int neighbours = 0;

    for (int yi = y - 1; yi <= y + 1; yi++) {
      if (yi < 0 || yi >= height) {
        continue;
      }
      for (int xi = x - 1; xi <= x + 1; xi++) {
        if (xi < 0 || xi >= width) {
          continue;
        } else if (xi == x && yi == y) {
          continue;
        } else if (prevCells[yi][xi].isAlive()) {
          neighbours++;
        }
      }
    }

    return neighbours;
  }

  void draw() {
    background(#000000); // Draw over previous grid
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        Cell cell = cells[y][x];
        if (cell.isAlive()) {
          cell.draw(cellSize);
        }
      }
    }
  }

  void highlightCell(int x, int y, color colour) {
    cells[y][x].highlight(colour, cellSize);
  }

  void addLiveCell(int x, int y, color colour) {
    cells[y][x].live(colour);
  }

  void killCell(int x, int y) {
    cells[y][x].die();
  }
}
