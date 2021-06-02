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

  public void purchase() {
    if (p.money >= cost) {
      p.money -= cost;
    }

    if (this.isConsumable) {
      switch (this.type) {
        case HEALTH:
          p.health++;
          break;
        case BLANK:
          p.blanks++;
          break;
        case KEY:
          p.keys++;
          break;
      }
    }
    else equipWeapon();

  }

  public void equipWeapon() {
    p.weaponList.add((Weapon) this);
  }

  public String toString() {
    switch (this.type) {
      case HEALTH:
        return "HEALTH FOR " + this.cost + " MOONIES";
      case BLANK:
        return "BLANK FOR " + this.cost + " MOONIES";
      case KEY:
        return "KEY FOR " + this.cost + " MOONIES";
      case WEAPON:
        return "WEAPON FOR " + this.cost + " MOONIES";
    }

    return "IDK WHAT ITEM THIS IS";
  }
}
