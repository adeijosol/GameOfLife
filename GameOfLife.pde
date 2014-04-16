// NOTE Flashes of random background colours occur occasionally. Cause unknown.

// Change the following as preferred:
// ----------------------------------
final int SCREEN_WIDTH = 1366;
final int SCREEN_HEIGHT = 768;
final int GAME_DELAY = 100;
final int CELL_SIZE = 5;
final int CELL_PROBABILITY_TO_LIVE = 5;
// ----------------------------------


final int MAX_COLOUR_VALUE = 256;
final int BLACK = #000000;
final color UNSET_COLOUR = color(0, 0, 0);

boolean gameIsRunning = false; // Simulation is paused initially

int previousX = 0;
int previousY = 0;
int x = 0;
int y = 0;

color highlightColour;
Grid grid;


void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT); // Set up screen

  // Set up grid
  grid = new Grid(width, height, CELL_SIZE);
  grid.randomise();
  grid.draw();
}

void draw() {
  if (gameIsRunning) grid.update(); // Update grid only when simulation is running

  grid.draw();

  if (!gameIsRunning) { // When simulation is paused
    // Get grid coordinates
    x = grid.getCoordinate(mouseX);
    y = grid.getCoordinate(mouseY);

    if (x != previousX || y != previousY) { // Change highlight colour for different coordinates
      previousX = x;
      previousY = y;
      highlightColour = generateRandomColour();
    }

    grid.highlight(x, y, highlightColour); // Highlight cell
  }

  try {
    Thread.sleep(GAME_DELAY); // Slow simulation down
  } catch (InterruptedException e) {}
}

void keyPressed() {
  switch (key) {
    case 'p': // Pause simulation
      gameIsRunning = !gameIsRunning;
      break;
    case 'r': // Randomise grid
      grid.randomise();
      grid.draw();
      break;
    case 'f': // Toggle live cell fill
      grid.toggleFill();
      break;
    case 'q': // Quit
      exit();
      break;
  }
}

void mousePressed() {
  if (gameIsRunning) return; // Ignore mouse press when simulation is running

  switch (mouseButton) {
    case LEFT: // Create live cell
      grid.live(x, y, highlightColour);
      break;
    case RIGHT: // Remove live cell
      grid.die(x, y);
      break;
  }
}

color generateRandomColour() {
  return color(random(MAX_COLOUR_VALUE), random(MAX_COLOUR_VALUE), random(MAX_COLOUR_VALUE));
}