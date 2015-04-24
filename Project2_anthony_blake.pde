int[][] map; //sets map as a function with a 2d array
int start = -1;
int goal = -1;
boolean draw;
ArrayList openlist;//defines as arraylist
ArrayList closedlist;
ArrayList path;
ArrayList nodes;

void setup() {
  size(1024, 672); //can be any dimensions as long as divisible by 32- sets size of window
  map = new int[672/32][640/32];//sets size of grid
  openlist = new ArrayList(); //starts a new array list for the open list
  closedlist = new ArrayList(); // starts a new array list for the closed list
  nodes = new ArrayList(); //create a list of the open nodes
  path = new ArrayList(); //creats a list of nodes used in the optimal path
  generateMap(); //initalizes the drawing but not the window
 
}
void draw() {
  fill(50, 80, 50);
  stroke(0);
  rect(0, 0, 640, 672);
  Node t1, t2; //calls class node and initializes variables 
  for (int i = 0; i < nodes.size (); i++ ) { //for i that are less than size of the nodes array list
    t1 = (Node)nodes.get(i);
   
    if (i == start) { //if i in grid=the start node from mouse clicked
      fill(255, 300, 0); //color of start node
    }
    else if (i == goal) { //if i in grid=the goal node from mouse clicked
      fill(#FC08D0); //color of goal node
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
void mouseClicked() {
  if (mouseX > 640) {
    println ("this button worked");
  }
  else if (map[int(floor(mouseY/32))][int(floor(mouseX/32))]!=-1) {//if the gird is press somewhere that does not equal -1... (if it equals negative one than it is already a start/goal node.
    if (start==-1) {//if start is true/there is no start already on the board
      start = map[int(floor(mouseY/32))][int(floor(mouseX/32))];//start= the loction on the grid where the mouse was clicked.
    } else if (goal==-1) {//if the grid is press somewhere that is not the start node.
      goal = map[int(floor(mouseY/32))][int(floor(mouseX/32))];//goal= the loction on the grid where the mouse was clicked. 
      if (goal==start) {//if goal and start are the same
        goal = -1;//make goal false
      }
    } 
    else {//if goal and start already appear on the screen
      start = -1;//reset all values
      goal = -1;
      path.clear();//reset board
    }
  }
}
void keyPressed() { //if a keyboard key is pressed
  if (start!=-1 && goal!=-1) {//and if start and goal appear on the grid
    println(astar(start, goal)); //initiate Astar
  }
}
