public class CombatRoom extends Room {
  
  CombatRoom(Room previousRoom, int direction, int x, int y, int chanceToGenerateRoom) {
    super(previousRoom, direction, "combat", x, y, chanceToGenerateRoom);
    
    generateEnemies();
  }
  

  public void addEnemiesToRoom() {
    int randomGenType = (int) random(3);

  public void generateEnemies() {
    int randomGenType = (int) random(2);

    switch (randomGenType) {
      case 0:
        for (int i = 0; i < 5; i++) {
          int x = (int) random(780) + 90;
          int y = (int) random(360) + 90;

          while (this.roomBlueprint[(int)(y / 30)].charAt((int)(x / 30)) != GROUND ||
                 this.roomBlueprint[(int)(y / 30) - 1].charAt((int)(x / 30)) != GROUND ||
                 this.roomBlueprint[(int)(y / 30) + 1].charAt((int)(x / 30)) != GROUND ||
                 this.roomBlueprint[(int)(y / 30)].charAt((int)(x / 30) - 1) != GROUND ||
                 this.roomBlueprint[(int)(y / 30)].charAt((int)(x / 30) + 1) != GROUND) {
            x = (int) random(960);
            y = (int) random(540);
          int x = (int) random(1560) + 180;
          int y = (int) random(720) + 180;

          while (this.roomBlueprint[(int)(y / 60)].charAt((int)(x / 60)) != GROUND ||
                 this.roomBlueprint[(int)(y / 60) - 1].charAt((int)(x / 60)) != GROUND ||
                 this.roomBlueprint[(int)(y / 60) + 1].charAt((int)(x / 60)) != GROUND ||
                 this.roomBlueprint[(int)(y / 60)].charAt((int)(x / 60) - 1) != GROUND ||
                 this.roomBlueprint[(int)(y / 60)].charAt((int)(x / 60) + 1) != GROUND) {
            x = (int) random(1920);
            y = (int) random(1080);
          }

          MeatCleaver m = new MeatCleaver(x, y, 1, 1);

          this.enemyList.add(m);
        }

        for (int i = 0; i < 3; i++) {
          int x = (int) random(780) + 90;
          int y = (int) random(360) + 90;

          while (this.roomBlueprint[(int)(y / 30)].charAt((int)(x / 30)) != GROUND ||
                 this.roomBlueprint[(int)(y / 30) - 1].charAt((int)(x / 30)) != GROUND ||
                 this.roomBlueprint[(int)(y / 30) + 1].charAt((int)(x / 30)) != GROUND ||
                 this.roomBlueprint[(int)(y / 30)].charAt((int)(x / 30) - 1) != GROUND ||
                 this.roomBlueprint[(int)(y / 30)].charAt((int)(x / 30) + 1) != GROUND) {
            x = (int) random(960);
            y = (int) random(540);
          }

          Stove m = new Stove(x, y, 1, 1);

          this.enemyList.add(m);
        }
        break;
      case 1:
        for (int i = 0; i < 8; i++) {
          int x = (int) random(780) + 90;
          int y = (int) random(360) + 90;

          while (this.roomBlueprint[(int)(y / 30)].charAt((int)(x / 30)) != GROUND ||
                 this.roomBlueprint[(int)(y / 30) - 1].charAt((int)(x / 30)) != GROUND ||
                 this.roomBlueprint[(int)(y / 30) + 1].charAt((int)(x / 30)) != GROUND ||
                 this.roomBlueprint[(int)(y / 30)].charAt((int)(x / 30) - 1) != GROUND ||
                 this.roomBlueprint[(int)(y / 30)].charAt((int)(x / 30) + 1) != GROUND) {
            x = (int) random(960);
            y = (int) random(540);
          println("enemyGenerated");
        }
        break;
      case 1:
        for (int i = 0; i < 10; i++) {
          int x = (int) random(1560) + 180;
          int y = (int) random(720) + 180;

          while (this.roomBlueprint[(int)(y / 60)].charAt((int)(x / 60)) != GROUND ||
                 this.roomBlueprint[(int)(y / 60) - 1].charAt((int)(x / 60)) != GROUND ||
                 this.roomBlueprint[(int)(y / 60) + 1].charAt((int)(x / 60)) != GROUND ||
                 this.roomBlueprint[(int)(y / 60)].charAt((int)(x / 60) - 1) != GROUND ||
                 this.roomBlueprint[(int)(y / 60)].charAt((int)(x / 60) + 1) != GROUND) {
            x = (int) random(1920);
            y = (int) random(1080);
          }

          Stove m = new Stove(x, y, 1, 1);

          this.enemyList.add(m);
        }
        break;
      case 2:
        for (int i = 0; i < 4; i++) {
          int x = (int) random(780) + 90;
          int y = (int) random(360) + 90;

          while (this.roomBlueprint[(int)(y / 30)].charAt((int)(x / 30)) != GROUND ||
                 this.roomBlueprint[(int)(y / 30) - 1].charAt((int)(x / 30)) != GROUND ||
                 this.roomBlueprint[(int)(y / 30) + 1].charAt((int)(x / 30)) != GROUND ||
                 this.roomBlueprint[(int)(y / 30)].charAt((int)(x / 30) - 1) != GROUND ||
                 this.roomBlueprint[(int)(y / 30)].charAt((int)(x / 30) + 1) != GROUND) {
            x = (int) random(960);
            y = (int) random(540);
          }

          Gardener m = new Gardener(x, y, 1, 1);

          this.enemyList.add(m);
        }
        break;
    }
  }
}
