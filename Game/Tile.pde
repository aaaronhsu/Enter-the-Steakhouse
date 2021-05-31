public class Tile implements Comparable<Tile> {
  int x, y, stepsFromStart;
  Tile previousTile;

  Tile(int x, int y, int stepsFromStart, Tile previousTile) {
    this.x = x;
    this.y = y;
    this.stepsFromStart = stepsFromStart;
    this.previousTile = previousTile;
  }

  public int compareTo(Tile other) {
    return this.heuristic - other.heuristic;
  }

  private int heuristic() {
    return abs(this.x - p.x) + abs(this.y - p.y) + stepsFromStart;
  }
}