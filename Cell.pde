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

    colour = BLACK;
  }

  boolean isAlive() {
    return alive;
  }

  void live() {
    alive = true;
    if (colour == BLACK) colour = color(random(MAX_COLOUR), random(MAX_COLOUR), random(MAX_COLOUR));
  }

  void die() {
    alive = false;
    colour = BLACK;
  }

  void draw(boolean filled) {
    if (filled) {
      noStroke();
      fill(colour);
    } else {
      stroke(colour);
      noFill();
    }

    pushMatrix();
    translate(x * size, y * size);
    rect(0, 0, size, size);
    popMatrix();
  }

}