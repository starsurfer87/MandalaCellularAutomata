
  
final int LEVELS = 7;
final int LEVEL_HEIGHT = 50;
final int SIZE = 2*LEVELS*LEVEL_HEIGHT + 50;

final int PURPLE = 0;
final int BLUE = 1;
final int PINK = 2;
final int ORANGE = 3;

int[][] cells;

void settings() {
   size(SIZE, SIZE);
}

void setup() { 
  cells = new int[LEVELS][];
  for (int i=0; i<LEVELS; i++) {
    cells[i] = new int[int(pow(2, i))];
    for (int j=0; j < cells[i].length; j++) {
      int mc;
      int num = j%4;
      switch (num) {
        case 0: 
          mc = PURPLE;
          break;
        case 1: 
          mc = BLUE;
          break;
        case 2:
          mc = PINK;
          break;
        default: 
          mc = ORANGE;
          break;
      }
      cells[i][j] = mc;
    }
  }
}

void draw() {
    for (int i=LEVELS-1; i>=0; i--) {
    int len = cells[i].length;
    for (int j=0; j < len; j++) { 
      fill(getColor(cells[i][j]));
      for (int k=0; k<8; k++) {
        arc(SIZE/2, SIZE/2, 2*(i+1)*LEVEL_HEIGHT, 2*(i+1)*LEVEL_HEIGHT, k*PI/4 + j*PI/(4*len), k*PI/4 + (j+1)*PI/(4*len));
      }
    }
  }
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
