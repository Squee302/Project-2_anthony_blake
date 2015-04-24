float distance(float x1,float y1,float x2,float y2) {
  return sqrt(abs(y2-y1)+abs(x2-x1));
}

boolean astar(int iStart,int iGoal) {
 

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
 
 
 //wikipedia psudocode
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

