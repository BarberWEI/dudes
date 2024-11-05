dude dude1 = new dude(350, 400, 1, .1, 26, true, false);
dude dude2 = new dude(40, 60, 2, .5, 25, false, true);
void setup () {
  size(700, 700);
  background(55, 55, 55);
}

void draw () {
  ArrayList<Float> dude2Information = new ArrayList<Float>();
  dude2Information = dude2.returnInformation();
  ArrayList<Float> dude1Information = new ArrayList<Float>();
  dude1Information = dude1.returnInformation();
  
  background(55, 55, 55);
  dude1.update(dude2Information.get(0), dude2Information.get(1), dude2Information.get(2));
  dude1.drawDude();
  dude2.update(dude1Information.get(0), dude1Information.get(1), dude1Information.get(2));
  dude2.drawDude();
}
