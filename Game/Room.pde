public class Room {
  int x;
  int y;
  
  Room roomN = null;
  Room roomS = null;
  Room roomE = null;
  Room roomW = null;
  
  String roomType;
  int chanceToGenerateRoom;
  
  boolean hasTeleporter;
  int roomBlueprint;
  
  ArrayList<Enemy> enemyList = new ArrayList();
  ArrayList<Projectile> projectileList = new ArrayList();
  
  // constructor for the start room
  Room(int chanceToGenerateRoom) {
    this.roomType = "start";
    this.chanceToGenerateRoom = chanceToGenerateRoom;
    this.x = 0;
    this.y = 0;
    this.hasTeleporter = true;
  }
  
  // constructor for all other rooms
  Room(Room previousRoom, int direction, String roomType, int x, int y, int chanceToGenerateRoom) {
    this.roomType = roomType;
    this.chanceToGenerateRoom = chanceToGenerateRoom;
    this.x = x;
    this.y = y;
    
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
  
  public String toString() {
    return "this is a " + this.roomType + " located at (" + this.x + ", " + this.y + ")"; 
  }
}
