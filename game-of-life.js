var colours = ['#ff4040', '#40ff40', '#0080ff', '#40ffff', '#ff40ff', '#ffff40'];
var backgroundColour = '#003040';
var animationDelay = 50;
var cellChanceToLive = 10;
var cellSize = 5;
var running = false;

var grid;
var x;
var y;
var prevX;
var prevY;

function setup() {
    createCanvas(windowWidth, windowHeight);
    noLoop();
    noStroke();
    grid = new Grid(windowWidth, windowHeight, cellSize);
    grid.randomise();
    grid.draw();
}

function draw() {
    if (running) {
        grid.update();
        grid.draw();
    }
    setTimeout(draw, animationDelay);
}

function keyPressed() {
    switch (key) {
        case 'P': // Resume/pause
            running = !running;
            break;
        case 'C': // Clear grid
            grid.clear();
            grid.draw();
            break;
        case 'R': // Randomise grid
            grid.randomise();
            grid.draw();
            break;
    }
}

function randomInt(upperBound) {
    return Math.floor(Math.random() * upperBound);
}

function generateColour() {
    return colours[randomInt(colours.length)];
}

function Grid(width, height, cellSize) {
    this.width = width / cellSize;
    this.height = height / cellSize;
    this.cellSize = cellSize;
    this.cells = this.create2DCellArray();
}

Grid.prototype.forEachCell = function(cellFunction) {
    for (var y = 0; y < this.height; y++) {
        for (var x = 0; x < this.width; x++) {
            cellFunction(this, x, y);
        }
    }
};

Grid.prototype.create2DCellArray = function() {
    var cells = [];
    for (var y = 0; y < this.height; y++) {
        cells[y] = [];
        for (var x = 0; x < this.width; x++) {
            cells[y][x] = new Cell(x, y);
        }
    }
    return cells;
};

Grid.prototype.countNeighbours = function(x, y) {
    var neighbours = 0;
    for (var j = y - 1; j <= y + 1; j++) {
        if (j < 0 || j >= this.height) {
            continue;
        }
        for (var i = x - 1; i <= x + 1; i++) {
            if (i < 0 || i >= this.width) {
                continue;
            } else if (i == x && j == y) {
                continue;
            } else if (this.cells[j][i].isAlive()) {
                neighbours++;
            }
        }
    }
    return neighbours;
};

Grid.prototype.clear = function() {
    this.forEachCell(function(grid, x, y) {
        grid.cells[y][x].die();
    });
};

Grid.prototype.randomise = function() {
    this.forEachCell(function(grid, x, y) {
        if (randomInt(cellChanceToLive) == 0) {
            grid.cells[y][x].live();
        } else {
            grid.cells[y][x].die();
        }
    });
};

Grid.prototype.update = function() { // Calculate next generation
    this.forEachCell(function(grid, x, y) {
        grid.cells[y][x].setNeighbours(grid.countNeighbours(x, y));
    });
    this.forEachCell(function(grid, x, y) {
        var cell = grid.cells[y][x];
        if (cell.isAlive() && cell.getNeighbours() < 2) {
            cell.die(); // Die from underpopulation
        } else if (cell.isAlive() && cell.getNeighbours() > 3) {
            cell.die(); // Die from overpopulation
        } else if (!cell.isAlive() && cell.getNeighbours() == 3) {
            cell.live(); // Live by reproduction
        }
    });
};

Grid.prototype.draw = function() {
    background(backgroundColour);
    this.forEachCell(function(grid, x, y) {
        var cell = grid.cells[y][x];
        if (cell.isAlive()) {
            cell.draw(grid.cellSize);
        }
    });
};

function Cell(x, y) {
    this.x = x;
    this.y = y;
}

Cell.prototype.isAlive = function() {
    return this.alive;
};

Cell.prototype.getNeighbours = function() {
    return this.neighbours;
};

Cell.prototype.setNeighbours = function(neighbours) {
    this.neighbours = neighbours;
};

Cell.prototype.live = function() {
    this.alive = true;
    this.colour = generateColour();
};

Cell.prototype.die = function() {
    this.alive = false;
    this.colour = backgroundColour;
};

Cell.prototype.draw = function(size) {
    fill(this.colour);
    ellipse(this.x * size, this.y * size, size, size);
};
