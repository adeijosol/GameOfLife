final int SCREEN_WIDTH = 1366;
final int SCREEN_HEIGHT = 768;

final int MAX_COLOUR = 256;
final int BLACK = #000000;
final color RANDOM = color(0, 0, 0);

final int DELAY = 100;

boolean running = false;
color colour = BLACK;

Grid grid;

void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  background(BLACK);

  int cellSize = 5;

  grid = new Grid(width, height, cellSize);

  grid.randomise();
  grid.draw();
}

void draw() {
  if (running) grid.update();
  grid.draw();

  try {
    Thread.sleep(DELAY);
  } catch (InterruptedException e) {}
}

void keyPressed() {
  switch (key) {
    case 'p':
      running = !running;
      break;
    case 'r':
      grid.randomise();
      grid.draw();
      break;
    case 'f':
      grid.toggleFill();
      break;
  }
}

void mousePressed() {
  if (running) return;

  int x = grid.getCoordinate(mouseX);
  int y = grid.getCoordinate(mouseY);

  switch (mouseButton) {
    case LEFT:
      grid.live(x, y, colour);
      break;
    case RIGHT:
      grid.die(x, y);
      break;
  }

  grid.highlight(x, y, colour);
}

void mouseMoved() {
  if (running) return;

  int x = grid.getCoordinate(mouseX);
  int y = grid.getCoordinate(mouseY);

  colour = color(random(MAX_COLOUR), random(MAX_COLOUR), random(MAX_COLOUR));

  grid.highlight(x, y, colour);
}