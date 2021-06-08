public class ChestRoom extends Room {

  boolean chestOpened = false;
  Item item;
  
  ChestRoom(Room previousRoom, int direction, int x, int y, int chanceToGenerateRoom) {
    super(previousRoom, direction, "chest", x, y, chanceToGenerateRoom);
  }

  public void draw() {
    super.draw();

    if (chestOpened) {
      drawChest();
    }
  }

  // YAYING PLEASE DRAW THE CHEST AT THE CENTER OF THE ROOM
  public void drawChest() {

  }
}
