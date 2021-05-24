public class Floor {
  Room startRoom;
  
  int numCombatRooms, numChestRooms, numShopRooms;
  
  Floor(int size) {
    this.numCombatRooms = 0;
    this.numChestRooms = 0;
    this.numShopRooms = 0;
    
    generateFloor(size);
  }
  
  
}
