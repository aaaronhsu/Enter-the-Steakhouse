//GLOBAL VARIABLES
public final int NORTH = 0;
public final int SOUTH = 1;
public final int EAST = 2;
public final int WEST = 3;

//INSTANCE VARIABLES
public Player p;
public Floor map;

public MenuPages menu;

public MeatCleaver m1; //DELETE
public Gardener g1;
public Stove s1;
public SaltPepperTwins sp1;

public void setup() {
  fullScreen();
  menu = new MenuPages(0);
  

  map = new Floor(10, 15); // should not be in setup, will be called by separate function when game starts
  p = new Player(map.roomList.get(0), 10); 
  
  m1 = new MeatCleaver(400,400, 10, 1); //Testing enemies; delete after
  g1 = new Gardener(400,400,10,1);
  s1 = new Stove(400,400,10,1);
  sp1 = new SaltPepperTwins(400,400,10,1);

}

public void draw() {
  background(255, 255, 255);
  menu.draw();
  
  // all of these draw statements will be factored out later
  
  p.currentRoom.draw();
  
  p.move();
  p.draw();
  

  if (p.currentRoom.enemyList.isEmpty()) map.draw();

  //m1.draw(); //testing; delete after
  //g1.draw();
  //s1.draw();
  //sp1.draw();

}

public void keyPressed() {
  if (keyCode == 87 || keyCode == 82 || keyCode == 83 || keyCode == 65) {
    p.changeDirection(true);
  }
}

public void keyReleased() {
  if (keyCode == 87 || keyCode == 82 || keyCode == 83 || keyCode == 65) {
    p.changeDirection(false);
  }
}

public void mousePressed() {
  // map = new Floor(10, 15);
  // p = new Player(map.roomList.get(0), 10);

  if (mouseButton == LEFT) p.isShooting = true;
}
