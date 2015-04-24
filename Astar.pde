float distance(float x1,float y1,float x2,float y2) {
  return sqrt(abs(y2-y1)+abs(x2-x1));}//distance calc

boolean astar(int iStart,int iGoal) {
  float goalX,goalY;//initialize variables
  goalX = ((Node)nodes.get(iGoal)).x;//all x value nodes
  goalY = ((Node)nodes.get(iGoal)).y; //all y value nodes
  
  openlist.clear();//clears open list
  closedlist.clear();//clears closed list
  path.clear();//clears path list
  openlist.add( ((Node)nodes.get(iStart)) );// adds start node to open list
  ((Node)openlist.get(0)).f = -1;
  ((Node)openlist.get(0)).g = 0;
  
  
  Node current;
  float runningGscore;
  float lowest = 999999999;
  int lowId = -1;
  
  while( openlist.size()>0 ) {//while openlist is not empty
    //find the node in openlist with the lowest f (g+h scores) and put its index in lowId
    lowest = 999999999;
    for ( int s = 0; s < openlist.size(); s++ ) {
      if ( ( ((Node)openlist.get(s)).g+((Node)openlist.get(s)).h ) <= lowest ) {//if current value is the lowest in the openlist
        lowest = ( ((Node)openlist.get(s)).g+((Node)openlist.get(s)).h );//lowest is now that score
        lowId = s;//initializes lowid as the lowest value in the chain
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
    for ( int n = 0; n < current.neighbors.size(); n++ ) {//for each neighbor node to the current
      if ( closedlist.contains( (Node)current.neighbors.get(n) ) ) {//if the closed list contains a node that touches the current node
        continue;
      }
       
      
      runningGscore = current.g + distance( current.x, current.y, ((Node)current.neighbors.get(n)).x, ((Node)current.neighbors.get(n)).y )*((Float)current.nodeCost.get(n));// tentative_g_score := g_score[current] + dist_between(current,neighbor)
      if ( !openlist.contains( (Node)current.neighbors.get(n) ) ) {//if the neighbor is not in the open set
        openlist.add( (Node)current.neighbors.get(n) );//add neighbor to open set
        
         ((Node)current.neighbors.get(n)).f = nodes.indexOf( (Node)closedlist.get(closedlist.size()-1) ); //add to closed
         ((Node)current.neighbors.get(n)).h = distance( ((Node)current.neighbors.get(n)).x, ((Node)current.neighbors.get(n)).y, goalX, goalY );//get distance
        
        
 //no path found
}}}  return false;}

