public class Projectile { //bugs: Stoves can't have >6 projectiles
  float x, y, dx, dy, r;
  color c;
  int damage;
  int despawnTime; //never despawning Projectiles have this = -1
  boolean isPlayerProjectile;
  
  Projectile(float x, float y, float dx, float dy, float r, color c, int damage, int despawnTime, boolean isPlayerProjectile) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.r = r;
    this.c = c;
    this.damage = damage;
    this.despawnTime = despawnTime;
    this.isPlayerProjectile = isPlayerProjectile;
  }
  
  //displays the projectile (the shape)
  void display() {
    fill(c);
    ellipse(x, y, 2*r, 2*r);
  }
  
  void move() {
    x += dx;
    y += dy;
  }
  
  void detectCollision() {
    if (!isPlayerProjectile) { //is enemy projectile
      if ( Math.abs(p.x - x) <= r && Math.abs(p.y - y) <= r ) {
        println("colliding");
        despawn();
      }
    }
    //else { //is player projectile
    //  for (int i = 0; i < p.currentRoom.enemyList.size(); i++) {
    //    Enemy e = p.currentRoom.enemyList.get(i);
    //    
    //  }
    //}
  }
  
  void draw() {
    display();
    move();
    detectCollision();
    
    //despawning
    if (despawnTime > 0) despawnTime--;
    else if (despawnTime == 0) despawn();
  }
  
  void despawn() {
    p.currentRoom.projectileList.remove(this);
  }
  
}
