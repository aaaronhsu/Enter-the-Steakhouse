public final int MEATCLEAVER = 0;
public final int STOVE = 1;
public final int GARDENER = 2;
public final int MILKSHAKE = 3;

public final int BOSS = 10;

public class Enemy {
  float x, y;
  int health, contactDamage;
  //for monster's hit box
  int monWidth;
  int monHeight;

  ArrayDeque<Tile> pathToPlayer = new ArrayDeque();
  int timeUntilRecalculate = 20;

  int enemyType;
  
  Enemy(float x, float y, int health, int contactDamage, int type) {
    this.x = x;
    this.y = y;
    this.health = health;
    this.contactDamage = contactDamage;
    this.enemyType = type;
  }
  
  public void draw() {
    this.draw();
  }
  
  void loseHP(float lost){
    this.health--;
  }
  
  void despawn() { //called in Room
    p.currentRoom.enemyList.remove(this);
  }

  public void moveTowardsPlayer() {

    if (timeUntilRecalculate <= 0 || pathToPlayer.isEmpty()) {
      aStar();
      timeUntilRecalculate = 20;
    }

    if (timeUntilRecalculate > 0 && pathToPlayer.size() > 0) {
      Tile nextMove = pathToPlayer.pollLast();

      this.x = nextMove.x;
      this.y = nextMove.y;
      timeUntilRecalculate -= (int)random(3);
    }
  }

  private void aStar() {
    if (p.x < 10 || p.y < 10 || p.x > width - 10 || p.y > height - 10) return;

    int movementSpeed = 1;
    Queue<Tile> pq = new PriorityQueue();

    // boolean[][] visited = new boolean[1080][1920];

    HashSet<Tile> visited = new HashSet();

    Tile start = new Tile(this.x, this.y);
    pq.add(start);
    
    // visited[(int)y][(int)x] = true;
    visited.add(start);

    Tile path = null;

    // println("ITER");

    while (!pq.isEmpty()) {
      Tile currentTile = pq.poll();
      if (visited.size() > 5000) break;


      // path has been found
      if (currentTile.heuristic() - currentTile.stepsFromStart < 200) {
        path = currentTile;
        break;
      }

      if (canMoveNorth(currentTile.x, currentTile.y) && canMoveEast(currentTile.x, currentTile.y)) {
        Tile neTile = new Tile(currentTile.x + movementSpeed, currentTile.y - movementSpeed, start.stepsFromStart + 1, currentTile);

        if (!visited.contains(neTile)) {
          pq.add(neTile);
          visited.add(neTile);
        }
      }

      if (canMoveSouth(currentTile.x, currentTile.y) && canMoveEast(currentTile.x, currentTile.y)) {
        Tile seTile = new Tile(currentTile.x + movementSpeed, currentTile.y + movementSpeed, start.stepsFromStart + 1, currentTile);

        if (!visited.contains(seTile)) {
          pq.add(seTile);
          visited.add(seTile);
        }
      }

      if (canMoveNorth(currentTile.x, currentTile.y) && canMoveWest(currentTile.x, currentTile.y)) {
        Tile nwTile = new Tile(currentTile.x - movementSpeed, currentTile.y - movementSpeed, start.stepsFromStart + 1, currentTile);

        if (!visited.contains(nwTile)) {
          pq.add(nwTile);
          visited.add(nwTile);
        }
      }

      if (canMoveSouth(currentTile.x, currentTile.y) && canMoveWest(currentTile.x, currentTile.y)) {
        Tile swTile = new Tile(currentTile.x - movementSpeed, currentTile.y + movementSpeed, start.stepsFromStart + 1, currentTile);

        if (!visited.contains(swTile)) {
          pq.add(swTile);
          visited.add(swTile);
        }
      }

      if (canMoveNorth(currentTile.x, currentTile.y)) {
        Tile nTile = new Tile(currentTile.x, currentTile.y - movementSpeed, start.stepsFromStart + 1, currentTile);

        if (!visited.contains(nTile)) {
          pq.add(nTile);
          visited.add(nTile);
        }
      }
      if (canMoveSouth(currentTile.x, currentTile.y)) {
        Tile sTile = new Tile(currentTile.x, currentTile.y + movementSpeed, start.stepsFromStart + 1, currentTile);

        if (!visited.contains(sTile)) {
          pq.add(sTile);
          visited.add(sTile);
        }
      }
      if (canMoveEast(currentTile.x, currentTile.y)) {
        Tile eTile = new Tile(currentTile.x + movementSpeed, currentTile.y, start.stepsFromStart + 1, currentTile);

        if (!visited.contains(eTile)) {
          pq.add(eTile);
          visited.add(eTile);
        }
      }
      if (canMoveWest(currentTile.x, currentTile.y)) {
        Tile wTile = new Tile(currentTile.x - movementSpeed, currentTile.y, start.stepsFromStart + 1, currentTile);

        if (!visited.contains(wTile)) {
          pq.add(wTile);
          visited.add(wTile);
        }
      }
    }

    if (path != null && path.previousTile != null) {
      pathToPlayer = new ArrayDeque();
      while (path.previousTile != null) {
        pathToPlayer.add(path);
        path = path.previousTile;
      }
    }
  }

  private boolean canMoveNorth(int x, int y) {
    // for (Enemy e : p.currentRoom.enemyList) {
    //   if (e == this) continue;
    //   if (abs(e.x - x) < 15 && abs(e.y - (y - 40)) < 15) return false;
    // }
    // return true;
    return fetchTile(x, y - 30) == GROUND || fetchTile(x, y - 30) == TELEPORTER;
  }
  private boolean canMoveSouth(int x, int y) {
    // for (Enemy e : p.currentRoom.enemyList) {
    //   if (e == this) continue;
    //   if (abs(e.x - x) < 15 && abs(e.y - (y + 40)) < 15) return false;
    // }
    // return true;
    return fetchTile(x, y + 30) == GROUND || fetchTile(x, y - 30) == TELEPORTER;
  }
  private boolean canMoveEast(int x, int y) {
    // for (Enemy e : p.currentRoom.enemyList) {
    //   if (e == this) continue;
    //   if (abs(e.x - (x + 40)) < 15 && abs(e.y - y) < 15) return false;
    // }
    // return true;
    return fetchTile(x + 30, y) == GROUND || fetchTile(x, y - 30) == TELEPORTER;
  }
  private boolean canMoveWest(int x, int y) {
    // for (Enemy e : p.currentRoom.enemyList) {
    //   if (e == this) continue;
    //   if (abs(e.x - (x - 40)) < 15 && abs(e.y - y) < 15) return false;
    // }
    // return true;
    return fetchTile(x - 30, y) == GROUND || fetchTile(x, y - 30) == TELEPORTER;
  }
}
