public class MeatCleaver extends Enemy{
  int projectileDamage = 1;
  float projectileSpeed = 2.5;
  int cooldown = 50; //does not change
  int c = cooldown;
  
  String[] monster = loadStrings("meatcleaver.txt"); //visual display
  //for hit box of monster
  int monWidth = monster[0].length()*4 + 100; 
  int monHeight = monster.length*4 + 100;
  
  MeatCleaver(float x, float y, int health, int contactDamage) {
    super(x, y, health, contactDamage, MEATCLEAVER);  
  }
  
  public void shootProjectile() {
    // calculates direction of the projectile
    float xDist = p.x - x;
    float yDist = p.y - y;
    
    float angle = atan2(yDist, xDist);
    
    float dx = projectileSpeed * cos(angle);
    float dy = projectileSpeed * sin(angle);
    
    // creates the projectile
    Projectile p1 = new Projectile(x, y, dx, dy, 10, #FF1F1F, projectileDamage, -1, 1, false);
    
    // adds projectile to the projectile list of the room that the player is in
    p.currentRoom.projectileList.add(p1);
  } 
  
  void loadMon(float x, float y, int sideLength){
    x -= monster[0].length()/2 * sideLength; //centers the monster
    y -= monster.length/2 * sideLength; 
    
    float newX = x;
      
    noStroke();

    if (this.x < p.x) {
      for (int i = 0; i < monster.length; i++) {
        
        for (int j = 0; j < monster[0].length(); j++) {
          char colour = monster[i].charAt(j);
          
          if (colour == '0') {
            //space; skip the iteration
          }
          else {
            if (colour == '1') {fill(#BC1111);} //red, darkest
            else if (colour == '2') {fill(#D31313);}
            else if (colour == '3') {fill(#ED1616);}
            else if (colour == '4') {fill(#FC0D0D);} //red, lightest
            else if (colour == '5') {fill(#FFFCFC);} //white
            else if (colour == '6') {fill(#F0EBEB);} //gray-white
            else if (colour == '7') {fill(#000000);} //black
            rect(newX,y, sideLength,sideLength);
          }
          newX += sideLength;
        }
        newX = x; //resets newX
        y += sideLength;
      }
    }
    else {
      for (int i = 0; i < monster.length; i++) {
        
        for (int j = monster[0].length() - 1; j >= 0; j--) {
          char colour = monster[i].charAt(j);
          
          if (colour == '0') {
            //space; skip the iteration
          }
          else {
            if (colour == '1') {fill(#BC1111);} //red, darkest
            else if (colour == '2') {fill(#D31313);}
            else if (colour == '3') {fill(#ED1616);}
            else if (colour == '4') {fill(#FC0D0D);} //red, lightest
            else if (colour == '5') {fill(#FFFCFC);} //white
            else if (colour == '6') {fill(#F0EBEB);} //gray-white
            else if (colour == '7') {fill(#000000);} //black
            rect(newX,y, sideLength,sideLength);
          }
          newX += sideLength;
        }
        newX = x; //resets newX
        y += sideLength;
      }
    }
  }
  
  public void draw() {
    loadMon(x,y,2);
    moveTowardsPlayer();
    //periodically shoots projectile 
    if (c <= 0) {
      shootProjectile();
      this.c = this.cooldown;
    }
    else {
      c -= (int)random(3);
    }
  }

}
