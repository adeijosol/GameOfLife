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

    filled = true;
    oldCells = new Cell[height][width];
    cells = new Cell[height][width];

    initialise();
  }

  void toggleFill() {
    filled = !filled;
  }

  int getCoordinate(int coordinate) {
    return (max(coordinate - size, -1) + 1) / size;
  }

  void initialise() {
    for (int y = 0; y < height; y++) {
      (new InitialiseThread(y)).start();
    }
  }

  void randomise() {
    for (int y = 0; y < height; y++) {
      (new RandomiseThread(y)).start();
    }
  }

  void copy() {
    for (int y = 0; y < height; y++) {
      (new CopyThread(y)).start();
    }
  }

  void tick() {
    for (int y = 0; y < height; y++) {
      (new TickThread(y)).start();
    }
  }

  void update() {
    copy();
    tick();
  }

  void highlight(int x, int y, color colour) {
    cells[y][x].highlight(colour);
  }

  void draw() {
    background(BLACK);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        Cell cell = cells[y][x];
        if (cell.isAlive()) cell.draw(filled);
      }
    }
  }

  void live(int x, int y, color colour) {
    cells[y][x].live(colour);
  }

  void die(int x, int y) {
    cells[y][x].die();
  }

  class InitialiseThread extends Thread {

    int y;

    InitialiseThread(int y) {
      this.y = y;
    }

    void run() {
      for (int x = 0; x < width; x++) {
        cells[y][x] = new Cell(x, y, size, false);
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
        if (int(random(5)) == 0) cells[y][x].live(RANDOM);
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
        oldCells[y][x] = new Cell(x, y, size, cells[y][x].isAlive());
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
          cells[y][x].die();
        } else if (isAlive(x, y) && (neighbours(x, y) == 2 || neighbours(x, y) == 3)) {
          cells[y][x].live(RANDOM);
        } else if (isAlive(x, y) && neighbours(x, y) > 3) {
          cells[y][x].die();
        } else if (!isAlive(x, y) && neighbours(x, y) == 3) {
          cells[y][x].live(RANDOM);
        }
      }
    }

    boolean isAlive(int x, int y) {
      return oldCells[y][x].isAlive();
    }

    int neighbours(int x, int y) {
      int neighbours = 0;

      for (int yi = y - 1; yi <= y + 1; yi++) {
        if (yi < 0 || yi >= height) continue;
        for (int xi = x - 1; xi <= x + 1; xi++) {
          if (xi < 0 || xi >= width) continue;
          if (xi == x && yi == y) continue;
          if (oldCells[yi][xi].isAlive()) neighbours++;
        }
      }

      return neighbours;
    }

  }

}