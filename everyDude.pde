dude[] dudes = new dude[4];

void setup() {
  size(700, 700);
  background(55, 55, 55);
  
  //Initialize the dudes randomly
  
  dudes[0] = new dude(350, 400, 1, 0.8, 26, false, false);
  dudes[1] = new dude(40, 60, 2, 0.5, 25, false, true);
  dudes[2] = new dude(500, 200, 1, 0.8, 26, true, false);
  dudes[3] = new dude(90, 100, 2, 0.5, 25, false, true);
}

void draw() {
  background(55, 55, 55);
  
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
