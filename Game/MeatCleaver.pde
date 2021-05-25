public class MeatCleaver extends Enemy{
  int projectileDamage = 1;
  float projectileSpeed = 5;
  
  MeatCleaver(float x, float y, int health, int contactDamage) {
    super(x, y, health, contactDamage);  
  }
  
  public void shootProjectile() {
    // calculates direction of the projectile
    float xDist = p.x - x;
    float yDist = p.y - y;
    
    float angle = atan2(yDist, xDist);
    
    float dx = projectileSpeed * cos(angle);
    float dy = projectileSpeed * sin(angle);
    
    // creates the projectile
    Projectile p1 = new Projectile(x, y, dx, dy, projectileDamage, false);
    
    // adds projectile to the projectile list of the room that the player is in
    p.currentRoom.projectileList.add(p1);
  }
  
  public void draw() {
    ellipse(x,y, 50,50); //body
    //shoots projectile every 0.4 seconds
    if (millis() % 400 >= 0 && millis() % 400 <= 50) {
      shootProjectile();
    }
  }

}
