public class Gardener extends Enemy{
  int projectileDamage = 1;
  float projectileSpeed = 7;
  int cooldown = 30; //does not change
  int c = cooldown;
  
  Gardener(float x, float y, int health, int contactDamage) {
    super(x, y, health, contactDamage);  
  }
  
  public void shootProjectile() {
    // calculates direction of the projectile
    float xDist = p.x - x;
    float yDist = p.y - y;
    
    float angle = atan2(yDist, xDist);
    
    // creates 3 projectiles 120 degrees apart
    for (int i = 0; i <= radians(240); i+= radians(120)) {
      float dx = projectileSpeed * cos(angle+i);
      float dy = projectileSpeed * sin(angle+i);
      Projectile p1 = new Projectile(x, y, dx, dy, 40, #9B9191, projectileDamage, 200, 3, false);
      
      // adds projectile to the projectile list of the room that the player is in
      p.currentRoom.projectileList.add(p1);
    }
  
  }
  
  void loadMon(float x, float y, int sideLength){
    String[] monster = loadStrings("gardener.txt");
    
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
          if (colour == '1') {fill(#126F17);} //green, darkest
          else if (colour == '2') {fill(#0DBF17);}
          else if (colour == '3') {fill(#86FF99);} //green, lightest
          else if (colour == '4') {fill(#A7630F);} //brown
          else if (colour == '5') {fill(#030303);} //black
          else if (colour == '6') {fill(#FFF97E);} //yellow
          rect(newX,y, sideLength,sideLength);
        }
        newX += sideLength;
      }
      newX = x; //resets newX
      y += sideLength;
    }
  }
  
  public void draw() {
    loadMon(x,y, 4);
    
    //periodically shoots projectile 
    if (c == 0) {
      shootProjectile();
      this.c = this.cooldown;
    }
    else {
      c--;
    }
  }

}
