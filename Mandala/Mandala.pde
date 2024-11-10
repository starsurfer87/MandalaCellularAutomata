

final int LEVELS = 7;
final int LEVEL_HEIGHT = 50;
final int SIZE = 2*LEVELS*LEVEL_HEIGHT;

final int DEFAULT = 0;
final int BLUE = 1;
final int PINK = 2;
final int GREEN = 3;

final float PROB_DOWN = 0.5;
final float PROB_DIAG = 0.8;

int[][] cells;

void settings() {
  size(SIZE, SIZE);
}

void setup() {
  stroke(getColor(DEFAULT));
  cells = new int[LEVELS][];
  for (int i=0; i<LEVELS; i++) {
    cells[i] = new int[int(pow(2, i))];
    for (int j=0; j < cells[i].length; j++) {
      cells[i][j] = DEFAULT;
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
  case BLUE:
    return #18C6F2;
  case PINK:
    return #EE589E;
  case GREEN:
    return #90F750;
  default:
    return #0E132F;
  }
}

void updateCells() {
  for (int i=LEVELS-1; i>=0; i--) {
    int len = cells[i].length;
    for (int j=0; j < len; j++) {
      updateCell(i, j);
    }
  }
}

// CONSTRAINT: cells[i][j] must be in bounds
void updateCell(int i, int j) {
  if (i==0) {
    cells[i][j] = floor(random(4));
  } else {
    int cb = colorBelow(i, j);
    if (cb != DEFAULT) {
      if (random(1) < PROB_DOWN) {
        cells[i][j] = cb;
      }
    } else {
      if (random(1) < PROB_DIAG) {
        int cd = colorDiagonal(i, j);
        cells[i][j] = cd;
      }
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
