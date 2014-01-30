class Cell {

  int x;
  int y;
  int size;
  boolean alive;

  Cell(int x, int y, int size, boolean alive) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.alive = alive;
  }

  boolean isAlive() {
    return alive;
  }

  void live() {
    alive = true;
  }

  void die() {
    alive = false;
  }

  void draw() {
    pushMatrix();
    translate(x * size, y * size);
    rect(0, 0, size, size);
    popMatrix();
  }

}