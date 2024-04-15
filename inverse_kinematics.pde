Limb myLimb;

void setup() {
  size(1000, 1000);
  background(0);

  stroke(255, 0, 0);
  fill(255, 0, 0);
  circle(width/2, height/2, 5);

  var jointLengths = new float[]{200, 10 ,175};
  myLimb = new Limb(jointLengths);
  myLimb.Translate(new PVector(100, height/2));
  myLimb.SetTarget(new PVector(width/4, height/2 + myLimb.L - 40), 0);
}

boolean limbSet = false;

void draw() {
  background(0);
  myLimb.Display();
  myLimb.Translate(new PVector(5, 0));
  if (myLimb.p[0].x > width + 200) {
    myLimb.p[0].x = -200;
    myLimb.SetTarget(new PVector(width/4, height/2 + myLimb.L - 40), 0);
    limbSet = false;
  }

  /*
   
   float targetX = -1;
   float targetY = height/2 + myLimb.L - 40;
   
   //if(myLimb.p[0].x < width/2)
   targetX = width/4;
   if (myLimb.p[0].x > width /2 && myLimb.p[0].x < width * (3.0/4.0)) {
   targetX = map(myLimb.p[0].x, width/2, width * (3.0/4.0), width/4, width * (3.0/4.0));
   targetY -= sin((-width/2 + myLimb.p[0].x) * 0.012) * 150;
   } else if (myLimb.p[0].x >= width * (3.0/4.0))
   targetX = width * (3.0/4.0);
   myLimb.FABRIK(new PVector(targetX, targetY));*/

  PVector newTarget = new PVector(width * (3.0/4.0), height/2 + myLimb.L - 40);
  float dist = PVector.sub(newTarget, myLimb.p[0]).mag();
  if (myLimb.p[0].x > width/2.15 && dist > myLimb.L && !limbSet) {
    myLimb.SetTarget(newTarget, 40);
    limbSet = true;
  }




  myLimb.Move();
}
