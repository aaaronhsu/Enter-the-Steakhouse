public class BossProjectile extends Projectile{
  
  int mode;
  
  BossProjectile(float x, float y, float dx, float dy, float r, color c, int damage, int despawnTime, int numBounces, boolean isPlayerProjectile, int mode) {
    super(x, y, dx, dy, r, c, damage, despawnTime, numBounces, isPlayerProjectile);
    this.mode = mode;
  }

  void move() {
   if (checkWallCollision(this.x + dx + r, this.y) || checkWallCollision(this.x + dx - r, this.y)) {
     numBounces--;
     dx *= -1;
   }
   else {
     x += dx;
   }

   if (checkWallCollision(this.x, this.y + dy + r) || checkWallCollision(this.x, this.y + dy - r)) {
     numBounces--;
     dy *= -1;
   }
   else {
     y += dy;
   }
 }
  
  //has draw() method inherited from Projectile
}
