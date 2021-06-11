public class Milkshake extends Enemy{
  int projectileDamage = 1;
  float projectileSpeed = 3.5;
  int cooldown = 120; //does not change
  int c = cooldown;
  
  String[] monster = loadStrings("milkshake.txt"); //visual display
  //String[] damagedMonster = loadStrings("milkshakeDamaged.txt"); //visual display
  
  //for hit box of monster
  int monWidth = monster[0].length()*4 + 100; 
  int monHeight = monster.length*4 + 100;
  
  Milkshake(float x, float y, int health, int contactDamage) {
    super(x, y, health, contactDamage, GARDENER);  
  }
  
  public void shootProjectile() {
    // calculates direction of the projectile
    float xDist = p.x - x;
    float yDist = p.y - y;
    
    float angle = atan2(yDist, xDist);
    
    for (int i = 0; i <= radians(240); i+= radians(120)) {
      for (float j = radians(20); j >= -radians(20); j -= radians(20)) {
        color c = colorPicker();
        
        float dx = projectileSpeed * cos(angle+i+j);
        float dy = projectileSpeed * sin(angle+i+j);
        Projectile p1 = new Projectile(x, y, dx, dy, 12, c, projectileDamage, 200, 3, false);
        p.currentRoom.projectileList.add(p1);
      }
    }
  }
  
  color colorPicker(){
    double num = Math.random();
    if (num < 0.25) return color(#AAE5FF);
    else if (num < 0.5) return color(#DE146C);
    else if (num < 0.75) return color(#9DD6F0);
    else {return color(#DE146C);}
  }
  
  void loadMon(float x, float y, int sideLength){
    x -= monster[0].length()/2 * sideLength; //centers the monster
    y -= monster.length/2 * sideLength; 
    
    float newX = x;
      
    noStroke();

    if (this.health == 1) {

      if (p.x > this.x) {
        for (int i = 0; i < monster.length; i++) {
        
          for (int j = 0; j < monster[0].length(); j++) {
            char colour = monster[i].charAt(j);
            
            if (colour == '0') { //darker versions
              //space; skip the iteration
            }
            else {
              if (colour == '1') {fill(0);} //black
              else if (colour == '2') {fill(#1CACE8);} //light blue
              else if (colour == '3') {fill(#178BBF);} //darkish blue
              else if (colour == '4') {fill(#95121B);} //red
              else if (colour == '5') {fill(#76640E);} //blond
              else if (colour == '6') {fill(#385A0B);} //green
              else if (colour == '7') {fill(#B91660);} //dark pink
              else if (colour == '8') {fill(#C1B617);} //skin
              else if (colour == '9') {fill(#DB1860);} //hot pink
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
            
            if (colour == '0') { //darker versions
              //space; skip the iteration
            }
            else {
              if (colour == '1') {fill(0);} //black
              else if (colour == '2') {fill(#1CACE8);} //light blue
              else if (colour == '3') {fill(#178BBF);} //darkish blue
              else if (colour == '4') {fill(#95121B);} //red
              else if (colour == '5') {fill(#76640E);} //blond
              else if (colour == '6') {fill(#385A0B);} //green
              else if (colour == '7') {fill(#B91660);} //dark pink
              else if (colour == '8') {fill(#C1B617);} //skin
              else if (colour == '9') {fill(#DB1860);} //hot pink
              rect(newX,y, sideLength,sideLength);
            }
            newX += sideLength;
          }
          newX = x; //resets newX
          y += sideLength;
        }
      }
    }
    else {
      if (p.x > this.x ) {
        for (int i = 0; i < monster.length; i++) {
          
          for (int j = 0; j < monster[0].length(); j++) {
            char colour = monster[i].charAt(j);
            
            if (colour == '0') {
              //space; skip the iteration
            }
            else {
              if (colour == '1') {fill(0);} //black
              else if (colour == '2') {fill(#AAE5FF);} //light blue
              else if (colour == '3') {fill(#9DD6F0);} //darkish blue
              else if (colour == '4') {fill(#E5101E);} //red
              else if (colour == '5') {fill(#E3C635);} //blond
              else if (colour == '6') {fill(#A9DE65);} //green
              else if (colour == '7') {fill(#DE146C);} //dark pink
              else if (colour == '8') {fill(#F5EE6F);} //skin
              else if (colour == '9') {fill(#FF3B83);} //hot pink
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
            
            if (colour == '0') {
              //space; skip the iteration
            }
            else {
              if (colour == '1') {fill(0);} //black
              else if (colour == '2') {fill(#AAE5FF);} //light blue
              else if (colour == '3') {fill(#9DD6F0);} //darkish blue
              else if (colour == '4') {fill(#E5101E);} //red
              else if (colour == '5') {fill(#E3C635);} //blond
              else if (colour == '6') {fill(#A9DE65);} //green
              else if (colour == '7') {fill(#DE146C);} //dark pink
              else if (colour == '8') {fill(#F5EE6F);} //skin
              else if (colour == '9') {fill(#FF3B83);} //hot pink
              rect(newX,y, sideLength,sideLength);
            }
            newX += sideLength;
          }
          newX = x; //resets newX
          y += sideLength;
        }
      }
    }
  }
  
  public void draw() {
    loadMon(x,y, 3);
    
    moveTowardsPlayer();
    
    //periodically shoots projectile 
    if (c <= 0) {
      shootProjectile();
      this.c = this.cooldown;
    }
    else {
      c -= (int)random(3);
    }
  }

}
