private class Grid {

    private int mWidth;
    private int mHeight;
    private int mCellSize;
    private Cell[][] mCells;
    private Cell[][] mPrevCells;

    Grid(int width, int height, int cellSize) {
        mWidth = width / cellSize;
        mHeight = height / cellSize;
        mCellSize = cellSize;
        mCells = new Cell[height][width];
        mPrevCells = new Cell[height][width];
        initialise();
    }

    private void initialise() { // Fill grid with cells
        for (int y = 0; y < mHeight; y++) {
            for (int x = 0; x < mWidth; x++) {
                mCells[y][x] = new Cell(x, y, false);
            }
        }
    }

    private int neighbours(int x, int y) {
        int neighbours = 0;
        for (int yi = y - 1; yi <= y + 1; yi++) {
            if (yi < 0 || yi >= mHeight) {
                continue;
            }
            for (int xi = x - 1; xi <= x + 1; xi++) {
                if (xi < 0 || xi >= mWidth) {
                    continue;
                } else if (xi == x && yi == y) {
                    continue;
                } else if (mPrevCells[yi][xi].isAlive()) {
                    neighbours++;
                }
            }
        }
        return neighbours;
    }

    private boolean isAlive(int x, int y) {
        return mPrevCells[y][x].isAlive();
    }

    int getCoordinate(int mouseCoordinate) { // Convert mouse position to grid coordinate
        // x: [0, mWidth / mCellSize), y: [0, mHeight / mCellSize)
        return (max(mouseCoordinate - mCellSize, -1) + 1) / mCellSize;
    }

    void clear() {
        for (int y = 0; y < mHeight; y++) {
            for (int x = 0; x < mWidth; x++) {
                mCells[y][x].die();
            }
        }
    }

    void randomise() {
        for (int y = 0; y < mHeight; y++) {
            for (int x = 0; x < mWidth; x++) {
                if (int(random(CELL_CHANCE_TO_LIVE)) == 0) {
                    mCells[y][x].live();
                } else {
                    mCells[y][x].die();
                }
            }
        }
    }

    void update() {
        for (int y = 0; y < mHeight; y++) { // Copy cells to calculate the next generation
            for (int x = 0; x < mWidth; x++) {
                mPrevCells[y][x] = new Cell(x, y, mCells[y][x].isAlive());
            }
        }
        for (int y = 0; y < mHeight; y++) { // Calculate next generation
            for (int x = 0; x < mWidth; x++) {
                if (isAlive(x, y) && neighbours(x, y) < 2) {
                    mCells[y][x].die(); // Die of underpopulation
                } else if (isAlive(x, y) && neighbours(x, y) > 3) {
                    mCells[y][x].die(); // Die of overpopulation
                } else if (!isAlive(x, y) && neighbours(x, y) == 3) {
                    mCells[y][x].live(); // Live by reproduction
                }
            }
        }
    }

    void draw() {
        background(#000000); // Draw over previous grid
        for (int y = 0; y < mHeight; y++) {
            for (int x = 0; x < mWidth; x++) {
                Cell cell = mCells[y][x];
                if (cell.isAlive()) {
                    cell.draw(mCellSize);
                }
            }
        }
    }

    void highlightCell(int x, int y, color colour) {
        mCells[y][x].highlight(colour, mCellSize);
    }

    void addLiveCell(int x, int y, color colour) {
        mCells[y][x].live(colour);
    }

    void killCell(int x, int y) {
        mCells[y][x].die();
    }
}
