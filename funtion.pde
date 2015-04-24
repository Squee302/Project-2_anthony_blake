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

float distance(float x1,float y1,float x2,float y2) {
  return sqrt(abs(y2-y1)+abs(x2-x1));
}

boolean astar(int iStart,int iGoal) {
  /////////////////////////////////////////////////////////////////////////A* Pathfinding Algorithm////////////////////////////////////////////////////////////////////////////////////////////////
  //Finds short path from node[iStart] to node[iGoal]
  //Works strictly off nodes, so not grid depgoaled at all
  float goalX,goalY;//initialize variables
  goalX = ((Node)nodes.get(iGoal)).x;//all x value nodes
  goalY = ((Node)nodes.get(iGoal)).y; //all y value nodes
  
  openlist.clear();//clears open list
  closedlist.clear();//clears closed list
  path.clear();//clears path list
  openlist.add( ((Node)nodes.get(iStart)) );// adds start node to open list
  
  
  ((Node)openlist.get(0)).f = -1;//narrows down search space
  ((Node)openlist.get(0)).g = 0;
  //((Node)openlist.get(0)).h = distance( ((Node)openlist.get(0)).x, ((Node)openlist.get(0)).y, goalX, goalY );//heuristic measure 
  
  Node current;
  float tentativeGScore;
  boolean tentativeIsBetter;
  float lowest = 999999999;
  int lowId = -1;
  
  while( openlist.size()>0 ) {//while openlist is not empty
    //find the node in openlist with the lowest f (g+h scores) and put its index in lowId
    lowest = 999999999;
    for ( int a = 0; a < openlist.size(); a++ ) {
      if ( ( ((Node)openlist.get(a)).g+((Node)openlist.get(a)).h ) <= lowest ) {//if current value is the lowest in the openlist
        lowest = ( ((Node)openlist.get(a)).g+((Node)openlist.get(a)).h );//lowest is now that score
        lowId = a;//initializes lowid as the lowest value in the chain
      }
    }
    current = (Node)openlist.get(lowId);//the current location =the lowest value added to the closed list int he previous section
    if ( (current.x == goalX) && (current.y == goalY) ) { //if the current node is now the goal
      //follow parents backward from goal
      Node d = (Node)openlist.get(lowId);//low id now equals  d which is your goal. 
      while( d.f != -1 ) {
        path.add( d );//add d to the path array 
        d = (Node)nodes.get(d.f);
      }
      return true;
    }
   closedlist.add( (Node)openlist.get(lowId) );//add lowID node to the closed list
    openlist.remove( lowId );//take low ID off the open list
    for ( int n = 0; n < current.nbors.size(); n++ ) {//for each neighbor node to the current
      if ( closedlist.contains( (Node)current.nbors.get(n) ) ) {//if the closed list contains the current's neighbors
        continue;
      }
      tentativeGScore = current.g + distance( current.x, current.y, ((Node)current.nbors.get(n)).x, ((Node)current.nbors.get(n)).y )*((Float)current.nCost.get(n));// tentative_g_score := g_score[current] + dist_between(current,neighbor)
 
 
 
 /* if neighbor not in openset or tentative_g_score < g_score[neighbor] 
                came_from[neighbor] := current
                g_score[neighbor] := tentative_g_score
                f_score[neighbor] := g_score[neighbor] + heuristic_cost_estimate(neighbor, goal)
                if neighbor not in openset
                    add neighbor to openset*/
 
      if ( !openlist.contains( (Node)current.nbors.get(n) ) ) {//if the neighbor is not in the open set
        openlist.add( (Node)current.nbors.get(n) );//add neighbor to open set
        
         ((Node)current.nbors.get(n)).f = nodes.indexOf( (Node)closedlist.get(closedlist.size()-1) ); 
       // ((Node)current.nbors.get(n)).g = tentativeGScore;
        ((Node)current.nbors.get(n)).h = distance( ((Node)current.nbors.get(n)).x, ((Node)current.nbors.get(n)).y, goalX, goalY );
        
 //no path found
}}}  return false;}

