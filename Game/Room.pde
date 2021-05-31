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
  boolean visited;
  
  String roomType;
  int chanceToGenerateRoom;
  
  boolean hasTeleporter;
  String[] roomBlueprint;
  int roomBlueprintNum;
  
  
  ArrayList<Enemy> enemyList = new ArrayList();
  ArrayList<Enemy> removeEnemyList = new ArrayList();
  ArrayList<Projectile> projectileList = new ArrayList();
  ArrayList<Projectile> removeProjList = new ArrayList();
  
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
    this.visited = true;

    this.roomBlueprint = loadStrings("room6.txt");
    
  }
  
  // constructor for all other rooms
  Room(Room previousRoom, int direction, String roomType, int x, int y, int chanceToGenerateRoom) {
    this.roomType = roomType;
    this.chanceToGenerateRoom = chanceToGenerateRoom;
    this.x = x;
    this.y = y;
    this.isCurrentRoom = false;
    this.visited = false;
    
    this.roomBlueprintNum = (int)(random(7)) + 1;

    this.roomBlueprint = loadStrings("room" + roomBlueprintNum + ".txt");
    
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

  // determines the positions of the corridors
  public void constructCorridors() {
    for (int row = 0; row < roomBlueprint.length; row++) {
      for (int col = 0; col < roomBlueprint[row].length(); col++) {

        if (this.roomBlueprint[row].charAt(col) == CORRIDOR) {
          if (row == 0) {
            // NORTH CORRIDOR LOCATION
            this.corridorN = new int[] {row, col};
          }
          else if (row == roomBlueprint.length - 1) {
            // SOUTH CORRIDOR LOCATION
            this.corridorS = new int[] {row + 1, col};
          }
          else if (col == roomBlueprint[row].length() - 1) {
            // EAST CORRIDOR LOCATION
            this.corridorE = new int[] {row, col + 1};
          }
          else if (col == 0) {
            // WEST CORRIDOR LOCATION
            this.corridorW = new int[] {row, col};
          }
        }
      }
    }
  }
  
  // removes corridor from the map if the room adjacent does not exist
  public void removeCorridors() {
    if (this.roomN == null) {
      String north = this.roomBlueprint[0];
      String newNorth = north.substring(0, this.corridorN[1]) + WALL + north.substring(this.corridorN[1] + 1);
      this.roomBlueprint[0] = newNorth;
    }
    if (this.roomS == null) {
      String south = this.roomBlueprint[this.roomBlueprint.length - 1];
      String newSouth = south.substring(0, this.corridorS[1]) + WALL + south.substring(this.corridorS[1] + 1);
      this.roomBlueprint[this.roomBlueprint.length - 1] = newSouth;
    }
    if (this.roomE == null) {
      String east = this.roomBlueprint[this.corridorE[0]];
      String newEast = east.substring(0, this.corridorE[1] - 1) + WALL;
      this.roomBlueprint[this.corridorE[0]] = newEast;
    }
    if (this.roomW == null) {
      String west = this.roomBlueprint[this.corridorW[0]];
      String newWest = WALL + west.substring(1);
      this.roomBlueprint[this.corridorW[0]] = newWest;
    }
  }


  public void generateEnemies() {
    int randomGenType = (int) random(2);

    switch (randomGenType) {
      case 0:
        for (int i = 0; i < 5; i++) {
          int x = (int) random(1560) + 180;
          int y = (int) random(720) + 180;

          while (this.roomBlueprint[(int)(y / 60)].charAt((int)(x / 60)) != GROUND ||
                 this.roomBlueprint[(int)(y / 60) - 1].charAt((int)(x / 60)) != GROUND ||
                 this.roomBlueprint[(int)(y / 60) + 1].charAt((int)(x / 60)) != GROUND ||
                 this.roomBlueprint[(int)(y / 60)].charAt((int)(x / 60) - 1) != GROUND ||
                 this.roomBlueprint[(int)(y / 60)].charAt((int)(x / 60) + 1) != GROUND) {
            x = (int) random(1920);
            y = (int) random(1080);
          }

          MeatCleaver m = new MeatCleaver(x, y, 1, 1);

          this.enemyList.add(m);
          println("enemyGenerated");
        }
        break;
      case 1:
        for (int i = 0; i < 3; i++) {
          int x = (int) random(1560) + 180;
          int y = (int) random(720) + 180;

          while (this.roomBlueprint[(int)(y / 60)].charAt((int)(x / 60)) != GROUND ||
                 this.roomBlueprint[(int)(y / 60) - 1].charAt((int)(x / 60)) != GROUND ||
                 this.roomBlueprint[(int)(y / 60) + 1].charAt((int)(x / 60)) != GROUND ||
                 this.roomBlueprint[(int)(y / 60)].charAt((int)(x / 60) - 1) != GROUND ||
                 this.roomBlueprint[(int)(y / 60)].charAt((int)(x / 60) + 1) != GROUND) {
            x = (int) random(1920);
            y = (int) random(1080);
          }

          Stove m = new Stove(x, y, 1, 1);

          this.enemyList.add(m);
        }
    }
  }

  
  public void draw() {
    text(toString(), 500, 500);

    drawRoomBlueprint();
    

    for (Enemy e : this.enemyList) {
      e.draw();
      if (e.health <= 0) p.currentRoom.removeEnemyList.add(e);
    }
    for (Enemy e : this.removeEnemyList) { //access every enemy that needs to be despawned
      e.despawn();
    }
    
    for (Projectile proj : this.projectileList) { //access every projectile in currentRoom
      proj.draw();
      if (proj.numBounces == 0 || proj.despawnTime == 0 || proj.detectCollision()) p.currentRoom.removeProjList.add(proj);
    }
    for (Projectile proj : this.removeProjList) { //access every projectile that needs to be despawned
      proj.despawn();
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
            fill(50, 50, 50);
            break;

          case WALL:
            fill(255, 0, 0);
            break;
          
          case TELEPORTER:
            // by default, a telepoter will be the ground
            if (this.hasTeleporter) fill(0, 0, 255);
            else fill(100, 100, 100);
            break;
          
          case CORRIDOR:
            // by default, a corridor will be a wall
            fill(255, 0, 0);

            if (roomN != null && row == 0) {
              // NORTH CORRIDOR LOCATION
              if (this.enemyList.isEmpty()) fill(0, 255, 0);
              else fill(0, 150, 0);
            }
            else if (roomS != null && row == roomBlueprint.length - 1) {
              // SOUTH CORRIDOR LOCATION
              if (this.enemyList.isEmpty()) fill(0, 255, 0);
              else fill(0, 150, 0);
            }
            else if (roomE != null && col == roomBlueprint[row].length() - 1) {
              // EAST CORRIDOR LOCATION
              if (this.enemyList.isEmpty()) fill(0, 255, 0);
              else fill(0, 150, 0);
            }
            else if (roomW != null && col == 0) {
              // WEST CORRIDOR LOCATION
              if (this.enemyList.isEmpty()) fill(0, 255, 0);
              else fill(0, 150, 0);
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
    return "this is a " + this.roomType + " located at (" + this.x + ", " + this.y + ")" + " and is using " + this.roomBlueprintNum; 
  }
}
