public class ExampleEnemy extends Enemy {
  int projectileDamage = 1;
  float projectileSpeed = 5;
  
  ExampleEnemy(float x, float y, int health, int contactDamage) {
    super(x, y, health, contactDamage);  
  }
  
  public void shootProjectile() {
    float xDist = x - p.x;
    float yDist = y - p.x;
    
    float angle = atan2(yDist, xDist);
    
    float dx = projectileSpeed * cos(angle);
    float dy = projectileSpeed * sin(angle);
    
    Projectile p1 = new Projectile(x, y, dx, dy, projectileDamage, false);
  }
}
