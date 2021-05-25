public class Projectile {
  float x, y, dx, dy;
  boolean isPlayerProjectile;
  int damage;
  
  Projectile(float x, float y, float dx, float dy, int damage, boolean isPlayerProjectile) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.damage = damage;
    this.isPlayerProjectile = isPlayerProjectile;
  }
  
}
