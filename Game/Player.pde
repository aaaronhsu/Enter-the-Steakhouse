public class Player {
  float x, y, speed;
  boolean[] direction;
  
  Room currentRoom;
  
  Player(Room currentRoom, float speed) {
    this.x = width / 2;
    this.y = height / 2;
    this.direction = new boolean[4];
    
    this.speed = speed;
    this.currentRoom = currentRoom;
  }
}
