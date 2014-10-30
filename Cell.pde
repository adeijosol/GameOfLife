private class Cell {

    private final int mX;
    private final int mY;

    private boolean mAlive;
    private color mColour;

    Cell(int x, int y, boolean alive) {
        mX = x;
        mY = y;
        mAlive = alive;
        mColour = 0; // No colour
    }

    boolean isAlive() {
        return mAlive;
    }

    void live() {
        mAlive = true;
        mColour = generateColour();
    }

    void live(color colour) {
        mAlive = true;
        mColour = colour;
    }

    void die() {
        mAlive = false;
        mColour = 0;
    }

    void highlight(color colour, int size) {
        mColour = colour;
        draw(size);
    }

    void draw(int size) {
        fill(mColour);
        ellipse(mX * size, mY * size, size, size);
    }
}
