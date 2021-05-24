public class Room {
  int x = 0;
  int y = 0;
  
  Room roomN = null;
  Room roomS = null;
  Room roomE = null;
  Room roomW = null;
  
  String roomType;
  int chanceToGenerateRoom;
  
  // constructor for the start room
  Room(int chanceToGenerateRoom) {
    this.roomType = "start";
    this.chanceToGenerateRoom = chanceToGenerateRoom;
  }
}
