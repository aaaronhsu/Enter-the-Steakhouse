public final int HEALTHITEM = 0;
public final int BLANKITEM = 1;

public class ShopRoom extends Room {

  Item[] items = new Item[3];
  
  ShopRoom(Room previousRoom, int direction, int x, int y, int chanceToGenerateRoom) {
    super(previousRoom, direction, "shop", x, y, chanceToGenerateRoom);
    
    addItemsToRoom();
  }
  
  private void addItemsToRoom() {
    // adds items to room

    for (int i = 0; i < items.length; i++) {
      int itemType = (int) random(2);

      switch (itemType) {
        case HEALTHITEM:
          items[i] = new Item(5, true, HEALTHITEM);
          break;
        
        case BLANKITEM:
          items[i] = new Item(10, true, BLANKITEM);
          break;
      }
    }
  }

  public String toString() {
     return items[0] + ", " + items[1];
  }
}
