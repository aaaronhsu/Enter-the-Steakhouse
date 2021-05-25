public final char PIT = '0';
public final char WALL = '1';
public final char TELEPORTER = '2';
public final char CORRIDOR = '3';
public final char GROUND = '4';

public class Room {
  int x;
  int y;
  
  Room roomN = null;
  Room roomS = null;
  Room roomE = null;
  Room roomW = null;
  boolean isCurrentRoom;
  
  String roomType;
  int chanceToGenerateRoom;
  
  boolean hasTeleporter;
  String[] roomBlueprint;
  
  
  ArrayList<Enemy> enemyList = new ArrayList();
  ArrayList<Projectile> projectileList = new ArrayList();
  
  int[] corridorN = null;
  int[] corridorS = null;
  int[] corridorE = null;
  int[] corridorW = null;
  
  // constructor for the start room
  Room(int chanceToGenerateRoom) {
    this.roomType = "start";
    this.chanceToGenerateRoom = chanceToGenerateRoom;
    this.x = 0;
    this.y = 0;
    this.hasTeleporter = true;
    this.isCurrentRoom = true;

    this.roomBlueprint = loadStrings("room1.txt");
  }
  
  // constructor for all other rooms
  Room(Room previousRoom, int direction, String roomType, int x, int y, int chanceToGenerateRoom) {
    this.roomType = roomType;
    this.chanceToGenerateRoom = chanceToGenerateRoom;
    this.x = x;
    this.y = y;
    this.isCurrentRoom = false;
    
    if (random(100) < 20) {
      this.hasTeleporter = true;
    }
    else this.hasTeleporter = false;
    
    switch (direction) {
      case NORTH:
        // connect rooms through reference
        roomN = previousRoom;
        previousRoom.roomS = this;
        break;
      
      case SOUTH:
        // connect rooms through reference
        roomS = previousRoom;
        previousRoom.roomN = this;
        break;
        
      case EAST:
        // connect rooms through reference
        roomW = previousRoom;
        previousRoom.roomE = this;
        break;
        
      case WEST:
        // connect rooms through reference
        roomE = previousRoom;
        previousRoom.roomW = this;
        break;
    }
  }
  
  public void draw() {
    text(toString(), 500, 500);

    drawRoomBlueprint();

    for (Enemy e : this.enemyList) {
      e.draw();
    }
    for (Projectile proj : this.projectileList) {
      proj.draw();
    }
    
  }

  public void drawRoomBlueprint() {
    for (int row = 0; row < roomBlueprint.length; row++) {
      for (int col = 0; col < roomBlueprint[row].length(); col++) {
        switch (this.roomBlueprint[row].charAt(col)) {
          case GROUND:
            fill(100, 100, 100);
            break;
          
          case PIT:
            fill(0);
            break;

          case WALL:
            fill(255, 0, 0);
            break;
          
          case TELEPORTER:
            fill(0, 0, 255);
            break;
          
          case CORRIDOR:
            fill(0, 255, 0);

            if (row == 0) {
              // NORTH CORRIDOR LOCATION
              corridorN = new int[] {row, col};
            }
            else if (row == roomBlueprint.length - 1) {
              // SOUTH CORRIDOR LOCATION
              corridorS = new int[] {row, col};
            }
            else if (col == roomBlueprint[row].length() - 1) {
              // EAST CORRIDOR LOCATION
              corridorE = new int[] {row, col};
            }
            else if (col == 0) {
              // WEST CORRIDOR LOCATION
              corridorW = new int[] {row, col};
            }

            break;
            
          default:
            fill(12, 36, 123);
            break;
        }

        rect(col * 60, row * 60, 60, 60);
      }
    }
  }
  
  public String toString() {
    return "this is a " + this.roomType + " located at (" + this.x + ", " + this.y + ")"; 
  }
}
