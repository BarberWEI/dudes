dude dude1 = new dude(350, 350, 10, 20, 25, true, false);
dude dude2 = new dude(0, 10, 35, 40, 25, false, true);
void setup () {
  size(700, 700);
  background(55, 55, 55);
}

void draw () {
  ArrayList<Float> dude2Location = new ArrayList<Float>();
  dude2Location = dude2.returnLocation();
  ArrayList<Float> dude1Location = new ArrayList<Float>();
  dude1Location = dude1.returnLocation();
  
  background(55, 55, 55);
  dude1.update(dude2Location.get(0), dude2Location.get(1));
  dude1.drawDude();
  dude2.update(dude1Location.get(0), dude1Location.get(1));
  dude2.drawDude();
}
