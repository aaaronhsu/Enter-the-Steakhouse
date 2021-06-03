public class BossProjectile extends Projectile{
  BossProjectile(float x, float y, float dx, float dy, float r, color c, int damage, int despawnTime, int numBounces, boolean isPlayerProjectile) {
    super(x, y, dx, dy, r, c, damage, despawnTime, numBounces, isPlayerProjectile);
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
     //y += dy + (2 * time);
     //time += 0.1;
   }
  }
  
  //has draw() method inherited from Projectile
}
