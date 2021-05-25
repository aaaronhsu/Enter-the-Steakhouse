public class Weapon extends Item {
  float fireRate, projectileSize, damage;
  int type;
  
  Weapon(float fireRate, float projectileSize, float damage, int type) {
    this.fireRate = fireRate;
    this.projectileSize = projectileSize;
    this.damage = damage;
    this.type = type;
  }
  
  // will add a projectile object to the projectile list of the room that the player is in
  public void shootProjectile(float x, float y) {
    
  }
  
  // will draw the weapon on the player
  public void draw() {
    
  }
}
