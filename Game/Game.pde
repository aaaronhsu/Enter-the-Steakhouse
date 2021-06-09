//GLOBAL VARIABLES
public final int NORTH = 0;
public final int SOUTH = 1;
public final int EAST = 2;
public final int WEST = 3;

public final int WKEY = 87;
public final int AKEY = 65;
public final int SKEY = 83;
public final int DKEY = 68;
public final int RKEY = 82;

//INSTANCE VARIABLES
public Player p;
public Floor map;

public MenuPages menu;

public void setup() {
  size(960, 540);
  menu = new MenuPages(0);
}



public void draw() {
  background(255, 255, 255);

  noStroke();
  
  menu.draw();
}

  void mousePressed(){
    if (menu.currentPage == GAME_SCREEN) {
      if (mouseButton == LEFT) {
        p.isShooting = true;
      }
      
    }
  }

  void mouseReleased() {
    if (menu.currentPage == GAME_SCREEN) {
      if (mouseButton == LEFT) p.isShooting = false;
    }
  }

  void keyPressed() {
    if (menu.currentPage == GAME_SCREEN) {
      if (keyCode == WKEY || keyCode == AKEY || keyCode == SKEY || keyCode == DKEY) {
        p.changeDirection(true);
      }

      if (keyCode == 9) {
        map.showMap = true;
      }

      if (49 <= keyCode && keyCode <= 52) {
        p.purchaseItem(keyCode - 49);
      }

      if (keyCode == 81 && p.blankCooldown == 0) {
        p.blankCooldown = 100;
        p.useBlank();
      }

      if (keyCode == 70) {
        p.openChest();
      }
    }
  }

  void keyReleased() {
    if (menu.currentPage == GAME_SCREEN) {
      if (keyCode == WKEY || keyCode == AKEY || keyCode == SKEY || keyCode == DKEY) {
        p.changeDirection(false);
      }

      if (keyCode == 9) {
        map.showMap = false;
      }
    }
  }

public char fetchTile(float x, float y) {
  return this.p.currentRoom.roomBlueprint[(int)(y / 30)].charAt((int)(x / 30));
}