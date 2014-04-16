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
    colour = UNSET_COLOUR;
  }

  boolean isAlive() {
    return alive;
  }

  void live(color colour) { // Create cell
    alive = true;
    this.colour = (colour == UNSET_COLOUR) ? generateRandomColour() : colour;
  }

  void die() { // Kill cell
    alive = false;
    colour = UNSET_COLOUR;
  }

  void highlight(color colour) {
    this.colour = colour;
    draw(true); // Draw highlighted (filled) cell
  }

  void draw(boolean filled) {
    if (filled) { // Draw filled cell
      noStroke();
      fill(colour);
    } else { // Draw cell outline
      stroke(colour);
      noFill();
    }

    // Draw cell
    pushMatrix();
    translate(x * size, y * size);
    rect(0, 0, size, size);
    popMatrix();
  }

}