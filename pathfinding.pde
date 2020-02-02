final int nodeSize = 100;

Node[][] nodes;

void setup() {
  size(800, 800); 
  
  // Initialize empty nodes 2D array
  nodes = new Node[width/nodeSize][height/nodeSize];
 
  // Fill array with nodes
  for (int i = 0; i < width/nodeSize; i++) {
    for (int j = 0; j < height/nodeSize; j++) {
      nodes[i][j] = new Node(i, j);
    }
  }
}


void draw() {
  background(255);

  for (int i = 0; i < width; i += nodeSize) {
    for (int j = 0; j < height; j += nodeSize) {
      nodes[i/nodeSize][j/nodeSize].show();
    }
  }
}
