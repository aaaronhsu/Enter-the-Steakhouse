
//GLOBAL VARIABLES
public final int NORTH = 0;
public final int SOUTH = 1;
public final int EAST = 2;
public final int WEST = 3;

//INSTANCE VARIABLES
public Player p;
public Floor map;

public MenuPages menu;

public void setup() {
  fullScreen();
  menu = new MenuPages(0);
  
  map = new Floor(13, 18); // should not be in setup, will be called by separate function when game starts
  p = new Player(map.roomList.get(0), 7);

  // for (int i = 0; i < p.currentRoom.roomBlueprint.length; i++) {
  //   println(p.currentRoom.roomBlueprint[i]);
  // }
}

public void draw() {
  background(255, 255, 255);
  menu.draw();
  
  // all of these draw statements will be factored out later
  
  p.currentRoom.draw();
  p.move();
  p.draw();
  
  map.draw();
}

public void keyPressed() {
  if (keyCode == 87 || keyCode == 82 || keyCode == 83 || keyCode == 65) {
    p.changeDirection(true);
  }
}

public void keyReleased() {
  if (keyCode == 87 || keyCode == 82 || keyCode == 83 || keyCode == 65) {
    p.changeDirection(false);
  }
}

public void mousePressed() {
  map = new Floor(10, 15);
  p = new Player(map.roomList.get(0), 10);
}
