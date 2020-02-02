class Node {
  int x, y;
  boolean obst = false;
  boolean startNode, targetNode;

  Node(int x, int y) {
    this.x = x;
    this.y = y;
  }

/*------------------------------------------------------------------------------------*/

  void show() {
    stroke(255);
    
    if (startNode) {
      fill(0, 255, 0);
    } else if (targetNode) {
      fill(255, 0, 0);
    } else if (obst) {
      fill(16);
    } else {
      fill(100);
    }
    
    rect(this.x*nodeSize, this.y*nodeSize, nodeSize, nodeSize);
  }
}
