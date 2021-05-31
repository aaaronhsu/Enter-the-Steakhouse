//GLOBAL VARIABLES
public final int NORTH = 0;
public final int SOUTH = 1;
public final int EAST = 2;
public final int WEST = 3;

public final int WKEY = 87;
public final int AKEY = 65;
public final int SKEY = 83;
public final int DKEY = 68;
public final int RKEY = 82;

//INSTANCE VARIABLES
public Player p;
public Floor map;

public MenuPages menu;

public void setup() {
  fullScreen();
  menu = new MenuPages(0);
  

  map = new Floor(10, 15); // should not be in setup, will be called by separate function when game starts
  p = new Player(map.roomList.get(0), 10);
  MeatCleaver m = new MeatCleaver(300, 300, 1, 1);
  p.currentRoom.enemyList.add(m);
}

public void draw() {
  background(255, 255, 255);
  menu.draw();
  
  // all of these draw statements will be factored out later
  
  p.currentRoom.draw();
  
  p.move();
  p.draw();

  if (p.currentRoom.enemyList.isEmpty()) map.draw();
}

public void keyPressed() {
  if (keyCode == WKEY || keyCode == AKEY || keyCode == SKEY || keyCode == RKEY) {
    p.changeDirection(true);
  }
}

public void keyReleased() {
  if (keyCode == WKEY || keyCode == AKEY || keyCode == SKEY || keyCode == RKEY) {
    p.changeDirection(false);
  }
}

public void mousePressed() {
  // map = new Floor(10, 15);
  // p = new Player(map.roomList.get(0), 10);

  if (mouseButton == LEFT) p.isShooting = true;
}

public void mouseReleased() {
  if (mouseButton == LEFT) p.isShooting = false;
}

public char fetchTile(float x, float y) {
  return this.p.currentRoom.roomBlueprint[(int)(y / 60)].charAt((int)(x / 60));
}