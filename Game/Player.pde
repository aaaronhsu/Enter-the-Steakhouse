public class Player {
  float x, y, speed;
  boolean[] direction;
  
  Room currentRoom;
  
  int health;
  int money;
  int blanks;
  ArrayList<Weapon> weaponList;
  Weapon currentWeapon;
  
  Player(Room currentRoom, float speed) {
    this.x = width / 2;
    this.y = height / 2;
    this.direction = new boolean[4];
    
    this.speed = speed;
    this.currentRoom = currentRoom;
  }
  
  public void draw() {
    fill(0);
    ellipseMode(CENTER);
    ellipse(this.x, this.y, 30, 30);
  }
  
  public void move() {
    int x = (direction[EAST] ? 1 : 0) + (direction[WEST] ? -1 : 0);
    int y = (direction[NORTH] ? -1 : 0) + (direction[SOUTH] ? 1 : 0);
    
    this.x += speed * x;
    this.y += speed * y;
    
    checkIfRoomChange();
  }
  
  // responsible for switching room
  public void checkIfRoomChange() {
    if (this.x <= 0) {
      // GOING WEST
      if (this.currentRoom.roomW != null) {
        this.currentRoom.isCurrentRoom = false;
        this.currentRoom.roomW.isCurrentRoom = true;
        
        this.currentRoom = this.currentRoom.roomW;
        this.x = width / 2;
        this.y = height / 2;
      }
      else this.x = 0;
    }
    else if (this.x >= width) {
      // GOING EAST
      if (this.currentRoom.roomE != null) {
        this.currentRoom.isCurrentRoom = false;
        this.currentRoom.roomE.isCurrentRoom = true;
        
        this.currentRoom = this.currentRoom.roomE;
        this.x = width / 2;
        this.y = height / 2;
      }
      else this.x = width;
    }
    if (this.y <= 0) {
      // GOING NORTH
      if (this.currentRoom.roomN != null) {
        this.currentRoom.isCurrentRoom = false;
        this.currentRoom.roomN.isCurrentRoom = true;
        
        this.currentRoom = this.currentRoom.roomN;
        this.x = width / 2;
        this.y = height / 2;
      }
      else this.y = 0;
    }
    else if (this.y >= height) {
      // GOING SOUTH
      if (this.currentRoom.roomS != null) {
        this.currentRoom.isCurrentRoom = false;
        this.currentRoom.roomS.isCurrentRoom = true;
        
        this.currentRoom = this.currentRoom.roomS;
        this.x = width / 2;
        this.y = height / 2;
      }
      else this.y = height;
    }
  }
  
  public void changeDirection(boolean moving) {
    switch (keyCode) {
      case 87:
        direction[NORTH] = moving;
        break;
      case 82:
        direction[SOUTH] = moving;
        break;
      case 83:
        direction[EAST] = moving;
        break;
      case 65:
        direction[WEST] = moving;
        break;
    }
  }
}
