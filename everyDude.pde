dude[] dudes = new dude[50];

void setup() {
  fullScreen();
  background(55, 55, 55);
  
  // Initialize each dude with random values
  for (int i = 0; i < dudes.length; i++) {
    float x = random(20, width - 20);                 
    float y = random(20, height - 20);
    float xSpeed = random(-.005, .005);            
    float ySpeed = random(-.005, .005);
    //float xSpeed = random(-.5, .5);            
    //float ySpeed = random(-.5, .5);
    boolean attractedToDudes = random(1) > 0.5;
    boolean scaredOfDudes = false;
    float radius;
    
    //gives scared dudes an advantage to begin with
    if (!attractedToDudes) {
      scaredOfDudes = true; 
      radius = random(10, 20); 
    }else {
      radius = random(5, 15); 
    }
    
    dudes[i] = new dude(x, y, xSpeed, ySpeed, radius, i, attractedToDudes, scaredOfDudes);
  }
}

void draw() {
  background(55, 55, 55);
  //Update and draw each dude
  for (int i = 0; i < dudes.length; i++) {
    dudes[i].update(dudes);
    dudes[i].drawDude();
  }
 
  sortDudesByRadius();  
  float[] secondLargestDude = dudes[dudes.length - 2].returnInformation();
  float[] largestDude = dudes[dudes.length - 1].returnInformation();
  
  //checks to see if there is only one dude left or if one dude is much bigger than any other dude. This sets the screen to a blank and the winner in the middle
  if (secondLargestDude[2] == 0 || largestDude[2] >= height / 2) {
    background(90, 90, 90);
    textSize(30);
    text(dudes[dudes.length - 1].dudeNumber + " wins", width / 2, height / 2);
  }
}

//sorts the dudes by radius size so it looks good on the map (bigger dude overlaps smaller dude)
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
