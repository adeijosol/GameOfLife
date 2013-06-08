class GameOfLifeGrid {

    int width;
    int height;
    int size;

    boolean[][] oldCells;
    boolean[][] cells;

    GameOfLifeGrid(int width, int height, int size) {
        this.width = width;
        this.height = height;
        this.size = size;

        oldCells = new boolean[height][width];
        cells = new boolean[height][width];

        gridFill(false);
    }

    void gridFill(boolean alive) {
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                cells[y][x] = alive;
            }
        }
    }

    void gridRandomise() {
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                if (int(random(2)) == 1) {
                    cells[y][x] = true;
                }
            }
        }
    }

    void gridCopy() {
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                oldCells[y][x] = cells[y][x];
            }
        }
    }

    void update() {
        gridCopy();
        tick();
    }

    void tick() {
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                if (alive(x, y) && neighbours(x, y) < 2) {
                    die(x, y);
                } else if (alive(x, y) && (neighbours(x, y) == 2 || neighbours(x, y) == 3)) {
                    live(x, y);
                } else if (alive(x, y) && neighbours(x, y) > 3) {
                    die(x, y);
                } else if (dead(x, y) && neighbours(x, y) == 3) {
                    live(x, y);
                }
            }
        }
    }

    int neighbours(int x, int y) {
        int neighbours = 0;

        for (int yi = y - 1; yi <= y + 1; yi++) {
            for (int xi = x - 1; xi <= x + 1; xi++) {
                if (xi < 0 || xi >= width || yi < 0 || yi >= height) continue;
                if (xi == x && yi == y) continue;
                if (oldCells[yi][xi]) neighbours++;
            }
        }

        return neighbours;
    }

    boolean alive(int x, int y) {
        return oldCells[y][x];
    }

    boolean dead(int x, int y) {
        return !oldCells[y][x];
    }

    void live(int x, int y) {
        cells[y][x] = true;
    }

    void die(int x, int y) {
        cells[y][x] = false;
    }

    void draw() {
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                if (cells[y][x]) {
                    rect(x * size, y * size, size, size);
                }
            }
        }
    }

}
