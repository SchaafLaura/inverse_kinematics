Limb myLimb;
PVector initialTarget;
PVector newTarget;
PVector speed = new PVector(10, 0);
void setup() {
  size(1000, 1000);
  background(0);

  var jointLengths = new float[]{200, 200};
  myLimb = new Limb(jointLengths);
  
  initialTarget = new PVector(width/4, height/2 + myLimb.L - 40);
  newTarget = new PVector(width * (3.0/4.0), height/2 + myLimb.L - 40);
  
  myLimb.SetTarget(initialTarget, 0);
  myLimb.Translate(new PVector(100, height/2));
}

boolean limbSet = false;

void draw() {
  background(0);
  myLimb.Display();
  myLimb.Translate(speed);
  if (myLimb.p[0].x > width + 200) {
    myLimb.p[0].x = -200;
    myLimb.SetTarget(initialTarget, 0);
    limbSet = false;
  }

  float dist = PVector.sub(newTarget, myLimb.p[0]).mag();
  if (myLimb.p[0].x > width/3 && dist > myLimb.L && !limbSet) {
    myLimb.SetTarget(newTarget, 20);
    limbSet = true;
  }
  myLimb.Move();
}
