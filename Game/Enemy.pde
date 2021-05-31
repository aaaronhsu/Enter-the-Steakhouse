public abstract class Enemy {
  float x, y;
  int health, contactDamage;
  
  Enemy(float x, float y, int health, int contactDamage) {
    this.x = x;
    this.y = y;
    this.health = health;
    this.contactDamage = contactDamage;
  }
  
  public void draw() {
    this.draw();
  }
  
  void loseHP(int lost){
    this.health--;
  }
}
