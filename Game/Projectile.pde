public class Projectile { //bugs: Stoves can't have >6 projectiles
  float x, y, dx, dy, r;
  color c;
  int damage;
  int despawnTime; //never despawning Projectiles have this = -1
  int numBounces; //number of wall-bounces before despawning; -1 = doesn't despawn; 0 = despawns
  boolean isPlayerProjectile;
  
  Projectile(float x, float y, float dx, float dy, float r, color c, int damage, int despawnTime, int numBounces, boolean isPlayerProjectile) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.r = r;
    this.c = c;
    this.damage = damage;

    this.despawnTime = despawnTime;
    this.numBounces = numBounces;
    this.isPlayerProjectile = isPlayerProjectile;
  }
  
  //displays the projectile (the shape)
  void display() {
    fill(c);
    stroke(0);
    ellipse(x, y, 2*r, 2*r);
  }
  
  void move() {
    x += dx;
    y += dy;
  }
  
  boolean detectCollision() {
    //despawning through wall-bounces
    //if (isWallCollision()) numBounces--;
    
    if (!isPlayerProjectile) { //is enemy projectile
      if ( Math.abs(p.x - x) <= r && Math.abs(p.y - y) <= r ) {
        return true;
      }
    }
    //else { //is player projectile
    //  for (int i = 0; i < p.currentRoom.enemyList.size(); i++) {
    //    Enemy e = p.currentRoom.enemyList.get(i);
    //    
    //  }
    //}
    return false;
  }
  
  boolean isWallCollision(){
    int approxX = (int)(x/60); //walls are tiles that are 60x60
    int approxY = (int)(y/60);
    if (p.currentRoom.roomBlueprint[approxY].charAt(approxX) == WALL) return true;
    return false;
  }
  
  void draw() {
    display();
    move();
    detectCollision();
    
    //despawning through time
    if (despawnTime > 0) despawnTime--;
  }
  
  void despawn() {
    p.currentRoom.projectileList.remove(this);
  }
  
}
