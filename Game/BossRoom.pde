public class BossRoom extends Room {

  boolean bossSpawned = false;
  
  BossRoom(Room previousRoom, int direction, int x, int y, int chanceToGenerateRoom) {
    super(previousRoom, direction, "boss", x, y, chanceToGenerateRoom);
  }
  
<<<<<<< HEAD
  private void addBossToRoom() {
    int randomGenType = (int) random(2);

    switch (randomGenType) {
      case 0:
        for (int i = 0; i < 5; i++) {
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
=======
  public void addBossToRoom() {
    // will add boss to the list 'enemyList' in super

    int randomGenType = (int) random(1);

    switch (randomGenType) {
      case 0:
        for (int i = 0; i < 1; i++) {
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

          Boss m = new Boss(x, y, 5, 1);

          this.enemyList.add(m);
        }
        break;
    }


  }

  public void draw() {
    super.draw();

    if (bossSpawned == true) {
      if (!enemyList.isEmpty()) {
        fill(255, 0, 0);
        text("HEALTH: " + enemyList.get(0).health, width / 2 - 100, 100);
      }
>>>>>>> 7e6fc49f7579281fbe2a4b64c2ca10ce1d540e3b
    }
  }
}
