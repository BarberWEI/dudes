public class dude {
  private boolean scaredOfDudes;
  private boolean attractedToDudes;
  private boolean isPlayerDude;
  private float x, y;
  private float xSpeed, ySpeed;
  public float radius;
  private float totalSpeed;
  public int dudeNumber;
  private static final float DETECTION_DISTANCE = 200;
  private static final float RANDOM_BOUND_LOW = 5000;
  private static final float RANDOM_BOUND_HIGH = 50000;


  public dude (float x, float y, float xSpeed, float ySpeed, float radius, int amountOfDudes, boolean attractedToDudes, boolean scaredOfDudes, boolean isPlayerDude) {
    this.x = x;
    this.y = y;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
    this.radius = radius;
    this.attractedToDudes = attractedToDudes;
    this.scaredOfDudes = scaredOfDudes;
    this.totalSpeed = sqrt(sq(xSpeed) + sq(ySpeed));
    dudeNumber = amountOfDudes;
    this.isPlayerDude = isPlayerDude;
  }

  //targetX and targetY are the x and y coords of another target dude. also gets the radius of the chosen dude so we can tell which one is bigger
  void update (dude[] dudes) {
    for (int i = 0; i < dudes.length; i++) {
      if (dudes[i] != this) {
        float[] targetInfo = dudes[i].returnInformation();
        float targetX = targetInfo[0];
        float targetY = targetInfo[1];
        float targetRadius = targetInfo[2];
        float distance = (float) Math.sqrt(Math.pow(x - targetX, 2) + Math.pow(y - targetY, 2));

        closeEnoughToDetect(distance, targetX, targetY, targetRadius);
        checkEat(distance, targetRadius);
      }
    }
    updateBounceOffWall();
  }

  // only runs towards or away when distance is smaller than a certain number
  void closeEnoughToDetect (float distance, float targetX, float targetY, float targetRadius) {
    if (distance < DETECTION_DISTANCE + targetRadius) {
      if (scaredOfDudes) {
        updateScared(targetX, targetY, targetRadius);
      } else if (attractedToDudes) {
        updateLove(targetX, targetY, targetRadius);
      } else if (isPlayerDude) {
        movePlayerBall();
      }
    }
  }

  //code for player controlled ball
  void movePlayerBall() {
    keyPressed();
    if (keyCode == 37) {
      xSpeed -= 0.1;
    } else if (keyCode == 39) {
      xSpeed += 0.1;
    } else if (keyCode == 38) {
      ySpeed -= 0.1;
    } else if (keyCode == 40) {
      ySpeed += 0.1;
    }
    keyCode = 0;
  }

  //code for dudes eating other dudes and dudes being eaten by other dudes
  void checkEat (float distance, float targetRadius) {
    if (distance <  targetRadius && radius < targetRadius) {
      //teleports dude to random location outside of map
      x = random(RANDOM_BOUND_LOW, RANDOM_BOUND_HIGH);
      y = random(RANDOM_BOUND_LOW, RANDOM_BOUND_HIGH);
      xSpeed = 0;
      ySpeed = 0;
      radius = 0;

      //radius plus 1 because sometimes the timing is broken without the +1 and a ball teleports away before the other one detects it
    } else if (distance <  radius + 5 && radius >= targetRadius) {
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
    } else if (x <= radius - xSpeed ) {
      x += targetRadius;
    }
    if (y >= height - (radius + ySpeed)) {
      y -= targetRadius;
    } else if (y <= radius - ySpeed) {
      y += targetRadius;
    }
  }

  //updates the speed if this dude is scared of other dudes. targetX and targetY are the x and y coords of the chosen dude that this bot is scared of
  void updateScared (float targetX, float targetY, float targetRadius) {
    float deltaX = targetX - x;
    float deltaY = targetY - y;
    float angle = atan2(deltaY, deltaX);
    if (targetRadius > radius) {
      xSpeed -= (1.5 * cos(angle) * totalSpeed);
      ySpeed -= (1.5 * sin(angle) * totalSpeed);
    }
  }

  //updates the speed if this dude is in love with other dudes. targetX and targetY are the x and y coords of the chosen dude that this bot is in love with
  void updateLove (float targetX, float targetY, float targetRadius) {
    float deltaX = targetX - x;
    float deltaY = targetY - y;
    float angle = atan2(deltaY, deltaX);
    if (targetRadius < radius) {
      xSpeed += .5 * cos(angle) * totalSpeed;
      ySpeed += .5 * sin(angle) * totalSpeed;
    }
  }

  //returns the x and y location of the dude as well as the radius.
  float[] returnInformation () {
    float[] information = new float[4];

    information[0] = x;
    information[1] = y;
    information[2] = radius;
    information[3] = dudeNumber;

    return information;
  }

  void drawDude () {
    if (attractedToDudes) {
      fill(255, 165, 0);
    } else if (scaredOfDudes) {
      fill(40, 40, 40);
    } else if (isPlayerDude) {
      fill(255, 255, 255);
    }

    circle(x, y, radius * 2);
    fill(0, 0, 0);
    text(dudeNumber, x, y);
  }
}
