public class ShopRoom extends Room {
  Item[] items = new Item[4];

  ShopRoom(Room previousRoom, int direction, int x, int y, int chanceToGenerateRoom) {
    super(previousRoom, direction, "shop", x, y, chanceToGenerateRoom);
    
    addItemsToRoom();
  }

  public void addItemsToRoom() {
    for (int i = 0; i < 4; i++) {
      int itemType = (int) random(4);

      switch (itemType) {
        case HEALTH:
          items[i] = new Item(10, true, HEALTH);
          break;
        case BLANK:
          items[i] = new Item(5, true, BLANK);
          break;
        case KEY:
          items[i] = new Item(5, true, KEY);
          break;
        case WEAPON:
          items[i] = new Item(15, false, WEAPON);
          break;
      }
    }
  }

  public void draw() {
    super.draw();

    int xText = 500;
    int yText = 200;

    text("This is the stuff on sale", xText, yText);

    for (int i = 0; i < items.length; i++) {
      yText += 50;
      text(items[i].toString() + " (press " + (i + 1) + " to buy)", xText, yText);
    }
  }
}