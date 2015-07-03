private static final color[] COLOURS = {#FF0000, #00FF00, #0000FF, #00FFFF, #FF00FF, #FFFF00};
private static final color BACKGROUND = #000000;
private static final int ANIMATION_DELAY = 100;
private static final int CELL_CHANCE_TO_LIVE = 10;
private static final int CELL_SIZE = 5;

private Grid mGrid;
private color mHighlight;
private boolean mRunning;
private int mX;
private int mY;
private int mPrevX;
private int mPrevY;

@Override
void setup() {
    size(displayWidth, displayHeight);
    noStroke();
    mGrid = new Grid(width, height, CELL_SIZE);
    mGrid.randomise();
}

@Override
void draw() {
    if (mRunning) {
        mGrid.update();
    }
    mGrid.draw();

    if (!mRunning) {
        mX = mGrid.getCoordinate(mouseX);
        mY = mGrid.getCoordinate(mouseY);

        if (mX != mPrevX || mY != mPrevY) { // Change highlight for different cells
            mPrevX = mX;
            mPrevY = mY;
            mHighlight = generateColour();
        }

        mGrid.highlightCell(mX, mY, mHighlight);
    }

    try {
        Thread.sleep(ANIMATION_DELAY);
    } catch (InterruptedException e) {}
}

@Override
void keyPressed() {
    switch (key) {
        case 'p': // Resume/pause
            mRunning = !mRunning;
            break;
        case 'c': // Clear grid
            mGrid.clear();
            mGrid.draw();
            break;
        case 'r': // Randomise grid
            mGrid.randomise();
            mGrid.draw();
            break;
        case 'q': // Quit
            exit();
            break;
    }
}

@Override
void mousePressed() {
    if (mRunning) {
        return;
    }

    switch (mouseButton) {
        case LEFT:
            mGrid.addLiveCell(mX, mY, mHighlight);
            break;
        case RIGHT:
            mGrid.killCell(mX, mY);
            break;
    }
}

private color generateColour() {
    return COLOURS[int(random(COLOURS.length))];
}
