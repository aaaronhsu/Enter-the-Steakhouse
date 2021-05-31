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
  
  boolean checkWallCollision(float x, float y){
    return fetchTile(x, y) == WALL || fetchTile(x, y) == CORRIDOR;
  }

  void detectCollision() {
    if (!isPlayerProjectile) { //is enemy projectile
      if ( Math.abs(p.x - x) <= r && Math.abs(p.y - y) <= r ) {
        p.loseHP(1);
      }
    }
    else { //is player projectile
      for (int i = 0; i < p.currentRoom.enemyList.size(); i++) {
        Enemy e = p.currentRoom.enemyList.get(i);
        
      }
    }

  }
  
  
  void draw() {
    display();
    move(); //despawning through wallBounces
    detectCollision();
    
    //despawning through time
    if (despawnTime > 0) despawnTime--;
  }
  
  void despawn() { //called in Room
    p.currentRoom.projectileList.remove(this);
  }
  
}
