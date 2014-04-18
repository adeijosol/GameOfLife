// Modify these as preferred:
// --------------------------
final int SCREEN_WIDTH = 1366;
final int SCREEN_HEIGHT = 768;
final int ANIMATION_DELAY = 100;
final int CELL_SIZE = 5;
final int CELL_PROBABILITY_TO_LIVE = 10;
// --------------------------


final int MAX_COLOUR_VALUE = 256;

boolean simulationIsRunning = false;
int previousX = 0;
int previousY = 0;
int x = 0;
int y = 0;

color highlightColour;
Grid grid;


void setup() {
  noStroke();
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  grid = new Grid(width, height, CELL_SIZE);
  grid.randomise();
}

void draw() {
  if (simulationIsRunning) grid.update();

  grid.draw();

  if (!simulationIsRunning) {
    x = grid.getCoordinate(mouseX);
    y = grid.getCoordinate(mouseY);

    if (x != previousX || y != previousY) { // Change highlight colour for different cells
      previousX = x;
      previousY = y;
      highlightColour = generateRandomColour();
    }

    grid.highlightCell(x, y, highlightColour);
  }

  try {
    Thread.sleep(ANIMATION_DELAY);
  } catch (InterruptedException e) {}
}

void keyPressed() {
  switch (key) {
    case 'p': // Resume/pause simulation
      simulationIsRunning = !simulationIsRunning;
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
  if (simulationIsRunning) return;

  switch (mouseButton) {
    case LEFT:
      grid.addLiveCell(x, y, highlightColour);
      break;
    case RIGHT:
      grid.removeLiveCell(x, y);
      break;
  }
}

color generateRandomColour() {
  return color(random(MAX_COLOUR_VALUE), random(MAX_COLOUR_VALUE), random(MAX_COLOUR_VALUE));
}
