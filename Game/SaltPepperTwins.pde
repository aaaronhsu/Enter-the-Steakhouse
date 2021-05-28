public class SaltPepperTwins extends Enemy{
  int projectileDamage = 1;
  float projectileSpeed = 0;
  int cooldown = 25; //does not change
  int c = cooldown;
  
  SaltPepperTwins(float x, float y, int health, int contactDamage) {
    super(x, y, health, contactDamage);  
  }
  
  public void shootProjectile() {
    // calculates direction of the projectile
    float xDist = p.x - x;
    float yDist = p.y - y;
    
    
    // creates 10 minefield-like projectiles 
    for (int i = 0; i < 10; i++) {
      float xOffset = random(10);
      float yOffset = random(10);
      Projectile p1 = new Projectile(x + xDist/2+xOffset, y + yDist/2+yOffset, 0, 0, 10, #FFFFFF, projectileDamage, 200, false);
      
      // adds projectile to the projectile list of the room that the player is in
      p.currentRoom.projectileList.add(p1);
    }
  
  }
  
  public void draw() {
    ellipse(x,y, 50,50); //body
    
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
