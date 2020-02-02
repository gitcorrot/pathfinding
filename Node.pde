class Node {
  int x, y;
  float g; // distance from starting node
  float h; // distance from target node
  float f; // sum of g and h
  boolean obst;
  boolean startNode, targetNode;
  boolean exposed;
  boolean path = false;
  Node parent;

  Node(int x, int y) {
    this.x = x;
    this.y = y;
    obst = false;
    exposed = false;
    //g = 9999999; // Inf
  }

  /*--------------------------------------------------------*/

  void show() {
    if (startNode) {
      fill(0, 255, 0);
    } else if (targetNode) {
      fill(255, 0, 0);
    } else if (obst) {
      fill(16);
    } else if (path) {
      fill(0, 0, 255);
    } else if (exposed) {
      fill(200);
    } else {
      fill(150);
    }

    rect(this.x*nodeSize, this.y*nodeSize, nodeSize, nodeSize);
  }
}
