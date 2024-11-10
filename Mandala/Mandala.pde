

final int LEVELS = 7;
final int LEVEL_HEIGHT = 50;
final int SIZE = 2*LEVELS*LEVEL_HEIGHT;

final int PURPLE = 0;
final int BLUE = 1;
final int PINK = 2;
final int ORANGE = 3;

final float PROB = 0.5;

int[][] cells;

void settings() {
  size(SIZE, SIZE);
}

void setup() {
  cells = new int[LEVELS][];
  for (int i=0; i<LEVELS; i++) {
    cells[i] = new int[int(pow(2, i))];
    for (int j=0; j < cells[i].length; j++) {
      cells[i][j] = PURPLE;
    }
  }
}

void draw() {
  for (int i=LEVELS-1; i>=0; i--) {
    int len = cells[i].length;
    for (int j=0; j < len; j++) {
      fill(getColor(cells[i][j]));
      for (int k=0; k<8; k++) {
        arc(SIZE/2, SIZE/2, (2*(i+1)-1)*LEVEL_HEIGHT, (2*(i+1)-1)*LEVEL_HEIGHT, k*PI/4 + j*PI/(4*len), k*PI/4 + (j+1)*PI/(4*len));
      }
    }
  }
  updateCells();
}

color getColor(int c) {
  switch (c) {
  case PURPLE:
    return color(60, 22, 66);
  case BLUE:
    return color(114, 221, 247);
  case PINK:
    return color(213, 106, 160);
  default:
    return color(255, 159, 28);
  }
}

void updateCells() {
  for (int i=0; i<LEVELS; i++) {
    int len = cells[i].length;
    for (int j=0; j < len; j++) {
      updateCell(i, j);
    }
  }
}

// CONSTRAINT: cells[i][j] must be in bounds
void updateCell(int i, int j) {
  if (i==0) {
    cells[i][j] = floor(random(5));
  } else if (random(1) < PROB) {
    int cb = colorBelow(i, j);
    int cd = colorDiagonal(i, j);
    if (cb != PURPLE) {
      cells[i][j] = cb;
    } else {
      cells[i][j] = cd;
    }
  }
}

// CONSTRAINT: i != 0, and cells[i][j] must be in bounds
int colorBelow(int i, int j) {
  return cells[i-1][j/2];
}

// CONSTRAINT: i != 0, and cells[i][j] must be in bounds
int colorDiagonal(int i, int j) {
  int len = int(pow(2, i-1));
  if (j%2==0) {
    return cells[i-1][(j/2 - 1 + len) % len];
  } else {
    return cells[i-1][(j/2 + 1) % len];
  }
}
