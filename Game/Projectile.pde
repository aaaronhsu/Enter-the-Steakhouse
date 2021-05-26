public class Projectile {
  float x, y, dx, dy, w, h;
  boolean isPlayerProjectile;
  int damage;
  
  Projectile(float x, float y, float dx, float dy, float w, float h, int damage, boolean isPlayerProjectile) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.w = w;
    this.h = h;
    this.damage = damage;
    this.isPlayerProjectile = isPlayerProjectile;
  }
  
  //displays the projectile (the shape)
  void display() {
    ellipse(x, y, w, h);
  }
  
  void move() {
    x += dx;
    y += dy;
  }
  
  void draw() {
    display();
    move();
    //detect collision
  }
  
}
