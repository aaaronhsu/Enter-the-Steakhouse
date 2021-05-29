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
