public final int MENU_SCREEN = 0;
public final int MAPSELECT_SCREEN = 1;
public final int GAME_SCREEN = 2;
public final int VICTORY_SCREEN = 3;
public final int DEFEAT_SCREEN = 4;
public final int OPTIONS_SCREEN = 5;

public final char SMALL = 'S';
public final char MEDIUM = 'M';
public final char LARGE = 'L';

public class MenuPages {
  int currentPage;
  char mapSize;
  
  PFont titleFont = loadFont("Luminari-Regular-66.vlw");
  PFont other = loadFont("Athelas-Bold-48.vlw");
  PFont otherBig = loadFont("Athelas-Bold-66.vlw");
  
  MenuPages(int currentPage) {
    this.currentPage = currentPage;
    
  }
  
  public void draw() {
    switch (currentPage) {
      case MENU_SCREEN: //menu screen
        showMenu();
        mousePressed();
        break;
      
      case MAPSELECT_SCREEN: //map size screen
        showMapSelect();
        mousePressed();
        break;
      
      case GAME_SCREEN: //game screen
        //println("game");
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
    if (inBounds(92,175, 225, 100) || mapSize == 'S') fill(#19AF35);
    rect(92,175, 225, 100);
    
    fill(#000000);
    if (inBounds(368,175, 225, 100) || mapSize == 'M') fill(#1944AF);
    rect(368,175, 225, 100);
    
    fill(#000000);
    if (inBounds(643,175, 225, 100) || mapSize == 'L') fill(#CB0003);
    rect(643,175, 225, 100);  
    
    fill(#FFFFFF);
    textFont(other, 48);
    text("Small", 143, 240);
    text("Medium", 393, 240);
    text("Large", 695, 240);
  }
  
  //is mouse in bounds of rect?
  boolean inBounds(int x, int y, int rectwidth, int rectheight){
    return mouseX >= x && mouseX <= x + rectwidth &&
           mouseY >= y && mouseY <= y + rectheight;
  }
  
  void mousePressed(){
    if (this.currentPage == MENU_SCREEN && mouseButton == LEFT) {
      if (inBounds(325,225,300,100)) this.currentPage = MAPSELECT_SCREEN; //clicks on "START"
      if (inBounds(325,375,300,100)) this.currentPage = OPTIONS_SCREEN; //clicks on "OPTIONS"
    }
    
    if (this.currentPage == MAPSELECT_SCREEN && mouseButton == LEFT) {
      if (inBounds(92,175, 225, 100)) this.mapSize = 'S'; //clicks on "Small"
      if (inBounds(368,175, 225, 100)) this.mapSize = 'M'; //clicks on "Medium"
      if (inBounds(643,175, 225, 100)) this.mapSize = 'L'; //clicks on "Large"
    }
  }
}
