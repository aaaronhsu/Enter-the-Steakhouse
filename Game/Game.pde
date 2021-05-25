
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
  menu = new MenuPages(0);
  
  
}

public void draw() {
  menu.draw();
}
