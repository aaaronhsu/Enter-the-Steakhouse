public class Weapon extends Item {
  float fireRate, projectileSize, damage;
  int type;
  
  Weapon(float fireRate, float projectileSize, float damage, int type) {
    this.fireRate = fireRate;
    this.projectileSize = projectileSize;
    this.damage = damage;
    this.type = type;
  }
}
