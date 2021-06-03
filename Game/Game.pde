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
  size(960, 540);
  menu = new MenuPages(0);
  

  map = new Floor(10, 15); // should not be in setup, will be called by separate function when game starts
  p = new Player(map.roomList.get(0), 5);
}



public void draw() {
  background(255, 255, 255);

  noStroke();
  menu.draw();
  
  // all of these draw statements will be factored out later
  
  p.currentRoom.draw();
  
  p.move();
  p.draw();
  map.draw();
}

public void keyPressed() {
  println(keyCode);
  if (keyCode == WKEY || keyCode == AKEY || keyCode == SKEY || keyCode == RKEY) {
    p.changeDirection(true);
  }

  if (keyCode == 9) {
    map.showMap = true;
  }

  if (49 <= keyCode && keyCode <= 52) {
    p.purchaseItem(keyCode - 49);
  }

  if (keyCode == 81) {
    p.useBlank();
  }
}

public void keyReleased() {
  if (keyCode == WKEY || keyCode == AKEY || keyCode == SKEY || keyCode == RKEY) {
    p.changeDirection(false);
  }

  if (keyCode == 9) {
    map.showMap = false;
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
  return 'c';
  //return this.p.currentRoom.roomBlueprint[(int)(y / 30)].charAt((int)(x / 30));
}
