public class MenuPages {
  int currentPage;
  
  MenuPages(int currentPage) {
    this.currentPage = currentPage;
  }
  
  public void draw() {
    switch (currentPage) {
      case 0: //menu screen
        println("menu");
        break;
      
      case 1: //map size screen
        println("map size");
        break;
      
      case 2: //game screen
        println("game");
        break;
      
      case 3: //victory screen
        println("victory");
        break;
      
      case 4:
        println("defeat");
        break;
    }
  }
}
