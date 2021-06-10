public final int PISTOL = 0;
public final int SHOTGUN = 1;

public class Weapon extends Item {
  float projectileSize, damage;
  int timeUntilNextShot, fireRate;
  int type;
  
  String[] pistolColour = loadStrings("pistol.txt");
  String[] shotgunColour = loadStrings("shotgun.txt");
  
  Weapon(int fireRate, float projectileSize, float damage, int type) {
    
    super(type * 10, false, WEAPON);

    this.fireRate = fireRate;
    this.projectileSize = projectileSize;
    this.damage = damage;
    this.type = type;
    this.timeUntilNextShot = 0;
  }
  
  // will add a projectile object to the projectile list of the room that the player is in
  public void shootProjectile() {
    if (this.timeUntilNextShot != 0) {
      return;
    }

    float dx, dy;
    Projectile proj;
    int projectileSpeed;
    
    this.timeUntilNextShot = this.fireRate;

    float xDist = mouseX - p.x;
    float yDist = mouseY - p.y;
        
    float angle = atan2(yDist, xDist);

    // projectile constructor
    // float x, float y, float dx, float dy, float r, color c, int damage, int despawnTime, int numBounces, boolean isPlayerProjectile

    switch (type) {
      case PISTOL:
        projectileSpeed = 8;
        
        dx = projectileSpeed * cos(angle);
        dy = projectileSpeed * sin(angle);

        proj = new Projectile(p.x, p.y, dx, dy, 5, #FFFFFF, 1, -1, 2, true);

        p.currentRoom.projectileList.add(proj);
        break;
      
      case SHOTGUN:
        projectileSpeed = 5;

        proj = new Projectile(p.x, p.y, projectileSpeed * cos(angle), projectileSpeed * sin(angle), 5, #FFFFFF, 1, -1, 2, true);
        Projectile proj2 = new Projectile(p.x, p.y, projectileSpeed * cos(angle + 0.1), projectileSpeed * sin(angle + 0.1), 3, #FFFFFF, 1, -1, 1, true);
        Projectile proj3 = new Projectile(p.x, p.y, projectileSpeed * cos(angle - 0.1), projectileSpeed * sin(angle - 0.1), 3, #FFFFFF, 1, -1, 1, true);

        p.currentRoom.projectileList.add(proj);
        p.currentRoom.projectileList.add(proj2);
        p.currentRoom.projectileList.add(proj3);
        break;
    }
  }
  
  void drawPistol(float x, float y, int sideLength){
    x -= pistolColour[0].length()/2 * sideLength; //centers the pistol
    y -= pistolColour.length/2 * sideLength; 
    
    float newX = x;
      
    noStroke();
    for (int i = 0; i < pistolColour.length; i++) {
      
      for (int j = 0; j < pistolColour[0].length(); j++) {
        char c = pistolColour[i].charAt(j);
        
        if (c == '0') {
          //space; skip the iteration
        }
        else {
          if (c == '1') {fill(#000000);} //black
          else if (c == '2') {fill(#342FF5);} //blue
          rect(newX,y, sideLength,sideLength);
        }
        newX += sideLength;
      }
      newX = x; //resets newX
      y += sideLength;
    }
  }
  
  void drawShotgun(float x, float y, int sideLength){
    x -= shotgunColour[0].length()/2 * sideLength; //centers the shotgun
    y -= shotgunColour.length/2 * sideLength; 
    
    float newX = x;
      
    noStroke();
    for (int i = 0; i < shotgunColour.length; i++) {
      
      for (int j = 0; j < shotgunColour[0].length(); j++) {
        char c = shotgunColour[i].charAt(j);
        
        if (c == '0') {
          //space; skip the iteration
        }
        else {
          if (c == '1') {fill(#000000);} //black
          else if (c == '2') {fill(#FF0F17);} //red
          rect(newX,y, sideLength,sideLength);
        }
        newX += sideLength;
      }
      newX = x; //resets newX
      y += sideLength;
    }
  }
  
  // will draw the weapon on the player
  public void draw() {
    
  }
}
