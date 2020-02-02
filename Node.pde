class Node {
  int x, y;
  float g, h, f;
  boolean obst;
  boolean startNode, targetNode;
  boolean exposed;
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
    } else if (exposed) {
      fill(200);
    } else {
      fill(150);
    }

    rect(this.x*nodeSize, this.y*nodeSize, nodeSize, nodeSize);
  }
}
