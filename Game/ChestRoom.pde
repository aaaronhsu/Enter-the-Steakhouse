public class ChestRoom extends Room {

  boolean chestOpened = false;
  boolean itemPickedUp = false;
  Item item;
  
  ChestRoom(Room previousRoom, int direction, int x, int y, int chanceToGenerateRoom) {
    super(previousRoom, direction, "chest", x, y, chanceToGenerateRoom);

    int itemType = (int) random(2);

    item = new Item(0, true, itemType); // generates either health or a blank
  }

  public void openChest() {
    chestOpened = true;
  }

  public void draw() {
    super.draw();

    if (!chestOpened) {
      drawChest();
    }
    else {
      checkIfItemPickedUp();
      drawItem();
    }
  }

  public void drawChest() {
    String[] colour = loadStrings("chest.txt");
    
    int chestX = width/2 - colour[0].length()/2 * 5; //centers the chest
    int chestY = height/2 - colour.length/2 * 5; 
    
    float newX = chestX;
      
    noStroke();
    for (int i = 0; i < colour.length; i++) {
      
      for (int j = 0; j < colour[0].length(); j++) {
        char c = colour[i].charAt(j);
        
        if (c == '0') {
          //space; skip the iteration
        }
        else {
          if (c == '1') {fill(#000000);} //black
          else if (c == '2') {fill(#FFF52C);} //yellow
          else if (c == '3') {fill(#FFF981);} //light yellow
          else if (c == '4') {fill(#CB731F);} //brown
          else if (c == '5') {fill(#814610);} //dark brown
          else if (c == '6') {fill(#A75A11);} 
          else if (c == '7') {fill(#FFA652);} //light brown
          else if (c == '8') {fill(#6F6A66);} //dark gray
          else if (c == '9') {fill(#9B9794);} //light draw
          rect(newX,chestY, 5,5);
        }
        newX += 5;
      }
      newX = chestX; //resets newX
      chestY += 5;
    }
  }

  public void drawItem() {
    if (!itemPickedUp) item.draw(width / 2, height / 2);
  }

  public void checkIfItemPickedUp() {
    if (abs(p.x - width / 2) < 50 && abs(p.y - height / 2) < 50 && !itemPickedUp) {
      if (item.type == HEALTH) {
      p.health++;
      }
      else if (item.type == BLANK) {
        p.blanks++;
      }

      itemPickedUp = true;
    }
  }
}
