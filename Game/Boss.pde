public class Boss extends Enemy{
  int projectileDamage = 2;
  float projectileSpeed = 5;
  int cooldown = 30; //does not change
  int c = cooldown;
  float time = 1; //????
  
  String[] monster = loadStrings("thoushaltnotpass.txt"); //visual display
  //for hit box of monster
  int monWidth = monster[0].length()*4 + 100; 
  int monHeight = monster.length*4 + 100;
  
  Boss(float x, float y, int health, int contactDamage) {
    super(x, y, health, contactDamage, BOSS);  
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
  
  float tangentialVel(){
    return 2 * PI * (monWidth/2) / time;
  }

  public void shootProjectile(int mode) {

    if (mode == 1) { //swirl pattern; incomplete
      // creates 6 projectiles 60 degrees apart
      for (int i = 0; i <= radians(300); i+= radians(60)) {
        float dx = projectileSpeed * cos(90);
        float dy = projectileSpeed * sin(90);
        //float tanV = tangentialVel();
        Projectile p1 = new BossProjectile(x, y, dx, dy, 25, #6D60E8, projectileDamage, -1, 1, false);

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

    else if (mode == 3) { //goes to center of room; randomly shoots; incomplete
      float distance = dist(this.x, this.y, width/2, height/2);

      float xDist = width/2 - this.x; //x-dist btwn center of room and boss's x-cord
      float yDist = height/2 - this.y;
      float angle = atan2(yDist, xDist);

      float dx = distance/5 * cos(angle); //temporary speed of boss
      float dy = distance/5 * sin(angle);

      for (int i = 0; i < 5; i++) {
        x += dx;
        y += dy;
      }

      //~~~~~~~~~ //spawning projectiles that go out and back in
      for (int i = 0; i < 360; i += 60){
        int radius = 100;

        float newX = radius * cos(radians(i));
        float newY = radius * sin(radians(i));

        Projectile p1 = new Projectile(newX, newY, dx, dy, 25, #6D60E8, projectileDamage, -1, 1, false);
        p.currentRoom.projectileList.add(p1);

      }

    //  for (int i = 0; i <= radians(300); i+= radians(60)) {
    //    dx = projectileSpeed * cos(angle+i);
    //    dy = projectileSpeed * sin(angle+i);
    //    Projectile p1 = new Projectile(x, y, dx, dy, 25, #6D60E8, projectileDamage, -1, 1, false);

    //  // adds projectile to the projectile list of the room that the player is in
    //  p.currentRoom.projectileList.add(p1);
    //}

    }

    else if (mode == 4) {

    }
  }
  
  public void draw(){
    loadBoss(x,y,5);

    //periodically shoots projectile 
    if (c == 0) {
      shootProjectile(3);
      this.c = this.cooldown;
    }
    else {
      c--;
    }
  }
  
}
