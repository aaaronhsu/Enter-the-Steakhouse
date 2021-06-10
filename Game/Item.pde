public final int HEALTH = 0;
public final int BLANK = 1;
public final int KEY = 2;
public final int WEAPON = 3;

public class Item {
  int cost;
  boolean isConsumable;
  int type;

  String[] heartColour = loadStrings("heart.txt");
  String[] blankColour = loadStrings("milk.txt");
  String[] keyColour = loadStrings("key.txt");
  String[] coinColour = loadStrings("coin.txt");
  String[] cow = loadStrings("cowpixel.txt"); 

  Item(int cost, boolean isConsumable, int type) {
    this.cost = cost;
    this.isConsumable = isConsumable;
    this.type = type;
  }

  public boolean purchase() {
    if (p.money >= cost) {
      p.money -= cost;
    }
    else return false;

    if (this.isConsumable) {
      switch (this.type) {
        case HEALTH:
          p.health++;
          break;
        case BLANK:
          p.blanks++;
          break;
        case KEY:
          p.keys++;
          break;
      }
    }
    
    else equipWeapon();
    return true;
  }

  public void equipWeapon() {
    if (this.cost == 25) {
      Weapon shotgun = new Weapon(15, 5, 1, 1);
      p.currentWeapon = shotgun;
    }
  }

  public String toString() {
    switch (this.type) {
      case HEALTH:
        return "HEALTH FOR " + this.cost + " MOONIES";
      case BLANK:
        return "BLANK FOR " + this.cost + " MOONIES";
      case KEY:
        return "KEY FOR " + this.cost + " MOONIES";
      case WEAPON:
        return "SHOTGUN FOR " + this.cost + " MOONIES";
    }

    return "IDK WHAT ITEM THIS IS";
  }

  public void draw(float x, float y) {
    switch (this.type) {
      case HEALTH:
        drawHeart(x, y, 2);
        break;
      case BLANK:
        drawBlank(x, y, 1);
        break;
      case KEY:
        drawKey(x, y, 2);
        break;
      case WEAPON:
        drawWeapon(x, y, 2);
        break;
    }
  }

  void drawHeart(float x, float y, int sideLength){
    x -= heartColour[0].length()/2 * sideLength; //centers the heart
    y -= heartColour.length/2 * sideLength; 
    
    float newX = x;
      
    noStroke();
    for (int i = 0; i < heartColour.length; i++) {
      
      for (int j = 0; j < heartColour[0].length(); j++) {
        char c = heartColour[i].charAt(j);
        
        if (c == '0') {
          //space; skip the iteration
        }
        else {
          if (c == '1') {fill(#000000);} //black
          else if (c == '2') {fill(#FF0505);} //bright red
          else if (c == '3') {fill(#CB1515);} //dark red
          else if (c == '4') {fill(#FFFFFF);} //white
          rect(newX,y, sideLength,sideLength);
        }
        newX += sideLength;
      }
      newX = x; //resets newX
      y += sideLength;
    }
  }

  void drawBlank(float x, float y, int sideLength) {
    x -= blankColour[0].length()/2 * sideLength; //centers the blank (milk carton)
    y -= blankColour.length/2 * sideLength; 
    
    float newX = x;
      
    noStroke();
    for (int i = 0; i < blankColour.length; i++) {
      
      for (int j = 0; j < blankColour[0].length(); j++) {
        char c = blankColour[i].charAt(j);
        
        if (c == '0') {
          //space; skip the iteration
        }
        else {
          if (c == '1') {fill(#000000);} //black
          else if (c == '2') {fill(#FFFFFF);} //white
          else if (c == '3') {fill(#9DEBFF);} //cyan blue
          else if (c == '4') {fill(#9DFFF1);} 
          else if (c == '5') {fill(#95C4FF);} //light blue 
          else if (c == '6') {fill(#7491FF);} //
          else if (c == '7') {fill(#524DFF);} //dark blue
          else if (c == '8') {fill(#FCF2CC);} //beige

          rect(newX,y, sideLength,sideLength);
        }
        newX += sideLength;
      }
      newX = x; //resets newX
      y += sideLength;
    }
  }
  
  void drawKey(float x, float y, int sideLength){
    x -= keyColour[0].length()/2 * sideLength; //centers the key
    y -= keyColour.length/2 * sideLength; 
    
    float newX = x;
      
    noStroke();
    for (int i = 0; i < keyColour.length; i++) {
      
      for (int j = 0; j < keyColour[0].length(); j++) {
        char c = keyColour[i].charAt(j);
        
        if (c == '0') {
          //space; skip the iteration
        }
        else {
          if (c == '1') {fill(0);} //black
          else if (c == '2') {fill(#FFFFFF);} //white
          else if (c == '3') {fill(#FFED21);} //bright yellow
          else if (c == '4') {fill(#FCD821);} //
          else if (c == '5') {fill(#FFB012);} //orange
          else if (c == '5') {fill(#DE9C16);} //brown
          rect(newX,y, sideLength,sideLength);
        }
        newX += sideLength;
      }
      newX = x; //resets newX
      y += sideLength;
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

  void drawWeapon(float x, float y, int sideLength) {
    fill(0);
    ellipse(x, y, 10, 10);
  }
}
