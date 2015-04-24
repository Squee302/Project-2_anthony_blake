class Node {
  float x,y;//defines x,y,g,and h as floats
  float g,h;
  int f;//indentifies f as an int
  ArrayList nbors; //array of node objects, not indecies
  ArrayList nCost; //cost multiplier for each corresponding
  Node(float _x,float _y) {
    x = _x;
    y = _y;
    g = 0;
    h = 0;
    f = -1;
    nbors = new ArrayList();//new array lists for node objects
    nCost = new ArrayList();//new array of costs
  }
  void addNbor(Node _node,float cm) {
    nbors.add(_node);
    nCost.add(new Float(cm));}}

void generateMap() {
  int q;
  Node n2;
  for ( int ix = 0; ix < 640/32.0; ix+=1 ) {
    for ( int iy = 0; iy < 672/32.0; iy+=1) {
      map[iy][ix] = -1;
      if (floor(random(5))!=0) {//(random(5))
    
        nodes.add(new Node(ix*32,iy*32));//initializes nodes
        map[iy][ix] = nodes.size()-1;//adds them to grid
        if (ix>0) {
          if (map[iy][ix-1]!=-1) {
            n2 = (Node)nodes.get(nodes.size()-1);
            float cost = random(0.25,2);
            n2.addNbor((Node)nodes.get(map[iy][ix-1]),cost);
            ((Node)nodes.get(map[iy][ix-1])).addNbor(n2,cost);
          }
        }
        if (iy>0) {
          if (map[iy-1][ix]!=-1) {
            n2 = (Node)nodes.get(nodes.size()-1);
            float cost = random(0.25,2);
            n2.addNbor((Node)nodes.get(map[iy-1][ix]),cost); 
            ((Node)nodes.get(map[iy-1][ix])).addNbor(n2,cost);
          }
        }
      }

    }
  }}


