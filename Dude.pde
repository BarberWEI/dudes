public class dude {
  boolean scaredOfDudes;
  boolean attractedToDudes;
  float x, y;
  float xSpeed, ySpeed;
  float radius;
  
  public dude (float x, float y, float xSpeed, float ySpeed, float radius, boolean attractedToDudes, boolean scaredOfDudes) {
    this.x = x;
    this.y = y;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
    this.radius = radius;
    this.attractedToDudes = attractedToDudes;
    this.scaredOfDudes = scaredOfDudes;
  }
  
  public dude () {
    this.x = 350;
    this.y = 350;
    this.xSpeed = 10;
    this.ySpeed = -5;
    this.radius = 25;
    this.attractedToDudes = false;
    this.scaredOfDudes = false;
  }
  
  void update () {
    
    x += xSpeed;
    y += ySpeed;
    
    if (x > width - radius || x < radius ) {
      xSpeed = -xSpeed;
    }
    if (y > height - radius || y < radius ) {
      ySpeed = -ySpeed;
    }
  }
  
  //updates the speed if this dude is scared of other dudes
  void updateScared () {
    
  }
  
  //returns the x and y location of the dude
  ArrayList<Float> returnLocation () {
    ArrayList<Float> location = new ArrayList<Float>();
    
    location.add(x);
    location.add(y);
    
    return location;
  }
  
  void drawDude () {
    fill(255, 140, 0);
    circle(x, y, radius * 2);
  }
}
