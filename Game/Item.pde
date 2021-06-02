public final int HEALTH = 0;
public final int BLANK = 1;
public final int KEY = 2;
public final int WEAPON = 3;

public class Item {
  int cost;
  boolean isConsumable;
  int type;

  Item(int cost, boolean isConsumable, int type) {
    this.cost = cost;
    this.isConsumable = isConsumable;
    this.type = type;
  }

  
}
