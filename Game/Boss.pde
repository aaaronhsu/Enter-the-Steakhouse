public class Boss extends Enemy{
  int projectileDamage = 1;
  float projectileSpeed = 5;
  int cooldown = 30; //does not change
  int c = cooldown;
  int maxHealth;
  
  String[] monster = loadStrings("thoushaltnotpass.txt"); //visual display
  //for hit box of monster
  int monWidth = monster[0].length()*4 + 100; 
  int monHeight = monster.length*4 + 100;
  
  Boss(float x, float y, int health, int contactDamage) {
    super(x, y, health, contactDamage, BOSS);
    this.maxHealth = health;
  }
  
  void loadBoss(float x, float y, int sideLength){
    x -= monster[0].length()/2 * sideLength; //centers the boss
    y -= monster.length/2 * sideLength; 
    
    float newX = x;
      
    noStroke();
    for (int i = 0; i < monster.length; i++) {
      
      for (int j = 0; j < monster[0].length(); j++) {
        char colour = monster[i].charAt(j);
        
        if (colour == 'a') {
          //space; skip the iteration
        }
        else {
          if (colour == 'b') {fill(#FFFFFF);} //white
          else if (colour == 'c') {fill(#FEFF46);} //bright yellow
          else if (colour == 'd') {fill(#FCE06B);} //dark yellow
          else if (colour == 'e') {fill(#E89C2A);} //dark orange
          else if (colour == 'f') {fill(#676B81);} //dark gray (outlines)
          else if (colour == 'g') {fill(#777FAD);} //blueish gray
          else if (colour == 'h') {fill(#A6AEDE);} 
          else if (colour == 'i') {fill(#D4DAF7);} //lightest gray
          else if (colour == 'j') {fill(#F72A2A);} //bright red
          else if (colour == 'k') {fill(#B41414);} //dark red
          else if (colour == 'l') {fill(#000000);} //black
          rect(newX,y, sideLength,sideLength);
        }
        newX += sideLength;
      }
      newX = x; //resets newX
      y += sideLength;
    }
  }
  
  public void shootProjectile(int mode) {
    if (mode == 1) { //swirl pattern; incomplete
      // creates 6 projectiles 60 degrees apart
      for (int i = 0; i <= radians(300); i+= radians(60)) {
        float dx = projectileSpeed * cos(90);
        float dy = projectileSpeed * sin(90);
        //float tanV = tangentialVel();
        Projectile p1 = new Projectile(x, y, dx, dy, 25, #6D60E8, projectileDamage, -1, 1, false);
        p.currentRoom.projectileList.add(p1);
      }
    }

    else if (mode == 2) { //fast chase + fast 2-projectile shooting; fast-chase incomplete
      // calculates direction of the projectile
      float xDist = p.x - x;
      float yDist = p.y - y;
      
      float angle = atan2(yDist, xDist);
      
      for (float i = radians(20); i >= -radians(20); i -= radians(40)) {
        float dx = projectileSpeed * cos(angle+i);
        float dy = projectileSpeed * sin(angle+i);
        Projectile p1 = new Projectile(x, y, 1.5*dx, 1.5*dy, 25, #FAFF03, projectileDamage, 200, 3, false);
        p.currentRoom.projectileList.add(p1);
      }
    }

    else if (mode == 3) { //randomly shoots + flower bombs at center of room
      for (int i = 0; i < 10; i++){
        float angle = radians(random(360));
        float dx = projectileSpeed * cos(angle);
        float dy = projectileSpeed * sin(angle);
        
        Projectile p1 = new Projectile(x, y, dx, dy, 10, #EEFF0F, projectileDamage, -1, 1, false);
        p.currentRoom.projectileList.add(p1);
      }

      //once in a while, spawn flower projectiles
      if (Math.random() > 0.7) {
        int radius = 200; //distance of group of projectiles from boss
        int radiusEachOther = 10; //distance from proj to proj
        
        for (int i = 0; i < 360; i += 60){
          for (int j = 0; j < 360; j += 60){
            float newX = x + radius * cos(radians(i)) + radiusEachOther * cos(radians(j));
            float newY = y + radius * sin(radians(i)) + radiusEachOther * sin(radians(j));
            
            float dx = projectileSpeed * cos(radians(j));
            float dy = projectileSpeed * sin(radians(j));
            
            Projectile p1 = new Projectile(newX, newY, dx/2, dy/2, 10, #FF0F0F, projectileDamage, -1, 1, false);
            p.currentRoom.projectileList.add(p1);
          }
        }
      }
    }
      
      //if (this.x != width/2 && this.y != height/2) { //centers boss if not centered
      //    float xDist = width/2 - this.x; //x-dist btwn center of room and boss's x-cord
      //    float yDist = height/2 - this.y;
      //    float angle = atan2(yDist, xDist);
          
      //    float dx = 50 * cos(angle); //temporary speed of boss
      //    float dy = 50 * sin(angle);
          
      //    x += dx;
      //    y += dy;
      //  }
      //  else {
  }
  
  void teleportDisplay(){
    this.x = width/2;
    this.y = height/2;
  }
  
  public void draw(){
    loadBoss(x,y,5);
    
    //periodically shoots projectile 
    if (c == 0) {
      if (this.health >= 0.75 * maxHealth){
        teleportDisplay();
        shootProjectile(3);
      }
      else if (this.health >= 0.5 * maxHealth){
        shootProjectile(2);
      }
      else {
        shootProjectile(1);
      }
      
      this.c = this.cooldown;
    }
    else {
      c--;
    }
  }
  
}
