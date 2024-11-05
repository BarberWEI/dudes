dude dude1 = new dude(350, 350, 10, 10, 25, false, true);

void setup () {
  size(700, 700);
  background(55, 55, 55);
}

void draw () {
  background(55, 55, 55);
  dude1.update();
  dude1.drawDude();
}
