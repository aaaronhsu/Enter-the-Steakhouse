public class Projectile {
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
    noStroke();
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

  boolean detectCollision() {
    if (!isPlayerProjectile) { //is enemy projectile
      if ( Math.abs(p.x - this.x) <= this.r && Math.abs(p.y - this.y) <= this.r) {
        p.loseHP(this.damage);
        return true;
      }
    }
    else { //is player projectile
      for (Enemy e : p.currentRoom.enemyList) {
        if (checkMonCollision(e)) {
          e.loseHP(p.currentWeapon.damage);
          return true;
        }
      }
    }
    return false;
  }
  
  boolean checkMonCollision(Enemy e){ //collision box of enemy
    return (Math.abs(e.x + e.monWidth/2 - this.x) - 20 <= this.r || Math.abs(e.x - e.monWidth/2 - this.x) - 20 <= this.r)
            && (Math.abs(e.y + e.monHeight/2 - this.y) - 20 <= this.r || Math.abs(e.y - e.monHeight/2 - this.y) - 20 <= this.r);
  }
  
  void draw() {
    display();
    move(); //despawning through wallBounces
    
    //despawning through time
    if (despawnTime > 0) despawnTime--;
  }
  
  void despawn() { //called in Room
    p.currentRoom.projectileList.remove(this);
  }
  
}
