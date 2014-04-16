class Grid {

  int width;
  int height;
  int size;

  boolean filled;
  Cell[][] oldCells;
  Cell[][] cells;

  Grid(int width, int height, int size) {
    this.width = width / size;
    this.height = height / size;
    this.size = size;

    filled = true; // Fill live cells by default
    oldCells = new Cell[height][width];
    cells = new Cell[height][width];

    initialise();
  }

  void toggleFill() { // Toggle live cell fill
    filled = !filled;
  }

  int getCoordinate(int mouseCoordinate) { // Convert mouse to grid coordinate
    // x: [0, width / size)
    // y: [0, height / size)
    return (max(mouseCoordinate - size, -1) + 1) / size;
  }

  void initialise() { // Fill grid with cells by row simultaneously
    for (int y = 0; y < height; y++) {
      (new InitialiseThread(y)).start();
    }
  }

  void clear() { // Clear grid cells by row simultaneously
    for (int y = 0; y < height; y++) {
      (new ClearThread(y)).start();
    }
  }

  void randomise() { // Randomise cells' states by row simultaneously
    for (int y = 0; y < height; y++) {
      (new RandomiseThread(y)).start();
    }
  }

  void copy() { // Create copy of cells by row simultaneously
    // For pure calculation of the succeeding generation
    for (int y = 0; y < height; y++) {
      (new CopyThread(y)).start();
    }
  }

  void tick() { // Calculate next generation by row simultaneously
    for (int y = 0; y < height; y++) {
      (new TickThread(y)).start();
    }
  }

  void update() { // Update cells
    copy();
    tick();
  }

  void highlight(int x, int y, color colour) {
    cells[y][x].highlight(colour); // Highlight cell
  }

  void draw() {
    background(BLACK); // Overwrite previous grid

    for (int y = 0; y < height; y++) { // NOTE Cannot multi-thread cell drawing
      for (int x = 0; x < width; x++) {
        Cell cell = cells[y][x];
        if (cell.isAlive()) cell.draw(filled); // Only draw live cells
      }
    }
  }

  void live(int x, int y, color colour) {
    cells[y][x].live(colour); // Create live cell
  }

  void die(int x, int y) {
    cells[y][x].die(); // Kill cell
  }


  class InitialiseThread extends Thread {

    int y;

    InitialiseThread(int y) {
      this.y = y;
    }

    void run() { // Fill grid row with cells
      for (int x = 0; x < width; x++) {
        cells[y][x] = new Cell(x, y, size, false);
      }
    }

  }


  class ClearThread extends Thread {

    int y;

    ClearThread(int y) {
      this.y = y;
    }

    void run() { // Clear grid row cells
      for (int x = 0; x < width; x++) {
        cells[y][x].die();
      }
    }

  }


  class RandomiseThread extends Thread {

    int y;

    RandomiseThread(int y) {
      this.y = y;
    }

    void run() { // Randomise grid row cells' states
      for (int x = 0; x < width; x++) {
        if (int(random(CELL_PROBABILITY_TO_LIVE)) == 0) cells[y][x].live(UNSET_COLOUR);
        else cells[y][x].die();
      }
    }

  }


  class CopyThread extends Thread {

    int y;

    CopyThread(int y) {
      this.y = y;
    }

    void run() { // Create copy of grid row cells
      for (int x = 0; x < width; x++) {
        oldCells[y][x] = new Cell(x, y, size, cells[y][x].isAlive());
      }
    }

  }


  class TickThread extends Thread {

    int y;

    TickThread(int y) {
      this.y = y;
    }

    void run() { // Calculate grid row's next generation
      for (int x = 0; x < width; x++) {
        if (isAlive(x, y) && neighbours(x, y) < 2) {
          cells[y][x].die(); // Die of underpopulation
        } else if (isAlive(x, y) && neighbours(x, y) > 3) {
          cells[y][x].die(); // Die of overpopulation
        } else if (!isAlive(x, y) && neighbours(x, y) == 3) {
          cells[y][x].live(UNSET_COLOUR); // Live by reproduction
        }
      }
    }

    boolean isAlive(int x, int y) {
      return oldCells[y][x].isAlive();
    }

    int neighbours(int x, int y) { // Count cell's neighbours
      int neighbours = 0;

      for (int yi = y - 1; yi <= y + 1; yi++) { // NOTE Wrapping does not work due to multi-threading
        if (yi < 0 || yi >= height) continue; // Only count within the grid
        for (int xi = x - 1; xi <= x + 1; xi++) {
          if (xi < 0 || xi >= width) continue;
          if (xi == x && yi == y) continue; // Do not count the cell itself
          if (oldCells[yi][xi].isAlive()) neighbours++;
        }
      }

      return neighbours;
    }

  }


}