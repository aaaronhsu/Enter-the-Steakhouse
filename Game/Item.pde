public class Item {
  int cost;
  boolean isConsumable;
  int type;

  Item(int cost, boolean isConsumable, int type) {
    this.cost = cost;
    this.isConsumable = isConsumable;

    this.type = type;
  }

  public void equip() {
    if (this.isConsumable) {
      switch (this.type) {
        case HEALTHITEM:
          p.health++;
          break;
        case BLANKITEM:
          p.blanks++;
          break;
      }
    }
    else {
      // is a weapon
    }
  }
}
