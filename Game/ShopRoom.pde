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
      int itemType = (int) random(1);

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

  public boolean purchaseItem(int itemIndex) {
    if (items[itemIndex] == null) return false;

    if (p.money >= items[itemIndex].cost) {
      items[itemIndex].equip();
      p.money -= items[itemIndex].cost;
      items[itemIndex] = null;
      println("purchased item");
      return true;
    }

    return false;
  }

  public String toString() {
     return items[0] + ", " + items[1];
  }
}
