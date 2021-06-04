public final int MENU_SCREEN = 0;
public final int MAPSELECT_SCREEN = 1;
public final int GAME_SCREEN = 2;
public final int VICTORY_SCREEN = 3;
public final int DEFEAT_SCREEN = 4;

public class MenuPages {
  int currentPage;
  PFont titleFont = loadFont("Luminari-Regular-66.vlw");
  
  MenuPages(int currentPage) {
    this.currentPage = currentPage;
    
  }
  
  public void draw() {
    switch (currentPage) {
      case MENU_SCREEN: //menu screen
        showMenu();
        //println("menu");
        break;
      
      case MAPSELECT_SCREEN: //map size screen
        //println("map size");
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
    }
  }
  
  void showMenu(){
    background(#DE1F1F);
    
    textFont(titleFont, 66);
    String title = "Enter the Steakhouse";
    text(title, width/6 - 15, 150);
    
    rect(300,300, 300, 200);
    
  }
}
