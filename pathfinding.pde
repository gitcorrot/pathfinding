final int nodeSize = 100;

Node[][] nodes;
Node currentNode;
Node startNode;
Node targetNode;
ArrayList<Node> openSet = new ArrayList(); // nodes to be evaluated
ArrayList<Node> closedSet = new ArrayList(); // evaluated nodes

/*----------------------------------------------------------*/

void setup() {
  size(800, 800); 
  frameRate(1);

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
  //print(openSet.get(0)==nodes[0][0]); TRUE
  currentNode = getBestOpenNode();
  println("New current node: X="+currentNode.x+" Y="+currentNode.y);

  if (currentNode == targetNode) {
    print("Finished!");
    return;
  }

  // Get neighbours of current node
  getNeighbours(currentNode);
  for (Node n : getNeighbours(currentNode)) {
    // g -> distance from starting node
    n.g += sqrt(abs(n.x - currentNode.x) + abs(n.y - currentNode.y));
    println("NEW G = " + n.g);
    // h -> distance from target node
    n.h = abs(n.x - targetNode.x) + abs(n.y - targetNode.y);
    // f -> sum of g and h
    n.f = n.g + n.h;
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
  println("getNeighbours(" +node.x+ ","+node.y+")");

  for (int i = node.x-1; i <= node.x+1; i++) {
    for (int j = node.y-1; j <= node.y+1; j++) {
      if (i >= 0 && j >= 0 && i < nodes.length && j < nodes[0].length) {
        if (!(i == node.x && j == node.y)) {
          neighbours.add(nodes[i][j]);
          nodes[i][j].exposed = true;
          println("X=" + i + " Y=" + j);
        }
      }
    }
  }
  return neighbours;
}

/*----------------------------------------------------------
 * TODO: 
 * - choose start and target nodes by mouse click
 * - 
 * - 
 --------------------------------------------------------*/
