private interface CellRunnable {
    void run(int x, int y);
}

private class Grid {

    private final int mWidth;
    private final int mHeight;
    private final int mCellSize;
    private final Cell[][] mCells;

    Grid(int width, int height, int cellSize) {
        mWidth = width / cellSize;
        mHeight = height / cellSize;
        mCellSize = cellSize;
        mCells = new Cell[height][width];
        initialise();
    }

    private void forEachCell(CellRunnable cellRunnable) {
        for (int y = 0; y < mHeight; y++) {
            for (int x = 0; x < mWidth; x++) {
                cellRunnable.run(x, y);
            }
        }
    }

    private void initialise() { // Fill grid with cells
        forEachCell(new CellRunnable() {
            @Override
            public void run(int x, int y) {
                mCells[y][x] = new Cell(x, y);
            }
        });
    }

    private int countNeighbours(int x, int y) {
        int neighbours = 0;
        for (int j = y - 1; j <= y + 1; j++) {
            if (j < 0 || j >= mHeight) {
                continue;
            }
            for (int i = x - 1; i <= x + 1; i++) {
                if (i < 0 || i >= mWidth) {
                    continue;
                } else if (i == x && j == y) {
                    continue;
                } else if (mCells[j][i].isAlive()) {
                    neighbours++;
                }
            }
        }
        return neighbours;
    }

    int getCoordinate(int mouseCoordinate) { // Convert mouse position to grid coordinate
        // x: [0, mWidth / mCellSize), y: [0, mHeight / mCellSize)
        return (max(mouseCoordinate - mCellSize, -1) + 1) / mCellSize;
    }

    void clear() {
        forEachCell(new CellRunnable() {
            @Override
            public void run(int x, int y) {
                mCells[y][x].die();
            }
        });
    }

    void randomise() {
        forEachCell(new CellRunnable() {
            @Override
            public void run(int x, int y) {
                if (randomInt(CELL_CHANCE_TO_LIVE) == 0) {
                    mCells[y][x].live();
                } else {
                    mCells[y][x].die();
                }
            }
        });
    }

    void update() { // Calculate next generation
        forEachCell(new CellRunnable() {
            @Override
            public void run(int x, int y) {
                mCells[y][x].setNeighbours(countNeighbours(x, y));
            }
        });
        forEachCell(new CellRunnable() {
            @Override
            public void run(int x, int y) {
                Cell cell = mCells[y][x];
                if (cell.isAlive() && cell.getNeighbours() < 2) {
                    cell.die(); // Die from underpopulation
                } else if (cell.isAlive() && cell.getNeighbours() > 3) {
                    cell.die(); // Die from overpopulation
                } else if (!cell.isAlive() && cell.getNeighbours() == 3) {
                    cell.live(); // Live by reproduction
                }
            }
        });
    }

    void draw() {
        background(BACKGROUND);
        forEachCell(new CellRunnable() {
            @Override
            public void run(int x, int y) {
                Cell cell = mCells[y][x];
                if (cell.isAlive()) {
                    cell.draw(mCellSize);
                }
            }
        });
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
