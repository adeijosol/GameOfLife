class Cell {

  int x;
  int y;
  boolean alive;
  color colour;

  Cell(int x, int y, boolean alive) {
    this.x = x;
    this.y = y;
    this.alive = alive;
    colour = 0; // No colour
  }

  boolean isAlive() {
    return alive;
  }

  void live() {
    alive = true;
    colour = generateColour();
  }

  void live(color colour) {
    alive = true;
    this.colour = colour;
  }

  void die() {
    alive = false;
    colour = 0;
  }

  void highlight(color colour, int size) {
    this.colour = colour;
    draw(size);
  }

  void draw(int size) {
    fill(colour);
    ellipse(x * size, y * size, size, size);
  }
}
