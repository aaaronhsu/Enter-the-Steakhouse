public final int MENU_SCREEN = 0;
public final int MAPSELECT_SCREEN = 1;
public final int GAME_SCREEN = 2;
public final int VICTORY_SCREEN = 3;
public final int DEFEAT_SCREEN = 4;
public final int CONTROLS_SCREEN = 5;
public final int PREVIEW_SCREEN = 6;

public class MenuPages {
  int currentPage;
  int mapSize;
  ArrayList<AnimatedCow> cows = new ArrayList<AnimatedCow>();
  ArrayList<AnimatedCow> reMOOvecows = new ArrayList<AnimatedCow>();
  int time = 100; //doesn't change
  int t = 0;
  
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
        showGame();
        
        mousePressed();
        mouseReleased();
        
        keyPressed();
        keyReleased();

        checkGameState(); // checks if player has won/lost
        break;
      
      case VICTORY_SCREEN: //victory screen
        text("won", 100, 100);
        break;
      
      case DEFEAT_SCREEN:
        text("lost", 100, 100);
        break;
        
      case CONTROLS_SCREEN: //controls screen
        showControls();
        break;
        
      case PREVIEW_SCREEN: //preview screen
        println("preview");
        break;
    }
  }
  
  void cowAnimation(){
    if (t == 0) {
      for (int x = 100; x < width; x += 250) {
        cows.add(new AnimatedCow(x, -20));
      }
      t = time;
    }
    else {
      t--;
    }
    
    for (AnimatedCow c : cows) {
      c.draw();
      if (c.y > height+50) reMOOvecows.add(c);
      println(cows.size());
    }
    for (AnimatedCow c : reMOOvecows) {
      cows.remove(c);
    }
  }
  
  void showMenu(){
    background(#DE1F1F);
    
    cowAnimation();
    
    fill(#DE1F1F);
    rect(120,80,720,100);
    fill(0);
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
    text("CONTROLS", 345, 440);
  }
  
  void showMapSelect(){
    background(#DE1F1F);
    
    fill(#FFFFFF);
    textFont(otherBig, 66);
    text("Map Size", 340, 100);
    
    //hover or selected, box should be highlighted (color changes)
    fill(#000000); 
    if (inBounds(92,175, 225, 100) || mapSize == 1) fill(#19AF35);
    rect(92,175, 225, 100);
    
    fill(#000000);
    if (inBounds(368,175, 225, 100) || mapSize == 2) fill(#1944AF);
    rect(368,175, 225, 100);
    
    fill(#000000);
    if (inBounds(643,175, 225, 100) || mapSize == 3) fill(#CB0003);
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
  
  void showControls(){
    background(0);
    
    textFont(otherBig, 66);
    text("Controls", 350, 100);
    
    textFont(other, 48);
  }

  void checkGameState() {
    if (p.currentRoom.roomType.equals("boss") && ((BossRoom) p.currentRoom).bossSpawned && p.currentRoom.enemyList.isEmpty()) {
      this.currentPage = VICTORY_SCREEN;
    }
    else if (p.health == 0) {
      this.currentPage = DEFEAT_SCREEN;
    }
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
      if (inBounds(325,375,300,100)) this.currentPage = CONTROLS_SCREEN; //clicks on "CONTROLS"
    }
    
    if (this.currentPage == MAPSELECT_SCREEN && mouseButton == LEFT) {
      if (inBounds(92,175, 225, 100)) this.mapSize = 1; //clicks on "Small"
      if (inBounds(368,175, 225, 100)) this.mapSize = 2; //clicks on "Medium"
      if (inBounds(643,175, 225, 100)) this.mapSize = 3; //clicks on "Large"

      if (inBounds(200,375, 225, 125)) this.currentPage = PREVIEW_SCREEN; //clicks on "Preview"
      if (inBounds(535,375, 225, 125) && this.mapSize != '\0') {//clicks on "Start"; cannot click "Start" unless user chose map size
        // generates the map
        switch (this.mapSize) {
          case 1:
            map = new Floor(7, 10); // generates a map that is 7 to 10 rooms large
            println("generating small");
          case 2:
            map = new Floor(10, 15); // generates a map that is 10 to 15 rooms large
            println("generating med");
          case 3:
            map = new Floor(15, 20); // generates a map that is 15 to 20 rooms large
            println("generating large");
        }
        // generates the player
        p = new Player(map.roomList.get(0), 5);
        this.currentPage = GAME_SCREEN;
      }
    }
  }

}
