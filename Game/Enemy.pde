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
    aStar();
  }

  private void aStar() {
    Queue<Tile> pq = new PriorityQueue();
    HashSet<Tile> visited = new HashSet();

    Tile start = new Tile(this.x, this.y);
    pq.add(start);
    visited.add(start);

    Tile path = null;

    println("ITER");

    while (!pq.isEmpty()) {
      Tile currentTile = pq.poll();

      println(currentTile.heuristic() + ": " + currentTile.x + ", " + currentTile.y);

      // path has been found
      if (currentTile.heuristic() - currentTile.stepsFromStart < 100) {
        path = currentTile;
        println("SOMETHING GOOD HAPPENEND");
        break;
      }

      if (canMoveNorth()) {
        Tile nTile = new Tile(currentTile.x, currentTile.y - 5, start.stepsFromStart + 5, currentTile);

        boolean shouldBeAdded = true;
        for (Tile t : visited) {
          if (t.x == nTile.x && t.y == nTile.y) {
            println("NORTH CANT BE ADDED");
            shouldBeAdded = false;
            break;
          }
        }

        if (shouldBeAdded) {
          pq.add(nTile);
          visited.add(nTile);
        }
      }
      if (canMoveSouth()) {
        Tile sTile = new Tile(currentTile.x, currentTile.y + 5, start.stepsFromStart + 5, currentTile);

        boolean shouldBeAdded = true;
        for (Tile t : visited) {
          if (t.x == sTile.x && t.y == sTile.y) {
            shouldBeAdded = false;
            break;
          }
        }

        if (shouldBeAdded) {
          pq.add(sTile);
          visited.add(sTile);
        }
      }
      if (canMoveEast()) {
        Tile eTile = new Tile(currentTile.x + 5, currentTile.y, start.stepsFromStart + 5, currentTile);

        boolean shouldBeAdded = true;
        for (Tile t : visited) {
          if (t.x == eTile.x && t.y == eTile.y) {
            shouldBeAdded = false;
            break;
          }
        }

        if (shouldBeAdded) {
          pq.add(eTile);
          visited.add(eTile);
        }
      }
      if (canMoveWest()) {
        Tile wTile = new Tile(currentTile.x - 5, currentTile.y, start.stepsFromStart + 5, currentTile);

        boolean shouldBeAdded = true;
        for (Tile t : visited) {
          if (t.x == wTile.x && t.y == wTile.y) {
            shouldBeAdded = false;
            break;
          }
        }

        if (shouldBeAdded) {
          pq.add(wTile);
          visited.add(wTile);
        }
      }
    }

    if (path != null && path.previousTile != null) {
      while (path.previousTile.previousTile != null) {
        path = path.previousTile;
      }
      println("SOMETHING FOUND");
      this.x = path.x;
      this.y = path.y;
    }
  }

  private boolean canMoveNorth() {
    return true;
    // return fetchTile(this.x, this.y - 60) == GROUND;
  }
  private boolean canMoveSouth() {
    return true;
    // return fetchTile(this.x, this.y + 60) == GROUND;
  }
  private boolean canMoveEast() {
    return true;
    // return fetchTile(this.x + 60, this.y) == GROUND;
  }
  private boolean canMoveWest() {
    return true;
    // return fetchTile(this.x - 60, this.y) == GROUND;
  }
}
