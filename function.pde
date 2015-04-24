class Node {//creates variables/arrays assoc. with nodes
  float x,y;//defines x,y,g,and h as floats
  float g,h;
  int f;//indentifies f as an int
  ArrayList neighbors; //array of node objects, not indecies
  ArrayList nodeCost; //cost multiplier for each corresponding
  Node(float _x,float _y) {
    x = _x;
    y = _y;
    g = 0;
    h = 0;
    f = -1;
    neighbors = new ArrayList();//new array lists for neighbor nodes 
    nodeCost = new ArrayList();//new array of node costs
  }
  void addNbor(Node _node,float cm) {
    neighbors.add(_node);
    nodeCost.add(new Float(cm));}}

void generateMap() {
  int q;
  Node r;
  for ( int ix = 0; ix < 640/32.0; ix+=1 ) {//creates grid range x
    for ( int iy = 0; iy < 672/32.0; iy+=1) {//creates grid range y
      
      
      if (floor(random(5))!=0) {//(random(5))
        nodes.add(new Node(ix*32,iy*32));//initializes nodes
        map[iy][ix] = nodes.size()-1;//adds them to grid
        
        if (ix>0) {
          
          if (map[iy][ix-1]!=-1) {
            r = (Node)nodes.get(nodes.size()-1);
            float cost = random(0.25,2);//random value between .25-2
            r.addNbor((Node)nodes.get(map[iy][ix-1]),cost);
            ((Node)nodes.get(map[iy][ix-1])).addNbor(r,cost);//assigns cost to neighbor nodes
          }
        }
        if (iy>0) {//if map y coordinate is greater than 0
          if (map[iy-1][ix]!=-1) {
            r = (Node)nodes.get(nodes.size()-1);
            float cost = random(0.25,2);//random value between .25-2
            r.addNbor((Node)nodes.get(map[iy-1][ix]),cost); 
            ((Node)nodes.get(map[iy-1][ix])).addNbor(r,cost);//assigns cost to neighbor nodes
          }
        }
      }

    }
  }}


