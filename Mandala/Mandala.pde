
final int LEVELS = 4;
final int LEVEL_HEIGHT = 75;
final int SIZE = 2*LEVELS*LEVEL_HEIGHT + 50;

int[][] cells;
int k, j;

void settings() {
   size(SIZE, SIZE);
}

void setup() { 
  cells = new int[LEVELS][];
  for (int i=0; i<LEVELS; i++) {
    cells[i] = new int[int(pow(2, i))];
  }
  
  for (int i=LEVELS-1; i>=0; i--) {
    int len = cells[i].length;
    for (int j=0; j < len; j++) { 
      color c = color(255, 30, 30+j*30);  
      fill(c); 
      for (int k=0; k<8; k++) {
        arc(SIZE/2, SIZE/2, 2*(i+1)*LEVEL_HEIGHT, 2*(i+1)*LEVEL_HEIGHT, k*PI/4 + j*PI/(4*len), k*PI/4 + (j+1)*PI/(4*len));
      }
    }
  }
  

}
