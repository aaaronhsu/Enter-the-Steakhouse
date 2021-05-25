
//GLOBAL VARIABLES
public final int NORTH = 0;
public final int SOUTH = 1;
public final int EAST = 2;
public final int WEST = 3;

//INSTANCE VARIABLES
public Player p;
public Room currentRoom;
public Floor map;

public MenuPages menu;

public MeatCleaver m1 = new MeatCleaver(400,400, 10, 1); //DELETE

public void setup() {
  fullScreen();
  menu = new MenuPages(0);
  
  map = new Floor(10, 15); // should not be in setup, will be called by separate function when game starts
  p = new Player(map.roomList.get(0), 10);
  
  currentRoom = new Room(10);
}

public void draw() {
  background(255, 255, 255);
  menu.draw();
  
  // all of these draw statements will be factored out later
  map.draw();
  
  p.move();
  p.draw();
  
  m1.draw();
  for (int i = 0; i < currentRoom.projectileList.size(); i++) { //access every projectile in currentRoom
    Projectile p = currentRoom.projectileList.get(i);
    p.draw();
  }
  
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
