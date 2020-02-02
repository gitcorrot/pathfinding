final int nodeSize = 25;
final int delayTime = 1000;

/* Approximation Heuristics mode:
 * 1. Manhattan Distance
 * 2. Euclidean Distance
 * 3. Diagonal Distance
 */
final int MODE = 3;

/* Obstacle mode:
 * 1. Vertical strips 
 * 2. Perlin noise
 */
final int OBSTACLE_MODE = 2;

private Node[][] nodes;
private Node currentNode;
private Node startNode;
private Node targetNode;
private ArrayList<Node> openSet; // nodes to be evaluated
private ArrayList<Node> closedSet; // evaluated nodes

private int moveCount;
private boolean done;
private int doneTime; 
private ArrayList<Node> path; // final path

/*---------------------------------------------------------------*/

void setup() {
  size(800, 600); 
  frameRate(60);
  //randomSeed(5);
  createNodes();
}

void createNodes() {
  println("\n\n------------------------------------");
  println("Creating new board...");

  // Reset variables
  openSet = new ArrayList();
  closedSet = new ArrayList();
  path = new ArrayList();
  done = false;
  moveCount = 0;

  // Initialize array with empty nodes
  nodes = new Node[width/nodeSize][height/nodeSize];

  for (int i = 0; i < width/nodeSize; i++) {
    for (int j = 0; j < height/nodeSize; j++) {
      nodes[i][j] = new Node(i, j);
    }
  }

  // Fill array with some obstacles
  switch(OBSTACLE_MODE) {
  case 1: 
    {
      for (int i = 5; i < width/nodeSize; i+=int(5 + random(8))-3) {
        int r1 = 5 + int(random(height/nodeSize - 10));
        int r2 = 5 + int(random(height/nodeSize - 10));
        for (int j = 0; j < height/nodeSize; j++) {
          if (j != r1 && j != r2)
            nodes[i][j].obst = true;
        }
      }
      break;
    }
  case 2: 
    {
      float ioff = random(100);
      float joff = random(100);
      for (int i = 0; i < width/nodeSize; i++) {
        for (int j = 0; j < height/nodeSize; j++) {
          float obstProbability = noise(joff, ioff) * 105;
          // Creating obstacles
          if (obstProbability < 40) nodes[i][j].obst = true;
          joff += 0.3;
        }
        ioff += 0.3;
        joff = 0;
      }
      break;
    }
  }

  // Set start node
  int startIndex = int(random(nodes[0].length));
  startNode = nodes[0][startIndex];
  startNode.startNode = true;

  // Add start node to openSet
  openSet.add(startNode);

  // Set target node
  int targetIndex = int(random(nodes[0].length));
  targetNode = nodes[nodes.length-1][targetIndex];
  targetNode.targetNode = true;

  // Calculate h score of all nodes
  for (int i = 0; i < width/nodeSize; i++) {
    for (int j = 0; j < height/nodeSize; j++) {
      switch(MODE) {
      case 1: 
        {
          nodes[i][j].h = abs(nodes[i][j].x - targetNode.x) + abs(nodes[i][j].y - targetNode.y); // Manhattan Distance
          break;
        }
      case 2: 
        {
          nodes[i][j].h = sqrt(pow((nodes[i][j].x - targetNode.x), 2) + pow((nodes[i][j].y - targetNode.y), 2)); // Euclidean Distance
          break;
        }
      case 3: 
        {
          nodes[i][j].h = max(abs(nodes[i][j].x - targetNode.x), abs(nodes[i][j].y - targetNode.y)); // Diagonal Distance
          break;
        }
      }
    }
  }
}

/*---------------------------------------------------------------*/

void draw() {
  // Draw all nodes
  for (int i = 0; i < width; i += nodeSize) {
    for (int j = 0; j < height; j += nodeSize) {
      nodes[i/nodeSize][j/nodeSize].show();
    }
  }

  textSize(nodeSize);
  fill(250);
  text(moveCount, width-nodeSize*2, nodeSize-3); 

  // Pathfinding
  if (done) {
    if (millis() > doneTime + delayTime) {
      createNodes();
    }
    return;
  } else moveCount++;

  if (openSet.isEmpty()) {
    println("Can't find path!");
    done = true;
    return;
  }

  currentNode = getBestOpenNode();
  currentNode.closed = true;
  openSet.remove(currentNode);
  closedSet.add(currentNode);

  if (currentNode == targetNode) {
    println("Finished in "+moveCount+" moves!");
    reconstructPath();
    return;
  }

  // Get neighbours of current node
  for (Node n : getNeighbours(currentNode)) {
    if (!closedSet.contains(n)) {
      float temp_g = n.g + sqrt(abs(n.x - currentNode.x) + abs(n.y - currentNode.y));
      if (!openSet.contains(n) || temp_g < n.g ) {
        n.g = temp_g;
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
  done = true;
  doneTime = millis();
}

/*---------------------------------------------------------------
 * TODO: 
 * - choose start and target nodes by mouse click
 * - 
 * - 
 ----------------------------------------------------------------*/
