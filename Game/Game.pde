
//GLOBAL VARIABLES
public final int NORTH = 0;
public final int SOUTH = 1;
public final int EAST = 2;
public final int WEST = 3;

//INSTANCE VARIABLES
public Player p;
public Room currentRoom;
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

  p = new Player(map.roomList.get(0), 10);
  
  currentRoom = new Room(10);
}

public void draw() {
  background(255, 255, 255);
  menu.draw();
  
  // all of these draw statements will be factored out later
  map.draw();
  
  p.move();
  p.draw();
  

  m1.draw(); //testing; delete after
  //g1.draw();
  //s1.draw();
  //sp1.draw();
  for (int i =  p.currentRoom.projectileList.size()-1; i >= 0 ; i--) { //access every projectile in currentRoom
    // example of drawing stuff
    m1.draw();
    println(currentRoom);
    Projectile pro = p.currentRoom.projectileList.get(i);
    pro.draw();
    //check if enemy or player hp 0 here, I think
  }
  
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
  map = new Floor(10, 15);
  p = new Player(map.roomList.get(0), 10);
}
