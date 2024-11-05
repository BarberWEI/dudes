dude dude1 = new dude(350, 350, 10, 20, 25, true, false);

void setup () {
  size(700, 700);
  background(55, 55, 55);
}

void draw () {
  background(55, 55, 55);
  dude1.update(200, 350);
  dude1.drawDude();
}
