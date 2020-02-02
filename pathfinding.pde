final int nodeSize = 10;

private Node[][] nodes;
private Node currentNode;
private Node startNode;
private Node targetNode;
private ArrayList<Node> openSet = new ArrayList(); // nodes to be evaluated
private ArrayList<Node> closedSet = new ArrayList(); // evaluated nodes

private boolean done = false;
private ArrayList<Node> path = new ArrayList(); // final path

/*----------------------------------------------------------*/

void setup() {
  size(800, 800); 
  frameRate(60);

  // Initialize empty nodes 2D array
  nodes = new Node[width/nodeSize][height/nodeSize];

  // Fill array with nodes
  for (int i = 0; i < width/nodeSize; i++) {
    for (int j = 0; j < height/nodeSize; j++) {
      nodes[i][j] = new Node(i, j);
    }
  }

  // Set start node
  nodes[0][0].startNode = true;
  nodes[0][0].exposed = true;
  nodes[0][0].f = 0;
  startNode = nodes[0][0];

  // Add start node to openSet
  openSet.add(startNode);

  // Set target node
  nodes[nodes.length-1][nodes.length-1].targetNode = true;
  targetNode = nodes[nodes.length-1][nodes.length-1];

  // Add some obstacles
  nodes[3][4].obst = true;
  nodes[4][3].obst = true;
  nodes[4][5].obst = true;
  nodes[3][5].obst = true;
  nodes[3][3].obst = true;
  nodes[14][5].obst = true;
  nodes[13][5].obst = true;
  nodes[13][63].obst = true;
  nodes[55][63].obst = true;
  nodes[56][63].obst = true;
  nodes[57][63].obst = true;
  nodes[58][63].obst = true;
  nodes[59][63].obst = true;
  nodes[59][64].obst = true;
  nodes[59][65].obst = true;
  nodes[60][65].obst = true;
  nodes[61][65].obst = true;
  nodes[62][65].obst = true;
  nodes[63][65].obst = true;
  nodes[65][65].obst = true;
  nodes[64][65].obst = true;
  nodes[66][65].obst = true;
  nodes[67][65].obst = true;
}

/*----------------------------------------------------------*/

void draw() {
  background(255);

  // Draw all nodes
  for (int i = 0; i < width; i += nodeSize) {
    for (int j = 0; j < height; j += nodeSize) {
      nodes[i/nodeSize][j/nodeSize].show();
    }
  }

  // Pathfinding
  if (done) return;

  if (openSet.isEmpty()) {
    println("Can't find path!");
    done = true;
    return;
  }

  currentNode = getBestOpenNode();
  openSet.remove(currentNode);
  closedSet.add(currentNode);
  println("New current node: X="+currentNode.x+" Y="+currentNode.y);

  if (currentNode == targetNode) {
    println("------------------------------------");
    println("Finished!");
    done = true;
    reconstructPath();
    return;
  }

  // Get neighbours of current node
  for (Node n : getNeighbours(currentNode)) {
    if (!closedSet.contains(n)) {
      float temp_g = n.g + sqrt(abs(n.x - currentNode.x) + abs(n.y - currentNode.y));
      if (!openSet.contains(n) || temp_g < n.g ) {
        n.g = temp_g;
        n.h = abs(n.x - targetNode.x) + abs(n.y - targetNode.y);
        n.f = n.g + n.h;

        n.parent = currentNode;
        openSet.add(n);
      }
    }
  }
}

// Returns node with lowest f
Node getBestOpenNode() {
  Node c = openSet.get(0); 

  for (Node n : openSet) {
    if (n.f < c.f)
      c = n;
  }
  return c;
}

// Returns neighbour nodes of given node
ArrayList<Node> getNeighbours(Node node) {
  ArrayList<Node> neighbours = new ArrayList();

  for (int i = node.x-1; i <= node.x+1; i++) {
    for (int j = node.y-1; j <= node.y+1; j++) {
      if (i >= 0 && j >= 0 && i < nodes.length && j < nodes[0].length) {
        if (!(i == node.x && j == node.y)) {
          if (!node.obst) {
            neighbours.add(nodes[i][j]);
            nodes[i][j].exposed = true;
          }
        }
      }
    }
  }
  return neighbours;
}

void reconstructPath() {
  while (currentNode != startNode) {
    currentNode.path = true;
    path.add(currentNode);
    currentNode = currentNode.parent;
  }
  println("Path recontructed");
}

/*----------------------------------------------------------
 * TODO: 
 * - choose start and target nodes by mouse click
 * - 
 * - 
 --------------------------------------------------------*/
