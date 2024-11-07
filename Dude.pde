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
    //checks to see if the ball is close enough to another ball to detect and move towards or away from it, set to 300
    closeEnoughToDetect(distance, targetX, targetY);
    //checks to see if this ball eats someone is is eaten by someone this frame
    checkEat(distance, targetRadius);
    updateBounceOffWall();
    
  }
  
  // only runs towards or away when distance is smaller than a certain number
  void closeEnoughToDetect (float distance, float targetX, float targetY) {
    if (distance < 200) {
      if (scaredOfDudes) {
        updateScared(targetX, targetY);
      }else if (attractedToDudes) {
        updateLove(targetX, targetY);
      }
    }
  }
  //code for dudes eating other dudes and dudes being eaten by other dudes
  void checkEat (float distance, float targetRadius) {
    if (distance <  targetRadius && radius < targetRadius) {
      x = random(5000, 50000);
      y = random(5000, 50000);
      xSpeed = 0;
      ySpeed = 0;
    //radius plus 1 because sometimes the timing is broken without the +1 and a ball teleports away before the other one detects it
    }else if (distance <  radius + 5 && radius >= targetRadius) {
      radius += targetRadius; 
      
      //prevents the ball from being stuck on the wall when it eats someone next to the wall
      checkStuckOnWallAfterEating(targetRadius);
    }
  }
  
  //the extra aditions and subtraction is the prevent the ball from being stuck on the wall
  void updateBounceOffWall () {
  if (x >= width - (radius + xSpeed) || x <= radius - xSpeed ) {
        xSpeed = -xSpeed;
    }
    if (y >= height - (radius + ySpeed) || y <= radius - ySpeed) {
        ySpeed = -ySpeed;
    }
    x += xSpeed;
    y += ySpeed; 
  }

  //prevents the ball from being stuck on the wall when it eats someone next to the wall
  void checkStuckOnWallAfterEating (float targetRadius) {
    if (x >= width - (radius + xSpeed)) {
      x -= targetRadius;
    }else if(x <= radius - xSpeed ) {
      x += targetRadius;
    }
    
    if (y >= height - (radius + ySpeed)) {
      y -= targetRadius;
    }else if(y <= radius - ySpeed) {
      y += targetRadius;
    }
   
  }
    
  //updates the speed if this dude is scared of other dudes. targetX and targetY are the x and y coords of the chosen dude that this bot is scared of 
  void updateScared (float targetX, float targetY) {
    float deltaX = targetX - x;
    float deltaY = targetY - y;
    float angle = atan2(deltaY, deltaX);
    xSpeed -= (0.07 * cos(angle) * totalSpeed);
    ySpeed -= (0.07 *sin(angle) * totalSpeed);
  }
  
  //updates the speed if this dude is in love with other dudes. targetX and targetY are the x and y coords of the chosen dude that this bot is in love with
  void updateLove (float targetX, float targetY) {
    float deltaX = targetX - x;
    float deltaY = targetY - y;
    float angle = atan2(deltaY, deltaX);
    xSpeed += 0.01 * cos(angle) * totalSpeed;
    ySpeed += 0.01 * sin(angle) * totalSpeed;
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
    if (attractedToDudes) {
      fill(255, 165, 0);
    }else {
      fill(40, 40, 40);
    }
    circle(x, y, radius * 2);
  }
}
