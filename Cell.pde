private class Cell {

    private final int mX;
    private final int mY;

    private boolean mAlive;
    private color mColour;
    private int mNeighbours;

    Cell(int x, int y) {
        mX = x;
        mY = y;
    }

    Cell(int x, int y, boolean alive) {
        this(x, y);
        mAlive = alive;
    }

    boolean isAlive() {
        return mAlive;
    }

    int getNeighbours() {
        return mNeighbours;
    }

    void setNeighbours(int neighbours) {
        mNeighbours = neighbours;
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
        mColour = BACKGROUND;
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
