public final int MENU_SCREEN = 0;
public final int MAPSELECT_SCREEN = 1;
public final int GAME_SCREEN = 2;
public final int VICTORY_SCREEN = 3;
public final int DEFEAT_SCREEN = 4;
public final int OPTIONS_SCREEN = 5;

public class MenuPages {
  int currentPage;
  PFont titleFont = loadFont("Luminari-Regular-66.vlw");
  PFont other = loadFont("Athelas-Bold-48.vlw");
  
  MenuPages(int currentPage) {
    this.currentPage = currentPage;
    
  }
  
  public void draw() {
    switch (currentPage) {
      case MENU_SCREEN: //menu screen
        showMenu();
        break;
      
      case MAPSELECT_SCREEN: //map size screen
        println("map size");
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
  
  //is mouse in bounds of rect?
  boolean inBounds(int x, int y, int rectwidth, int rectheight){
    return mouseX >= x && mouseX <= x + rectwidth &&
           mouseY >= y && mouseY <= y + rectheight;
  }
  
  void mousePressed(){
    if (mouseButton == LEFT) {
      println("hadsj");
      if (inBounds(325,225,300,100)) {
        println("yay");
        this.currentPage = MAPSELECT_SCREEN; //clicks on "START"
      }
    
      if (inBounds(325,375,300,100)) this.currentPage = OPTIONS_SCREEN; //clicks on "OPTIONS"
    }
  }
}
