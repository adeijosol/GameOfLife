class Grid {

  final color BLACK = color(0, 0, 0);

  int width;
  int height;
  int cellSize;
  Cell[][] previousCells;
  Cell[][] cells;

  Grid(int width, int height, int cellSize) {
    this.width = width / cellSize;
    this.height = height / cellSize;
    this.cellSize = cellSize;
    previousCells = new Cell[height][width];
    cells = new Cell[height][width];

    initialise();
  }

  int getCoordinate(int mouseCoordinate) { // Convert mouse position to grid coordinate
    // x: [0, width / cellSize), y: [0, height / cellSize)
    return (max(mouseCoordinate - cellSize, -1) + 1) / cellSize;
  }

  void initialise() { // Fill grid with cells
    for (int y = 0; y < height; y++) {
      (new InitialiseThread(y)).start();
    }
  }

  void clear() {
    for (int y = 0; y < height; y++) {
      (new ClearThread(y)).start();
    }
  }

  void randomise() {
    for (int y = 0; y < height; y++) {
      (new RandomiseThread(y)).start();
    }
  }

  void update() {
    for (int y = 0; y < height; y++) { // Copy cells to purely calculate the next generation
      (new CopyThread(y)).start();
    }

    for (int y = 0; y < height; y++) { // Calculate next generation
      (new TickThread(y)).start();
    }
  }

  void draw() {
    background(BLACK); // Draw over previous grid
    for (int y = 0; y < height; y++) { // NOTE Cannot multithread cell drawing
      for (int x = 0; x < width; x++) {
        Cell cell = cells[y][x];
        if (cell.isAlive()) cell.draw();
      }
    }
  }

  void highlightCell(int x, int y, color colour) {
    cells[y][x].highlight(colour);
  }

  void addLiveCell(int x, int y, color colour) {
    cells[y][x].live(colour);
  }

  void removeLiveCell(int x, int y) {
    cells[y][x].die();
  }


  class InitialiseThread extends Thread {

    int y;

    InitialiseThread(int y) {
      this.y = y;
    }

    void run() {
      for (int x = 0; x < width; x++) {
        cells[y][x] = new Cell(x, y, cellSize, false);
      }
    }

  }


  class ClearThread extends Thread {

    int y;

    ClearThread(int y) {
      this.y = y;
    }

    void run() {
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

    void run() {
      for (int x = 0; x < width; x++) {
        if (int(random(CELL_PROBABILITY_TO_LIVE)) == 0) cells[y][x].live();
        else cells[y][x].die();
      }
    }

  }


  class CopyThread extends Thread {

    int y;

    CopyThread(int y) {
      this.y = y;
    }

    void run() {
      for (int x = 0; x < width; x++) {
        previousCells[y][x] = new Cell(x, y, cellSize, cells[y][x].isAlive());
      }
    }

  }


  class TickThread extends Thread {

    int y;

    TickThread(int y) {
      this.y = y;
    }

    void run() {
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

    boolean isAlive(int x, int y) {
      return previousCells[y][x].isAlive();
    }

    int neighbours(int x, int y) {
      int neighbours = 0;

      for (int yi = y - 1; yi <= y + 1; yi++) { // NOTE Wrapping does not work due to multithreading
        if (yi < 0 || yi >= height) continue;
        for (int xi = x - 1; xi <= x + 1; xi++) {
          if (xi < 0 || xi >= width) continue;
          if (xi == x && yi == y) continue;
          if (previousCells[yi][xi].isAlive()) neighbours++;
        }
      }

      return neighbours;
    }

  }


}