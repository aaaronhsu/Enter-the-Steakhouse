public class BossRoom extends Room {
  
  BossRoom(Room previousRoom, int direction, int x, int y, int chanceToGenerateRoom) {
    super(previousRoom, direction, "boss", x, y, chanceToGenerateRoom);
    
    addBossToRoom();
  }
  
  private void addBossToRoom() {
    // will add boss to the list 'enemyList' in super
  }
}
