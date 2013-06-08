final int SCREEN_WIDTH = 1366;
final int SCREEN_HEIGHT = 768;

final int BLACK = #000000;
final int ELECTRIC_BLUE = #00C0FF;
final int CYAN = #00FFFF;

final int DELAY = 100;

int cellSize = 5;

GameOfLifeGrid game;
boolean play;

void setup() {
    size(SCREEN_WIDTH, SCREEN_HEIGHT);

    int gridWidth = width / cellSize;
    int gridHeight = height / cellSize;

    game = new GameOfLifeGrid(gridWidth, gridHeight, cellSize);

    // Set initial pattern here...
    // Glider
    // game.live(1, 0);
    // game.live(2, 1);
    // game.live(0, 2);
    // game.live(1, 2);
    // game.live(2, 2);

    // Or randomise...
    game.gridRandomise();

    play();

    background(BLACK);
    game.draw();

    pause();
}

void play() {
    play = true;
    stroke(CYAN);
    noFill();
}

void pause() {
    play = false;
    fill(ELECTRIC_BLUE);
    noStroke();
}

void keyPressed() {
    if (key == ENTER || key == RETURN) {
        if (play) {
            pause();
        } else {
            play();
        }
    }
}

void draw() {
    if (play) {
        try {
            Thread.sleep(DELAY);
        } catch (InterruptedException e) {}

        game.update();

        background(BLACK);
        game.draw();
    }
}
