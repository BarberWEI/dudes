dude[] dudes = new dude[60];

void setup() {
  size(1440, 850);
  background(55, 55, 55);
  
  // Initialize each dude with random values
  for (int i = 0; i < dudes.length; i++) {
    float x = random(20, width - 20);                 
    float y = random(20, height - 20);
    float xSpeed = random(-.0005, .0005);            
    float ySpeed = random(-.0005, .0005);
    boolean attractedToDudes = random(1) > 0.5;
    boolean scaredOfDudes = false;
    float radius;
    if (!attractedToDudes) {
      scaredOfDudes = true; 
      radius = random(12.5, 20); 
    }{
      radius = random(5, 12.5); 
    }
    
    dudes[i] = new dude(x, y, xSpeed, ySpeed, radius, attractedToDudes, scaredOfDudes);
  }
}

void draw() {
  background(55, 55, 55);
  sortDudesByRadius();
  
  //Update and draw each dude
  for (int i = 0; i < dudes.length; i++) {
    for (int j = 0; j < dudes.length; j++) {
      if (i != j) {
        float[] targetInfo = dudes[j].returnInformation();
        dudes[i].update(targetInfo[0], targetInfo[1], targetInfo[2]);
      }
    }
    dudes[i].drawDude();
  }
}

void sortDudesByRadius() {
  for (int i = 0; i < dudes.length - 1; i++) {
    for (int j = 0; j < dudes.length - i - 1; j++) {
      if (dudes[j].radius > dudes[j + 1].radius) {
        // Swap dudes[j] and dudes[j + 1]
        dude temp = dudes[j];
        dudes[j] = dudes[j + 1];
        dudes[j + 1] = temp;
      }
    }
  }
}
