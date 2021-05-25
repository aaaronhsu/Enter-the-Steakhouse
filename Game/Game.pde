
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

public void setup() {
  fullScreen();
  menu = new MenuPages(0);
  
  map = new Floor(65); // should not be in setup, will be called by separate function when game starts
}

public void draw() {
  background(255, 255, 255);
  menu.draw();
  drawMap();
}

public void drawMap() {
  for (Room rm : map.roomList) {
    int x = rm.x + 10;
    int y = rm.y + 10;
    
    if (rm.roomType.equals("combat")) fill(255, 0, 0);
    else if (rm.roomType.equals("start")) fill(100, 100, 100);
    else if (rm.roomType.equals("boss")) fill(0);
    rect(x * 20, y * 20, 20, 20);
    
    stroke(0, 255, 0);
    if (rm.roomN != null) {
      line(x * 20 + 10, y * 20 + 10, x * 20 + 10, y * 20);
    }
    if (rm.roomS != null) {
      line(x * 20 + 10, y * 20 + 10, x * 20 + 10, y * 20 + 20);
    }
    if (rm.roomE != null) {
      line(x * 20 + 10, y * 20 + 10, x * 20 + 20, y * 20 + 10);
    }
    if (rm.roomW != null) {
      line(x * 20 + 10, y * 20 + 10, x * 20, y * 20 + 10);
    }
    stroke(0);
  }
}
