final int WIDTH = 1366;
final int HEIGHT = 768;
final int ANIMATION_DELAY = 100;
final int CELL_SIZE = 5;
final int CELL_CHANCE_TO_LIVE = 10;
final color[] COLOURS = {
  #FF0000, #00FF00, #0000FF, #00FFFF, #FF00FF, #FFFF00
};

boolean running;
int x;
int y;
int prevX;
int prevY;

Grid grid;
color highlight;

void setup() {
  running = false;
  x = 0;
  y = 0;
  prevX = 0;
  prevY = 0;

  size(WIDTH, HEIGHT);
  grid = new Grid(width, height, CELL_SIZE);
  grid.randomise();
}

void draw() {
  if (running) {
    grid.update();
  }
  grid.draw();

  if (!running) {
    x = grid.getCoordinate(mouseX);
    y = grid.getCoordinate(mouseY);

    if (x != prevX || y != prevY) { // Change highlight for different cells
      prevX = x;
      prevY = y;
      highlight = generateColour();
    }

    grid.highlightCell(x, y, highlight);
  }

  try {
    Thread.sleep(ANIMATION_DELAY);
  } catch (InterruptedException e) {
  }
}

void keyPressed() {
  switch (key) {
    case 'p': // Resume/pause
      running = !running;
      break;
    case 'c': // Clear grid
      grid.clear();
      grid.draw();
      break;
    case 'r': // Randomise grid
      grid.randomise();
      grid.draw();
      break;
    case 'q': // Quit
      exit();
      break;
  }
}

void mousePressed() {
  if (running) {
    return;
  }

  switch (mouseButton) {
    case LEFT:
      grid.addLiveCell(x, y, highlight);
      break;
    case RIGHT:
      grid.killCell(x, y);
      break;
  }
}

color generateColour() {
  return COLOURS[int(random(COLOURS.length))];
}
