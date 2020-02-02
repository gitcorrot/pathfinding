class Node {
  int x, y;
  float g; // distance from starting node
  float h; // distance from target node
  float f; // sum of g and h
  boolean startNode, targetNode;
  boolean obst, exposed, closed;
  boolean path = false;
  Node parent;

  Node(int x, int y) {
    this.x = x;
    this.y = y;
  }

  /*--------------------------------------------------------*/

  void show() {
    if (startNode) {
      fill(50, 255, 50);
    } else if (targetNode) {
      fill(255, 50, 50);
    } else if (obst) {
      fill(32);
    } else if (path) {
      fill(0, 125, 255);
    } else if (closed) {
      fill(255, 100, 100);
    } else if (exposed) {
      fill(180);
    } else {
      fill(140);
    }

    rect(this.x*nodeSize, this.y*nodeSize, nodeSize, nodeSize);
  }
}
