public class Boss extends Enemy{
  int projectileDamage = 1;
  float projectileSpeed = 5;
  int cooldown = 30; //does not change
  int c = cooldown;
  int maxHealth;
  
  float offset = 0;
  
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

    if (this.x > p.x) {
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
    else {
      for (int i = 0; i < monster.length; i++) {
        for (int j = monster[0].length() - 1; j >= 0; j--) {
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
  }
  
  public void shootProjectile() {

    int mode = (int) random(3) + 1;

    if (this.health > 20 && mode == 3) mode = 1;
    

    if (mode == 1) { //swirl pattern
     
     for (float i = 0; i <= radians(325); i += radians(36)) {
       float dx = projectileSpeed * cos(i-offset);
       float dy = projectileSpeed * sin(i-offset);
        
       Projectile p1 = new Projectile(x, y, dx*1.2/2, dy*1.2/2, 20, #6D60E8, projectileDamage, -1, 1, false);
       p.currentRoom.projectileList.add(p1);
     }
    
     offset += radians(50);
   }

    else if (mode == 2) { //fast chase + fast 2-projectile shooting; fast-chase incomplete
      // calculates direction of the projectile
      float xDist = p.x - x;
      float yDist = p.y - y;
      
      float angle = atan2(yDist, xDist);
      
      for (float i = radians(20); i >= -radians(20); i -= radians(20)) {
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
  }
  
  void teleportDisplay(){ //some animation of teleporting?
    this.x = width/2;
    this.y = height/2;
  }
  
  public void draw(){
    loadBoss(x,y,5);
    loadHP(this.x-monWidth/2, this.y-100);

    if (random(100) < 1.5) shootProjectile();
    
    //periodically shoots projectile 
    if (c == 0) {
      if (this.health >= 0.75 * maxHealth){
        teleportDisplay();
      }
      
      this.c = this.cooldown;
    }
    else {
      c--;
    }
  }
  
  void loadHP(float x, float y) {
    fill(0);
    rect(x + 40,y, 100,25);
    float percent = (float)health/maxHealth;
    //println(health + " " + maxHealth);
    //println(percent);
    fill(#FC191D);
    rect(x + 40,y, 100*percent, 25);
  }
  
  
  
}
