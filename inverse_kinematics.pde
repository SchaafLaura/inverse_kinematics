Limb myLimb = new Limb(200, 200);

void setup() {
  size(1000, 1000);
  background(0);

  stroke(255, 0, 0);
  fill(255, 0, 0);
  circle(width/2, height/2, 5);

  myLimb.Translate(new PVector(width/2, height/2));
  
}

void draw() {
  background(0);
  myLimb.Display();
  myLimb.FABRIK(new PVector(mouseX, mouseY));
}
