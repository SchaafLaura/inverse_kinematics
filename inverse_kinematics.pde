Limb myLimb;

void setup() {
  size(1000, 1000);
  background(0);

  stroke(255, 0, 0);
  fill(255, 0, 0);
  circle(width/2, height/2, 5);
  
  var jointLengths = new float[500];
  for(int i = 0; i < jointLengths.length; i++)
    jointLengths[i] = 1.5;
  myLimb = new Limb(jointLengths);
  myLimb.Translate(new PVector(width/2, height/2));
  
}

void draw() {
  //background(0);
  myLimb.Display();
  
  float targetX = noise(10 + frameCount * 0.005);
  float targetY = noise(15 + frameCount * 0.005);
  targetX = map(targetX, 0, 1, 0 - 200, width + 200);
  targetY = map(targetY, 0, 1, 0 - 200, height + 200);
  
  myLimb.FABRIK(new PVector(targetX, targetY));
}
