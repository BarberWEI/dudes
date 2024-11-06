dude[] dudes = new dude[10];

void setup() {
  size(700, 700);
  background(55, 55, 55);
  
  //Initialize the dudes randomly
  
  // Initialize each dude with random values
  for (int i = 0; i < dudes.length; i++) {
    float x = random(30, width - 30);                 
    float y = random(30, height - 30);
    float xSpeed = random(-.05, .05);            
    float ySpeed = random(-.05, .05);
    float radius = random(10, 35); 
    boolean attractedToDudes = random(1) > 0.5; 
    boolean scaredOfDudes;
    if (!attractedToDudes) {
      scaredOfDudes = random(1) > 0.5; 
    }else {
      scaredOfDudes = false; 
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
