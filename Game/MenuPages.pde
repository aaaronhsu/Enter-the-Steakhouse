public final int MENU_SCREEN = 0;
public final int MAPSELECT_SCREEN = 1;
public final int GAME_SCREEN = 2;
public final int VICTORY_SCREEN = 3;
public final int DEFEAT_SCREEN = 4;
public final int OPTIONS_SCREEN = 5;
public final int PREVIEW_SCREEN = 6;

public final char SMALL = 'S';
public final char MEDIUM = 'M';
public final char LARGE = 'L';

public class MenuPages {
  int currentPage;
  int mapSize;
  
  //delete/move?
  String[] monster = loadStrings("cowpixel.txt"); //visual display
  
  PFont titleFont = loadFont("Luminari-Regular-66.vlw");
  PFont other = loadFont("Athelas-Bold-48.vlw");
  PFont otherBig = loadFont("Athelas-Bold-66.vlw");
  
  MenuPages(int currentPage) {
    this.currentPage = currentPage;
    
  }
  
  void loadMon(float x, float y, int sideLength){
    x -= monster[0].length()/2 * sideLength; //centers the monster
    y -= monster.length/2 * sideLength; 
    
    float newX = x;
      
    noStroke();
    for (int i = 0; i < monster.length; i++) {
      
      for (int j = 0; j < monster[0].length(); j++) {
        char colour = monster[i].charAt(j);
        
        if (colour == '0') {
          //space; skip the iteration
        }
        else {
          if (colour == '1') {fill(#000000);} //black
          else if (colour == '2') {fill(#FFFFFF);} //white
          else if (colour == '3') {fill(#FF8BA8);} //pink
          rect(newX,y, sideLength,sideLength);
        }
        newX += sideLength;
      }
      newX = x; //resets newX
      y += sideLength;
    }
  }
  
  public void draw() {
    switch (currentPage) {
      case MENU_SCREEN: //menu screen
        showMenu();
        loadMon(300,300, 7);
        mousePressed();
        break;
      
      case MAPSELECT_SCREEN: //map size screen
        showMapSelect();
        mousePressed();
        break;
      
      case GAME_SCREEN: //game screen
        showGame();

        mousePressed();
        mouseReleased();

        keyPressed();
        keyReleased();
        break;
      
      case VICTORY_SCREEN: //victory screen
        //println("victory");
        break;
      
      case DEFEAT_SCREEN:
        //println("defeat");
        break;
        
      case OPTIONS_SCREEN: //options screen
        println("options");
        break;
        
      case PREVIEW_SCREEN: //preview screen
        println("preview");
        break;
    }
  }
  
  void showMenu(){
    background(#DE1F1F);
    
    textFont(titleFont, 66);
    text("Enter the Steakhouse", width/6 - 15, 150);
    
    fill(#000000);
    if (inBounds(325,225,300,100)) fill(#05AD36);
    rect(325,225, 300, 100);
    
    fill(#000000);
    if (inBounds(325,375,300,100)) fill(#05AD36);
    rect(325,375, 300, 100);
    
    fill(#FFFFFF);
    textFont(other, 48);
    text("START", 398, 288);
    text("OPTIONS", 370, 440);
  }
  
  void showMapSelect(){
    background(#DE1F1F);
    
    fill(#FFFFFF);
    textFont(otherBig, 66);
    text("Map Size", 340, 100);
    
    //hover or selected, box should be highlighted (color changes)
    fill(#000000); 
    if (inBounds(92,175, 225, 100) || mapSize == 0) fill(#19AF35);
    rect(92,175, 225, 100);
    
    fill(#000000);
    if (inBounds(368,175, 225, 100) || mapSize == 1) fill(#1944AF);
    rect(368,175, 225, 100);
    
    fill(#000000);
    if (inBounds(643,175, 225, 100) || mapSize == 2) fill(#CB0003);
    rect(643,175, 225, 100);  
    
    //boxes for 'Preview' and 'Start'
    fill(#000000);
    if (inBounds(200,375, 225, 125)) fill(#05AD36);
    rect(200,375, 225, 125);
    
    fill (#000000);
    if (inBounds(535,375, 225, 125)) fill(#05AD36);
    rect(535,375, 225, 125);
    
    fill(#FFFFFF);
    textFont(other, 48);
    text("Small", 143, 240);
    text("Medium", 393, 240);
    text("Large", 695, 240);
    text("Preview", 227, 450);
    text("Start", 595, 450);
  }
  
  void showGame(){
    //load game
    p.currentRoom.draw();
  
    p.move();
    p.draw();
    map.draw();
  }
  
  //is mouse in bounds of rect?
  boolean inBounds(int x, int y, int rectwidth, int rectheight){
    return mouseX >= x && mouseX <= x + rectwidth &&
           mouseY >= y && mouseY <= y + rectheight;
  }
  
  void mousePressed(){
    if (this.currentPage == MENU_SCREEN && mouseButton == LEFT) {
      if (inBounds(325,225,300,100)) {
        this.currentPage = MAPSELECT_SCREEN; //clicks on "START"
      }
      if (inBounds(325,375,300,100)) this.currentPage = OPTIONS_SCREEN; //clicks on "OPTIONS"
    }
    
    if (this.currentPage == MAPSELECT_SCREEN && mouseButton == LEFT) {
      if (inBounds(92,175, 225, 100)) this.mapSize = 0; //clicks on "Small"
      if (inBounds(368,175, 225, 100)) this.mapSize = 1; //clicks on "Medium"
      if (inBounds(643,175, 225, 100)) this.mapSize = 2; //clicks on "Large"

      if (inBounds(200,375, 225, 125)) this.currentPage = PREVIEW_SCREEN; //clicks on "Preview"
      if (inBounds(535,375, 225, 125)) {
        // generates the map
        switch (this.mapSize) {
          case 0:
            map = new Floor(7, 10); // generates a map that is 7 to 10 rooms large
            println("generating small");
          case 1:
            map = new Floor(10, 15); // generates a map that is 10 to 15 rooms large
            println("generating med");
          case 2:
            map = new Floor(15, 20); // generates a map that is 15 to 20 rooms large
            println("generating large");
          default:
            map = new Floor(10, 15); // generates a map that is 10 to 15 rooms large
            println("generating def");
            println(this.mapSize);
        }
        
        // generates the player
        p = new Player(map.roomList.get(0), 5);
        this.currentPage = GAME_SCREEN; //clicks on "Start"
      }
    }

    if (this.currentPage == GAME_SCREEN) {
      if (mouseButton == LEFT) p.isShooting = true;
    }
  }

  void mouseReleased() {

    if (this.currentPage == GAME_SCREEN) {
      if (mouseButton == LEFT) p.isShooting = false;
    }
  }

  void keyPressed() {
    if (this.currentPage == GAME_SCREEN) {
      if (keyCode == WKEY || keyCode == AKEY || keyCode == SKEY || keyCode == RKEY) {
        p.changeDirection(true);
      }

      if (keyCode == 9) {
        map.showMap = true;
      }

      if (49 <= keyCode && keyCode <= 52) {
        p.purchaseItem(keyCode - 49);
      }

      if (keyCode == 81) {
        p.useBlank();
      }
    }
  }

  void keyReleased() {
    if (this.currentPage == GAME_SCREEN) {
      if (keyCode == WKEY || keyCode == AKEY || keyCode == SKEY || keyCode == RKEY) {
        p.changeDirection(false);
      }

      if (keyCode == 9) {
        map.showMap = false;
      }
    }
  }
}
