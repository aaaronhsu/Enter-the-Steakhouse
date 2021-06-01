public abstract class Enemy {
  float x, y;
  int health, contactDamage;
  //for monster's hit box
  int monWidth;
  int monHeight;
  
  Enemy(float x, float y, int health, int contactDamage) {
    this.x = x;
    this.y = y;
    this.health = health;
    this.contactDamage = contactDamage;
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
    if (p.x < 10 || p.y < 10 || p.x > width - 10 || p.y > height - 10) return; 
    aStar();
  }

  private void aStar() {
    int movementSpeed = 3;
    Queue<Tile> pq = new PriorityQueue();

    boolean[][] visited = new boolean[1080][1920];

    Tile start = new Tile(this.x, this.y);
    pq.add(start);
    
    visited[(int)y][(int)x] = true;

    Tile path = null;

    // println("ITER");

    while (!pq.isEmpty()) {
      Tile currentTile = pq.poll();
      // if (pq.size() > 500) break;

      // println(currentTile.heuristic() + ": " + currentTile.x + ", " + currentTile.y);

      // path has been found
      if (currentTile.heuristic() - currentTile.stepsFromStart < 100) {
        path = currentTile;
        // println("SOMETHING GOOD HAPPENEND");
        break;
      }

      if (canMoveNorth(currentTile.x, currentTile.y) && canMoveEast(currentTile.x, currentTile.y)) {
        Tile neTile = new Tile(currentTile.x + movementSpeed, currentTile.y - movementSpeed, start.stepsFromStart + 1, currentTile);

        if (!visited[currentTile.y - movementSpeed][currentTile.x + movementSpeed]) {
          pq.add(neTile);
          visited[currentTile.y - movementSpeed][currentTile.x + movementSpeed] = true;
        }
      }

      if (canMoveSouth(currentTile.x, currentTile.y) && canMoveEast(currentTile.x, currentTile.y)) {
        Tile seTile = new Tile(currentTile.x + movementSpeed, currentTile.y + movementSpeed, start.stepsFromStart + 1, currentTile);

        if (!visited[currentTile.y + movementSpeed][currentTile.x + movementSpeed]) {
          pq.add(seTile);
          visited[currentTile.y + movementSpeed][currentTile.x + movementSpeed] = true;
        }
      }

      if (canMoveNorth(currentTile.x, currentTile.y) && canMoveWest(currentTile.x, currentTile.y)) {
        Tile nwTile = new Tile(currentTile.x - movementSpeed, currentTile.y - movementSpeed, start.stepsFromStart + 1, currentTile);

        if (!visited[currentTile.y - movementSpeed][currentTile.x - movementSpeed]) {
          pq.add(nwTile);
          visited[currentTile.y - movementSpeed][currentTile.x - movementSpeed] = true;
        }
      }

      if (canMoveSouth(currentTile.x, currentTile.y) && canMoveWest(currentTile.x, currentTile.y)) {
        Tile swTile = new Tile(currentTile.x - movementSpeed, currentTile.y + movementSpeed, start.stepsFromStart + 1, currentTile);

        if (!visited[currentTile.y + movementSpeed][currentTile.x - movementSpeed]) {
          pq.add(swTile);
          visited[currentTile.y + movementSpeed][currentTile.x - movementSpeed] = true;
        }
      }

      if (canMoveNorth(currentTile.x, currentTile.y)) {
        Tile nTile = new Tile(currentTile.x, currentTile.y - movementSpeed, start.stepsFromStart + 1, currentTile);

        if (!visited[currentTile.y - movementSpeed][currentTile.x]) {
          pq.add(nTile);
          visited[currentTile.y - movementSpeed][currentTile.x] = true;
        }
      }
      if (canMoveSouth(currentTile.x, currentTile.y)) {
        Tile sTile = new Tile(currentTile.x, currentTile.y + movementSpeed, start.stepsFromStart + 1, currentTile);

        if (!visited[currentTile.y + movementSpeed][currentTile.x]) {
          pq.add(sTile);
          visited[currentTile.y + movementSpeed][currentTile.x] = true;
        }
      }
      if (canMoveEast(currentTile.x, currentTile.y)) {
        Tile eTile = new Tile(currentTile.x + movementSpeed, currentTile.y, start.stepsFromStart + 1, currentTile);

        if (!visited[currentTile.y][currentTile.x + movementSpeed]) {
          pq.add(eTile);
          visited[currentTile.y][currentTile.x + movementSpeed] = true;
        }
      }
      if (canMoveWest(currentTile.x, currentTile.y)) {
        Tile wTile = new Tile(currentTile.x - movementSpeed, currentTile.y, start.stepsFromStart + 1, currentTile);

        if (!visited[currentTile.y][currentTile.x - movementSpeed]) {
          pq.add(wTile);
          visited[currentTile.y][currentTile.x - movementSpeed] = true;
        }
      }
    }

    if (path != null && path.previousTile != null) {
      while (path.previousTile.previousTile != null) {
        path = path.previousTile;
      }
      // println("SOMETHING FOUND");
      this.x = path.x;
      this.y = path.y;
    }
  }

  private boolean canMoveNorth(int x, int y) {
    for (Enemy e : p.currentRoom.enemyList) {
      if (e == this) continue;
      if (abs(e.x - x) < 30 && abs(e.y - (y - 3)) < 30) return false;
    }
    // return true;
    return fetchTile(x, y - 60) == GROUND;
  }
  private boolean canMoveSouth(int x, int y) {
    for (Enemy e : p.currentRoom.enemyList) {
      if (e == this) continue;
      if (abs(e.x - x) < 30 && abs(e.y - (y + 3)) < 30) return false;
    }
    // return true;
    return fetchTile(x, y + 60) == GROUND;
  }
  private boolean canMoveEast(int x, int y) {
    for (Enemy e : p.currentRoom.enemyList) {
      if (e == this) continue;
      if (abs(e.x - (x + 3)) < 30 && abs(e.y - y) < 30) return false;
    }
    // return true;
    return fetchTile(x + 60, y) == GROUND;
  }
  private boolean canMoveWest(int x, int y) {
    for (Enemy e : p.currentRoom.enemyList) {
      if (e == this) continue;
      if (abs(e.x - (x - 3)) < 30 && abs(e.y - y) < 30) return false;
    }
    // return true;
    return fetchTile(x - 60, y) == GROUND;
  }
}
