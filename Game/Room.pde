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
  ArrayList<int[]> bloodStainCoords = new ArrayList();
  int roomBlueprintNum;
  
  ArrayList<Enemy> enemyList = new ArrayList();
  ArrayList<Enemy> removeEnemyList = new ArrayList();
  ArrayList<Projectile> projectileList = new ArrayList();
  ArrayList<Projectile> removeProjList = new ArrayList();
  
  int[] corridorN = null;
  int[] corridorS = null;
  int[] corridorE = null;
  int[] corridorW = null;
  
  String[] bloodstain = loadStrings("bloodstain.txt");
  String[] wall = loadStrings("wall.txt");
  
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
    
    this.roomBlueprintNum = (int)(random(14)) + 1;

    if (roomType.equals("shop")) {
      this.roomBlueprint = loadStrings("shopRoom.txt");
    }
    else if (roomType.equals("boss") || roomType.equals("chest")) {
      this.roomBlueprint = loadStrings("room6.txt");
    }
    else {
      this.roomBlueprint = loadStrings("room" + roomBlueprintNum + ".txt");
    }

    for (int i = 0; i < roomBlueprint.length; i++) {
      for (int j = 0; j < roomBlueprint[i].length(); j++) {
        if (roomBlueprint[i].charAt(j) == GROUND && random(100) < 1) {
          bloodStainCoords.add(new int[] {j, i});
        }
      }
    }
    
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

  
  public void draw() {

    drawRoomBlueprint();

    for (Enemy e : this.enemyList) {
      e.draw();
      if (e.health <= 0) p.currentRoom.removeEnemyList.add(e);
    }
    for (Enemy e : this.removeEnemyList) { //access every enemy that needs to be despawned
      switch (e.enemyType) {
        case MEATCLEAVER:
          p.money += 1;
          break;
        
        case STOVE:
          p.money += 2;
          break;
        
        case GARDENER:
          p.money += 3;
          break;
        
        case BOSS:
          p.money += 5;
          break;
      }
      e.despawn();
    }
    
    for (Projectile proj : this.projectileList) { //access every projectile in currentRoom
      proj.draw();
      if (proj.numBounces <= 0 || proj.despawnTime == 0 || proj.detectCollision()) p.currentRoom.removeProjList.add(proj);
    }
    for (Projectile proj : this.removeProjList) { //access every projectile that needs to be despawned
      proj.despawn();
    }
    
    this.removeEnemyList = new ArrayList();
    this.removeProjList = new ArrayList();
  }

  public void drawRoomBlueprint() {
    for (int row = 0; row < roomBlueprint.length; row++) {
      for (int col = 0; col < roomBlueprint[row].length(); col++) {
        switch (this.roomBlueprint[row].charAt(col)) {
          case GROUND:
            fill(101, 67, 33);
            break;
          
          case PIT:
            fill(0, 0, 0);
            break;

          case WALL:
            fill(100, 100, 100);
            break;
          
          case TELEPORTER:
            // all teleporters will be treated as the ground
            fill(101, 67, 33);
            break;
          
          case CORRIDOR:
            // by default, a corridor will be a wall
            fill(100, 100, 100);

            if (roomN != null && row == 0) {
              // NORTH CORRIDOR LOCATION
              if (this.enemyList.isEmpty()) fill(4, 99, 7);
              else fill(120, 120, 120);
            }
            else if (roomS != null && row == roomBlueprint.length - 1) {
              // SOUTH CORRIDOR LOCATION
              if (this.enemyList.isEmpty()) fill(4, 99, 7);
              else fill(120, 120, 120);
            }
            else if (roomE != null && col == roomBlueprint[row].length() - 1) {
              // EAST CORRIDOR LOCATION
              if (this.enemyList.isEmpty()) fill(4, 99, 7);
              else fill(120, 120, 120);
            }
            else if (roomW != null && col == 0) {
              // WEST CORRIDOR LOCATION
              if (this.enemyList.isEmpty()) fill(4, 99, 7);
              else fill(120, 120, 120);
            }

            break;
            
          default:
            fill(12, 36, 123);
            break;
        }

        rect(col * 30, row * 30, 30, 30);
        
        
        if (this.roomBlueprint[row].charAt(col) == WALL) drawWall(col, row);

      }
    }

    for (int[] i : this.bloodStainCoords) {
      drawBloodstain(i[0], i[1]);
    }
  }
  
  void drawBloodstain(float x, float y) {
    int sideLength = 30;
    
    //x -= bloodstain[0].length()/2 * sideLength; //centers the bloodstain
    //y -= bloodstain.length/2 * sideLength; 
    
    
    for (int i = 0; i < bloodstain.length; i++) {
        
        for (int j = 0; j < bloodstain[0].length(); j++) {
          char colour = bloodstain[i].charAt(j);
          
          if (colour == '0') fill(101, 67, 33); //gray
          else if (colour == '1') {fill(#FF2727);} //red
          else if (colour == '2') {fill(#DE1919);} //dark red
          else if (colour == '3') {fill(#FF8E8E);} //light red
          rect(x * 30 + j + 5, y * 30 + i + 5, 1, 1);
        }
      }
  }
  
  void drawWall(float x, float y) {

    fill(#676666);
    rect(x * 30, y * 30, 30, 30);

    fill(#AFAFAF);
    rect(x * 30 + 1, y * 30 + 2, 28, 6);

    fill(#908F8F);
    rect(x * 30 + 1, y * 30 + 6, 28, 14);

    fill(#747474);
    rect(x * 30 + 1, y * 30 + 20, 28, 10);
  }

  public void removeEnemyProjectiles() {
    ArrayList<Projectile> blankProjectile = new ArrayList();

    for (Projectile proj : this.projectileList) {
      if (!proj.isPlayerProjectile) {
        blankProjectile.add(proj);
      }
    }

    for (Projectile proj : blankProjectile) {
      this.projectileList.remove(proj);
    }
  }
  
  public String toString() {
    return "this is a " + this.roomType + " located at (" + this.x + ", " + this.y + ")" + " and is using " + this.roomBlueprintNum; 
  }
}
