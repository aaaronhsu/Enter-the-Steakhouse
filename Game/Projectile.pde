public class Projectile {
  float x, y, dx, dy;
  boolean isPlayerProjectile;
  int damage;
  
  Projectile(float x, float y, int damage, boolean isPlayerProjectile) {
    this.x = x;
    this.y = y;
    this.damage = damage;
    this.isPlayerProjectile = isPlayerProjectile;
  }
  
}
