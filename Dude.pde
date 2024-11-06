public class dude {
  boolean scaredOfDudes;
  boolean attractedToDudes;
  float x, y;
  float xSpeed, ySpeed;
  float radius;
  float totalSpeed;
  final float maxRadius = 200;
  
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
  
  //targetX and targetY are the x and y coords of another target dude. also gets the radius of the chosen dude so we can tell which one is bigger
  void update (float targetX, float targetY, float targetRadius) {
    float distance = sqrt(sq(x - targetX) + sq(y - targetY));
    
    // only runs towards or away when distance is smaller than a certain number
    if (distance < 200) {
      if (scaredOfDudes) {
        updateScared(targetX, targetY);
      }else if (attractedToDudes) {
        updateLove(targetX, targetY);
      }
    }

    if (distance <  targetRadius && radius < targetRadius) {
      x = random(5000, 50000);
      y = random(5000, 50000);
      xSpeed = 0;
      ySpeed = 0;
      print("i got eaten");
      
    }else if (distance <  radius && radius >= targetRadius) {
      radius += targetRadius; 
      print("i ate someone");
    }
    
    //the extra aditions and subtraction is the prevent the ball from being stuck on the wall
    if (x >= width - (radius + xSpeed) || x <= radius - xSpeed ) {
        xSpeed = -xSpeed;
    }
    if (y >= height - (radius + ySpeed) || y <= radius - ySpeed) {
        ySpeed = -ySpeed;
    }
    
    x += xSpeed;
    y += ySpeed; 
  }

  //updates the speed if this dude is scared of other dudes. targetX and targetY are the x and y coords of the chosen dude that this bot is scared of 
  void updateScared (float targetX, float targetY) {
    float deltaX = targetX - x;
    float deltaY = targetY - y;
    float angle = atan2(deltaY, deltaX);
    xSpeed += -(0.05 * cos(angle) * totalSpeed);
    ySpeed += -(0.05 *sin(angle) * totalSpeed);
  }
  
  //updates the speed if this dude is in love with other dudes. targetX and targetY are the x and y coords of the chosen dude that this bot is in love with
  void updateLove (float targetX, float targetY) {
    float deltaX = targetX - x;
    float deltaY = targetY - y;
    float angle = atan2(deltaY, deltaX);
    xSpeed += 0.05 * cos(angle) * totalSpeed;
    ySpeed += 0.05 * sin(angle) * totalSpeed;
  }
  
  //returns the x and y location of the dude as well as the radius.
  float[] returnInformation () {
    float[] information = new float[3];
    
    information[0] = x;
    information[1] = y;
    information[2] = radius;
    return information;
  }
  
  void drawDude () {
    fill(255, 140, 0);
    circle(x, y, radius * 2);
  }
}
