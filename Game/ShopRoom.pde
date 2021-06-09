<<<<<<< HEAD
public class ShopRoom extends Room {
  Item[] items = new Item[4];

public final int HEALTHITEM = 0;
public final int BLANKITEM = 1;

public class ShopRoom extends Room {

  Item[] items = new Item[3];
  
  ShopRoom(Room previousRoom, int direction, int x, int y, int chanceToGenerateRoom) {
    super(previousRoom, direction, "shop", x, y, chanceToGenerateRoom);
    
    addItemsToRoom();
  }

  public void addItemsToRoom() {
    for (int i = 0; i < 3; i++) {
      int itemType = (int) random(3);

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

    items[3] = new Item(25, false, WEAPON);
  }
  public void purchaseItem(int itemIndex) {
    if (items[itemIndex] == null) return;

    if (items[itemIndex].purchase()) items[itemIndex] = null;
  }

  public void draw() {
    super.draw();

    int xText = 500;
    int yText = 250;

    fill(0);
    text("This is the stuff on sale", xText, yText);

    for (int i = 0; i < items.length; i++) {
      yText += 50;
      if (items[i] == null) continue;
      text(items[i].toString() + " (press " + (i + 1) + " to buy)", xText, yText);
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
