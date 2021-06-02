import java.util.*;

public class Floor {
  Room startRoom;
  ArrayList<Room> roomList;
  
  int numCombatRooms, numChestRooms, numShopRooms;
  
  Floor(int size) {
    this.roomList = new ArrayList();
    this.numCombatRooms = 0;
    this.numChestRooms = 0;
    this.numShopRooms = 0;
    
    startRoom = new Room(size);
    roomList.add(startRoom);
    
    generateFloor();

    // construct the corridors and remove the ones that shouldn't exist
    for (Room r : roomList) {
      r.constructCorridors();
    }
    for (Room r : roomList) {
      r.removeCorridors();
    }
  }
  
  Floor(int minRooms, int maxRooms) {
    this.roomList = new ArrayList();
    
    while (roomList.size() < minRooms || roomList.size() > maxRooms) {
      this.roomList = new ArrayList();
      this.numCombatRooms = 0;
      this.numChestRooms = 0;
      this.numShopRooms = 0;
      
      startRoom = new Room(65);
      roomList.add(startRoom);
      
      generateFloor();
    }

    // construct the corridors and remove the ones that shouldn't exist
    for (Room r : roomList) {
      r.constructCorridors();
    }
    for (Room r : roomList) {
      r.removeCorridors();
    }
  }
  
  public void generateFloor() {
    ArrayDeque<Room> roomFrontier = new ArrayDeque();
    roomFrontier.add(roomList.get(0));
    
    while (!roomFrontier.isEmpty()) {
      Room currentRoom = roomFrontier.pollFirst(); // this is the room that we will try to generate more rooms from
      
      int xCoord = currentRoom.x; // x-coordinate of the room we are looking at
      int yCoord = currentRoom.y; // y-coordinate of the room we are looking at
      
      
      // randomize the order in which you will generate the rooms
      ArrayList<Integer> orderOfGeneration = new ArrayList();
      orderOfGeneration.add((int)NORTH);
      orderOfGeneration.add((int)SOUTH);
      orderOfGeneration.add((int)EAST);
      orderOfGeneration.add((int)WEST);
      Collections.shuffle(orderOfGeneration);
      
      for (int dir : orderOfGeneration) {
        switch (dir) {
          case NORTH:
            // try to generate north (random(100) + (2^(numA - 1) * sF) < roomChance)
            if (random(100) + Math.pow(4, numRoomsNextToRoom(xCoord, yCoord) - 1) < currentRoom.chanceToGenerateRoom) {
              
              // check if the room already exists at this coordinate
              Room northRoomExists = roomHasBeenGenerated(xCoord, yCoord + 1); // returns room if it exists, null otherwise
              
              if (northRoomExists == null) {
                // the room does not exist and can be generated
                Room northRoom = generateRoom(currentRoom, NORTH, xCoord, yCoord + 1, currentRoom.chanceToGenerateRoom - (random(100) < 60 ? 10 : 5));
                
                // Add room to the list of rooms & frontier
                roomList.add(northRoom);
                roomFrontier.add(northRoom);
                
                println("north room generating from (" + xCoord + "," + (yCoord + 1) + ")");
              }
              else {
                // the room does exist, so just set up references
                currentRoom.roomS = northRoomExists;
                northRoomExists.roomN = currentRoom;
              }
            }
            
            break;
            
          case SOUTH:
            // try to generate south (random(100) + (2^(numA - 1) * sF) < roomChance)
            if (random(100) + Math.pow(4, numRoomsNextToRoom(xCoord, yCoord) - 1) < currentRoom.chanceToGenerateRoom) {
              
              // check if the room already exists at this coordinate
              Room southRoomExists = roomHasBeenGenerated(xCoord, yCoord - 1); // returns room if it exists, null otherwise
              
              if (southRoomExists == null) {
                // the room does not exist and can be generated
                Room southRoom = generateRoom(currentRoom, SOUTH, xCoord, yCoord - 1, currentRoom.chanceToGenerateRoom - (random(100) < 60 ? 10 : 5));
                
                // Add room to the list of rooms & frontier
                roomList.add(southRoom);
                roomFrontier.add(southRoom);
                
                println("south room generating (" + xCoord + "," + (yCoord - 1) + ")");
              }
              else {
                // the room does exist, so just set up references
                currentRoom.roomN = southRoomExists;
                southRoomExists.roomS = currentRoom;
              }
            }
            
            break;
          
          case EAST:
            // try to generate east (random(100) + (2^(numA - 1) * sF) < roomChance)
            if (random(100) + Math.pow(4, numRoomsNextToRoom(xCoord, yCoord) - 1) < currentRoom.chanceToGenerateRoom) {
              
              // check if the room already exists at this coordinate
              Room eastRoomExists = roomHasBeenGenerated(xCoord + 1, yCoord); // returns room if it exists, null otherwise
              
              if (eastRoomExists == null) {
                // the room does not exist and can be generated
                Room eastRoom = generateRoom(currentRoom, EAST, xCoord + 1, yCoord, currentRoom.chanceToGenerateRoom - (random(100) < 60 ? 10 : 5));
                
                // Add room to the list of rooms & frontier
                roomList.add(eastRoom);
                roomFrontier.add(eastRoom);
                
                println("east room generating (" + (xCoord + 1) + "," + yCoord + ")");
              }
              else {
                // the room does exist, so just set up references
                currentRoom.roomE = eastRoomExists;
                eastRoomExists.roomW = currentRoom;
              }
            }
            
            break;
            
          case WEST:
            // try to generate west (random(100) + (2^(numA - 1) * sF) < roomChance)
            if (random(100) + Math.pow(4, numRoomsNextToRoom(xCoord, yCoord) - 1) < currentRoom.chanceToGenerateRoom) {
              
              // check if the room already exists at this coordinate
              Room westRoomExists = roomHasBeenGenerated(xCoord - 1, yCoord); // returns room if it exists, null otherwise
              
              if (westRoomExists == null) {
                // the room does not exist and can be generated
                Room westRoom = generateRoom(currentRoom, WEST, xCoord - 1, yCoord, currentRoom.chanceToGenerateRoom - (random(100) < 60 ? 10 : 5));
                
                // Add room to the list of rooms & frontier
                roomList.add(westRoom);
                roomFrontier.add(westRoom);
                
                println("west room generating (" + (xCoord - 1) + "," + yCoord + ")");
              }
              else {
                // the room does exist, so just set up references
                currentRoom.roomW = westRoomExists;
                westRoomExists.roomE = currentRoom;
              }      
            }
            break;
        }
      }
      
    }
    
    // randomize the direction in which you will generate the boss room
    ArrayList<Integer> orderOfGeneration = new ArrayList();
    orderOfGeneration.add((int)NORTH);
    orderOfGeneration.add((int)SOUTH);
    orderOfGeneration.add((int)EAST);
    orderOfGeneration.add((int)WEST);
    Collections.shuffle(orderOfGeneration);
  
    // the boss room will be next to the last room generated
    boolean bossRoomGenerated = false;
    for (int i = roomList.size() - 1; i >= 0; i--) {
      Room lastRoom = roomList.get(roomList.size() - 1);
      for (int dir : orderOfGeneration) {
        switch (dir) {
          
          case NORTH:
            if (lastRoom.roomN == null) {
              
              Room northRoomExists = roomHasBeenGenerated(lastRoom.x, lastRoom.y + 1);
              if (northRoomExists != null) continue;
              
              bossRoomGenerated = true;
                
              Room bossRoom = new BossRoom(lastRoom, NORTH, lastRoom.x, lastRoom.y + 1, 0);
              roomList.add(bossRoom);
            }
            break;
              
          case SOUTH:
            if (lastRoom.roomS == null) {
              
              Room southRoomExists = roomHasBeenGenerated(lastRoom.x, lastRoom.y - 1);
              if (southRoomExists != null) continue;
              
              bossRoomGenerated = true;
                
              Room bossRoom = new BossRoom(lastRoom, SOUTH, lastRoom.x, lastRoom.y - 1, 0);
              roomList.add(bossRoom);
            }
            break;
            
          case EAST:
            if (lastRoom.roomE == null) {
              
              Room eastRoomExists = roomHasBeenGenerated(lastRoom.x + 1, lastRoom.y);
              if (eastRoomExists != null) continue;
              
              bossRoomGenerated = true;
                
              Room bossRoom = new BossRoom(lastRoom, EAST, lastRoom.x + 1, lastRoom.y, 0);
              roomList.add(bossRoom);
            }
            break;
              
          case WEST:
            if (lastRoom.roomE == null) {
              
              Room westRoomExists = roomHasBeenGenerated(lastRoom.x - 1, lastRoom.y);
              if (westRoomExists != null) continue;
              
              bossRoomGenerated = true;
                
              Room bossRoom = new BossRoom(lastRoom, WEST, lastRoom.x - 1, lastRoom.y, 0);
              roomList.add(bossRoom);
            }
            break;
        }
          
        if (bossRoomGenerated) break;
      }
      
      if (bossRoomGenerated) break;
    }
  }
  
  // returns the number of rooms next to the room at the given coordinates
  public int numRoomsNextToRoom(int x, int y) {
    int numRooms = 0;
    
    for (Room room : this.roomList) {
      if (room.x == x + 1 && room.y == y) numRooms++;
      else if (room.x == x - 1 && room.y == y) numRooms++; 
      else if (room.x == x && room.y == y + 1) numRooms++; 
      else if (room.x == x && room.y == y - 1) numRooms++; 
    }
    
    return numRooms;
  }
  
  // generates a random room in the given direction, from the coordinates of the previous room
  public Room generateRoom(Room previousRoom, int direction, int x, int y, int chanceToGenerateRoom) {
    int roomType = (int) random(100);
    
    Room generatedRoom = new Room(100); // will be reinitialized
    
    if (roomType < 80) {
      generatedRoom = new CombatRoom(previousRoom, direction, x, y, chanceToGenerateRoom);
      numCombatRooms++;
    }
    else if (roomType < 100 && numShopRooms == 0) {
      generatedRoom = new ShopRoom(previousRoom, direction, x, y, chanceToGenerateRoom);
      numShopRooms++;
    }
    else {
      // a chest room should generate here but for now another combat
      generatedRoom = new CombatRoom(previousRoom, direction, x, y, chanceToGenerateRoom);
      numCombatRooms++;
    }
    
    return generatedRoom;
  }
  
  // checks if a room has already been generated at this coordinate, returns the room if it exists, null otherwise
  public Room roomHasBeenGenerated(int x, int y) {
    for (Room room : roomList) {
      if (room.x == x && room.y == y) return room; 
    }
    return null;
  }
  
  public void draw() {
    for (Room rm : map.roomList) {
      // if (rm.visited == false) continue;
      int x = rm.x + 40;
      int y = rm.y + 4;
      
      if (rm.roomType.equals("combat")) fill(200, 0, 0);
      else if (rm.roomType.equals("start")) fill(150, 150, 150);
      else if (rm.roomType.equals("boss")) fill(10);
      
      rect(x * 20, y * 20, 20, 20);
      if (rm.hasTeleporter) {
        fill(0, 0, 255);
        rect(x * 20, y * 20, 10, 10);
      }
      if (rm.isCurrentRoom) {
        fill(0, 255, 0);
        rect(x * 20 + 10, y * 20, 10, 10);
      }
      
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
}
