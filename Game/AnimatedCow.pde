public class AnimatedCow{
  
  float x;
  float y;
  String[] cow = loadStrings("cowpixel.txt"); //visual display
  
  public AnimatedCow(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void loadCow(float x, float y, int sideLength){
    x -= cow[0].length()/2 * sideLength; //centers the cow
    y -= cow.length/2 * sideLength; 
    
    float newX = x;
      
    noStroke();
    for (int i = 0; i < cow.length; i++) {
      
      for (int j = 0; j < cow[0].length(); j++) {
        char colour = cow[i].charAt(j);
        
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
  
  void move(){
    y+=2;
  }
  
  void draw(){
    loadCow(x,y,5);
    move();
  }
  
}
