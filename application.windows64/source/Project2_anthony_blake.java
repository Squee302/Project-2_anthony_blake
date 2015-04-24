import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Project2_anthony_blake extends PApplet {

int[][] map; //sets map as a function with a 2d array
int start = -1;
int goal = -1;
boolean draw;
ArrayList openlist;//defines as arraylist
ArrayList closedlist;
ArrayList nodes;
ArrayList path;
public void setup() {
  size(1024, 672); //can be any dimensions as long as divisible by 32- sets size of window
  map = new int[672/32][640/32];//sets size of grid
  openlist = new ArrayList(); //starts a new array list for the open list
  closedlist = new ArrayList(); // starts a new array list for the closed list
  nodes = new ArrayList(); //create a list of the open nodes
  path = new ArrayList(); //creats a list of nodes used in the optimal path
  generateMap(); //initalizes the drawing but not the window
 
}
public void draw() {
  fill(50, 80, 50);
  stroke(0);
  rect(0, 0, 640, 672);
  Node t1, t2; //calls class node and initializes variables 
  for (int i = 0; i < nodes.size (); i++ ) { //for i that are less than size of the nodes array list
    t1 = (Node)nodes.get(i);
    if (i == start) {
    }
    if (i == start) { //if i in grid=the start node from mouse clicked
      fill(255, 300, 0); //color of start node
    }
    else if (i == goal) { //if i in grid=the goal node from mouse clicked
      fill(0xffFC08D0); //color of goal node
      stroke(0);
    }
    else {
      if (path.contains(t1)) {
        fill(150, 75, 50); // controls color of path
        stroke(0);
      }
      else {
        fill(100, 200, 100); // controls color of movable squares
        stroke(0);
      }
    }
    // noStroke();
    rect(t1.x, t1.y, 32, 32); // load usable rectangles
    stroke(0);
  }
  //Text
  fill(1000, 1000, 1000);
  stroke(0);
  rect(640, 0, 2320, 4320);
  textSize(32);
  fill(0);
  text("BEE Astar", 675, 50);
  textSize(12);
  text("Set the location of the yellow bee and", 675, 100);
  textSize(12);
  fill(0);
  text("the pink flower. Then, observe as Astar", 675, 125);
  textSize(12);
  fill(0);
  text("finds the best path through the hedges.", 675, 150);
  textSize(12);
  fill(0);
  text("Directions:", 675, 350);
  textSize(12);
  fill(0);
  text("1. Left click to place bee", 675, 375);
  textSize(12);
  fill(0);
  text("2. Left click again to place flower", 675, 400);
  textSize(12);
  fill(0);
  text("3. Hit any key to show Astar path", 675, 425);
  textSize(12);
  fill(0);
  text("4. Left click a third time to reset", 675, 450);
  textSize(12);
  fill(0);
}
public void mouseClicked() {
  if (mouseX > 640) {
    println ("this button worked");
  }
  else if (map[PApplet.parseInt(floor(mouseY/32))][PApplet.parseInt(floor(mouseX/32))]!=-1) {//if the gird is press somewhere that does not equal -1... (if it equals negative one than it is already a start/goal node.
    if (start==-1) {//if start is true/there is no start already on the board
      start = map[PApplet.parseInt(floor(mouseY/32))][PApplet.parseInt(floor(mouseX/32))];//start= the loction on the grid where the mouse was clicked.
    } else if (goal==-1) {//if the grid is press somewhere that is not the start node.
      goal = map[PApplet.parseInt(floor(mouseY/32))][PApplet.parseInt(floor(mouseX/32))];//goal= the loction on the grid where the mouse was clicked. 
      if (goal==start) {//if goal and start are the same
        goal = -1;//make goal false
      }
    } else {//if goal and start already appear on the screen
      start = -1;//reset all values
      goal = -1;
      path.clear();//reset board
    }
  }
}
// draw = map[int(floor(mouseY/32))][int(floor(mouseX/32))];}}
public void mousePressed() {
}
public void keyPressed() { //if a keyboard key is pressed
  if (start!=-1 && goal!=-1) {//and if start and goal appear on the grid
    println(astar(start, goal)); //initiate Astar
  }
}
public float distance(float x1,float y1,float x2,float y2) {
  return sqrt(abs(y2-y1)+abs(x2-x1));
}

public boolean astar(int iStart,int iGoal) {
 

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
  public void addNbor(Node _node,float cm) {
    nbors.add(_node);
    nCost.add(new Float(cm));}}

public void generateMap() {
  int q;
  Node n2;
  for ( int ix = 0; ix < 640/32.0f; ix+=1 ) {
    for ( int iy = 0; iy < 672/32.0f; iy+=1) {
      map[iy][ix] = -1;
      if (floor(random(5))!=0) {//(random(5))
    
        nodes.add(new Node(ix*32,iy*32));//initializes nodes
        map[iy][ix] = nodes.size()-1;//adds them to grid
        if (ix>0) {
          if (map[iy][ix-1]!=-1) {
            n2 = (Node)nodes.get(nodes.size()-1);
            float cost = random(0.25f,2);
            n2.addNbor((Node)nodes.get(map[iy][ix-1]),cost);
            ((Node)nodes.get(map[iy][ix-1])).addNbor(n2,cost);
          }
        }
        if (iy>0) {
          if (map[iy-1][ix]!=-1) {
            n2 = (Node)nodes.get(nodes.size()-1);
            float cost = random(0.25f,2);
            n2.addNbor((Node)nodes.get(map[iy-1][ix]),cost); 
            ((Node)nodes.get(map[iy-1][ix])).addNbor(n2,cost);
          }
        }
      }

    }
  }}


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Project2_anthony_blake" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
