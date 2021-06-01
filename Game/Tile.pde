public class Tile implements Comparable<Tile> {
  int x, y, stepsFromStart;
  Tile previousTile;

  Tile(float x, float y, int stepsFromStart, Tile previousTile) {
    this.x = (int)x;
    this.y = (int)y;
    this.stepsFromStart = stepsFromStart;
    this.previousTile = previousTile;
  }

  Tile(float x, float y) {
    this.x = (int)x;
    this.y = (int)y;
    this.stepsFromStart = 0;
  }

  public int compareTo(Tile other) {
    return Integer.compare(this.heuristic(), other.heuristic());
  }

  private int heuristic() {
    return (int)abs(this.x - p.x) + (int)abs(this.y - p.y) + stepsFromStart / 3;
  }
}