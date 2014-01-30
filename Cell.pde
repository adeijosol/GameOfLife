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

    colour = RANDOM;
  }

  boolean isAlive() {
    return alive;
  }

  void live(color colour) {
    alive = true;
    this.colour = (colour == RANDOM) ? generateRandomColour() : colour;
  }

  void die() {
    alive = false;
    colour = RANDOM;
  }

  void highlight(color colour) {
    this.colour = colour;
    draw(true);
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