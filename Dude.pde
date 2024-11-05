public class dude {
  boolean scaredOfDudes;
  boolean attractedToDudes;
  float x, y;
  float xSpeed, ySpeed;
  float radius;
  float totalSpeed;
  
  public dude (float x, float y, float xSpeed, float ySpeed, float radius, boolean attractedToDudes, boolean scaredOfDudes) {
    this.x = x;
    this.y = y;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
    this.radius = radius;
    this.attractedToDudes = attractedToDudes;
    this.scaredOfDudes = scaredOfDudes;
    this.totalSpeed = sqrt(sq(xSpeed) + sq(ySpeed));
  }
  
  public dude () {
    this.x = 350;
    this.y = 350;
    this.xSpeed = 10;
    this.ySpeed = -5;
    this.radius = 25;
    this.attractedToDudes = false;
    this.scaredOfDudes = false;
    this.totalSpeed = sqrt(sq(xSpeed) + sq(ySpeed));
  }
  
  //targetX and targetY are the x and y coords of another target dude
  void update (float targetX, float targetY) {
    float distance = sqrt(sq(x - targetX) + sq(y - targetY));
    
    x += xSpeed;
    y += ySpeed; 
    
    // only runs towards or away when distance is smaller than a certain number
    if (distance < 100) {
      if (scaredOfDudes) {
        updateScared(targetX, targetY);
      }else if (attractedToDudes) {
        updateLove(targetX, targetY);
      }
    }
    if (x > width - radius || x < radius ) {
        xSpeed = -xSpeed;
    }
    if (y > height - radius || y < radius ) {
        ySpeed = -ySpeed;
    }
  }
  
  //updates the speed if this dude is scared of other dudes. targetX and targetY are the x and y coords of the chosen dude that this bot is scared of 
  void updateScared (float targetX, float targetY) {
    float deltaX = targetX - x;
    float deltaY = targetY - y;
    float angle = atan2(deltaY, deltaX);
    xSpeed = -(cos(angle) * totalSpeed);
    ySpeed = -(sin(angle) * totalSpeed);
  }
  
  //updates the speed if this dude is in love with other dudes. targetX and targetY are the x and y coords of the chosen dude that this bot is in love with
  void updateLove (float targetX, float targetY) {
    float deltaX = targetX - x;
    float deltaY = targetY - y;
    float angle = atan2(deltaY, deltaX);
    xSpeed = cos(angle) * totalSpeed;
    ySpeed = sin(angle) * totalSpeed;
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
