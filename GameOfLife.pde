private static final color[] COLOURS = {#FF0000, #00FF00, #0000FF, #00FFFF, #FF00FF, #FFFF00};
private static final int ANIMATION_DELAY = 100;
private static final int CELL_CHANCE_TO_LIVE = 10;
private static final int CELL_SIZE = 5;

private Grid grid;
private color highlight;
private boolean running;
private int x;
private int y;
private int prevX;
private int prevY;

@Override
void setup() {
    size(displayWidth, displayHeight);
    grid = new Grid(width, height, CELL_SIZE);
    grid.randomise();
}

@Override
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

@Override
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

@Override
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
