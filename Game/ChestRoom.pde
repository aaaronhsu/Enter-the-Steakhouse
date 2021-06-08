public class ChestRoom extends Room {

  boolean chestOpened = false;
  Item item;
  
  ChestRoom(Room previousRoom, int direction, int x, int y, int chanceToGenerateRoom) {
    super(previousRoom, direction, "chest", x, y, chanceToGenerateRoom);

    int itemType = (int) random(2);

    item = new Item(0, true, itemType); // generates either health or a blank
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
