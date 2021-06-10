public class ShopRoom extends Room {
  Item[] items = new Item[4];

  String[] coinColour = loadStrings("coin.txt");

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
    text("Use buttons (1-4) to purchase items!", xText, yText + 10);

    for (int i = 0; i < items.length; i++) {
      yText += 50;
      if (items[i] == null) continue;
      text("(" + (i + 1) + ")", xText - 48, yText + 5);
      items[i].draw(xText, yText);

      text("(" + items[i].cost, xText + 30, yText + 5);
      drawCoin(xText + 65, yText, 1);
      text(")", xText + 75, yText + 5);
    }
  }

  void drawCoin(float x, float y, int sideLength) {
    x -= coinColour[0].length()/2 * sideLength; //centers the coin
    y -= coinColour.length/2 * sideLength; 
    
    float newX = x;
      
    noStroke();
    for (int i = 0; i < coinColour.length; i++) {
      
      for (int j = 0; j < coinColour[0].length(); j++) {
        char c = coinColour[i].charAt(j);
        
        if (c == '0') {
          //space; skip the iteration
        }
        else {
          if (c == '1') {fill(#000000);} //black
          else if (c == '2') {fill(#FFFFFF);} //white
          else if (c == '3') {fill(#FEFF12);} //bright yellow
          else if (c == '4') {fill(#FFE02E);} //cheese yellow
          else if (c == '5') {fill(#B6B909);} //dirty yellow
          rect(newX,y, sideLength,sideLength);
        }
        newX += sideLength;
      }
      newX = x; //resets newX
      y += sideLength;
    }
  }

}
