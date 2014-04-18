class Cell {

  int x;
  int y;
  int size;
  boolean alive;
  color colour;

  Cell(int x, int y, int size, boolean alive) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.alive = alive;
    colour = 0; // No colour
  }

  boolean isAlive() {
    return alive;
  }

  void live() {
    alive = true;
    this.colour = generateRandomColour();
  }

  void live(color colour) {
    alive = true;
    this.colour = colour;
  }

  void die() {
    alive = false;
    colour = 0;
  }

  void highlight(color colour) {
    this.colour = colour;
    draw();
  }

  void draw() {
    fill(colour);
    pushMatrix();
    translate(x * size, y * size);
    rect(0, 0, size, size);
    popMatrix();
  }
}