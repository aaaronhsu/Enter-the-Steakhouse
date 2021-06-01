public class BossRoom extends Room {
  
  BossRoom(Room previousRoom, int direction, int x, int y, int chanceToGenerateRoom) {
    super(previousRoom, direction, "boss", x, y, chanceToGenerateRoom);
    
    addBossToRoom();
  }
  
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
    }
  }
}
