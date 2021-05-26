public class Projectile { //Stoves can't have >6 projectiles
  float x, y, dx, dy, w, h;
  color c;
  boolean isPlayerProjectile;
  int damage;
  
  Projectile(float x, float y, float dx, float dy, float w, float h, color c, int damage, boolean isPlayerProjectile) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.w = w;
    this.h = h;
    this.c = c;
    this.damage = damage;
    this.isPlayerProjectile = isPlayerProjectile;
  }
  
  //displays the projectile (the shape)
  void display() {
    fill(c);
    ellipse(x, y, w, h);
  }
  
  void move() {
    x += dx;
    y += dy;
  }
  
  void detectCollision() { //delete projectile after hitting once
    if (!isPlayerProjectile) { //is enemy projectile
      //**30 is player's diameter, so radius is 15; might need to change depending on player size
      if ( Math.abs(p.x-x) <= w/2 + 15 && Math.abs(p.y-y) <= h/2 + 15 ) {
        println("colliding");
      }
    }
    //else { //is player projectile
    //  for (int i = 0; i < p.currentRoom.enemyList.size(); i++) {
    //    Enemy e = p.currentRoom.enemyList.get(i);
    //    if ( Math.abs(e.x-x) <= w/2 + e. && Math.abs(p.y-y) <= h/2 + 15 )
    //  }
    //}
  }
  
  void draw() {
    display();
    move();
    detectCollision();
  }
  
}
