final int SCREEN_WIDTH = 1366;
final int SCREEN_HEIGHT = 768;
final int BLACK = #000000;
final int CYAN = #00FFFF;
final int DELAY = 100;

GameOfLifeGrid game;
boolean play;

void setup() {
    size(SCREEN_WIDTH, SCREEN_HEIGHT);
    stroke(CYAN);
    noFill();

    int cellSize = 5;
    int gridWidth = width / cellSize;
    int gridHeight = height / cellSize;

    game = new GameOfLifeGrid(gridWidth, gridHeight, cellSize);
    play = false;

    // Set initial pattern here...

    // Glider
    // game.live(1, 0);
    // game.live(2, 1);
    // game.live(0, 2);
    // game.live(1, 2);
    // game.live(2, 2);

    // Or randomise...

    game.gridRandomise();

    background(BLACK);
    game.draw();
}

void keyPressed() {
    if (key == ENTER || key == RETURN) {
        if (play) {
            play = false;
        } else {
            play = true;
        }
    }
}

void draw() {
    if (play) {
        try {
            Thread.sleep(DELAY);
        } catch (InterruptedException e) {
        }

        game.update();

        background(BLACK);
        game.draw();
    }
}
