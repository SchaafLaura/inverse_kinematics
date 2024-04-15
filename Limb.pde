class Limb {
  float tol = 1;

  // joint positions
  PVector[] p;

  // joint distances
  float[] d;

  // total limb-length
  float L = 0;

  public Limb(float... d) {
    this.d = d;

    p = new PVector[d.length + 1];
    p[0] = new PVector(0, 0);
    for (int i = 0; i < d.length; i++) {
      // calculate total limb length
      L += d[i];

      // set position of joints
      p[i + 1] = new PVector(d[i], 0);
      if (i == 0) continue;

      // since distances are given, offset joint position by previous joint position
      p[i + 1].x += p[i].x;
    }
  }

  // Forward And Backward Reaching Inverse Kinematics
  void FABRIK(PVector t) {
    float dist = PVector.sub(p[0], t).mag();

    if (dist > L) {// unreachable target
      for (int i = 0; i < p.length - 1; i++) {
        float r = PVector.sub(t, p[i]).mag(); // distance between target and joint
        float lambda = d[i] / r;

        // new joint position
        p[i+1] = PVector.add(
          PVector.mult(p[i], 1-lambda),
          PVector.mult(t, lambda));
      }
    } else { // reachable target
      // save initial root position
      PVector b = new PVector(p[0].x, p[0].y);

      // check whether the distance between the end effector
      // and the target is greater than tolerance
      float diff = PVector.sub(p[p.length-1], t).mag();
      while (diff > tol) {
        // STAGE 1: FORWARD REACHING
        p[p.length-1] = t;
        for (int i = p.length - 2; i >= 0; i--) {
          // distance between new joint position
          float r = PVector.sub(p[i+1], p[i]).mag();
          float lambda = d[i] / r;

          // new joint position
          p[i] = PVector.add(
            PVector.mult(p[i+1], 1-lambda),
            PVector.mult(p[i], lambda)
            );
        }

        // STAGE 2: BACKWARD REACHING
        p[0] = b;
        for (int i = 0; i < p.length - 1; i++) {
          // distance between new joint position
          float r = PVector.sub(p[i+1], p[i]).mag();
          float lambda = d[i] / r;

          // new joint position
          p[i+1] = PVector.add(
            PVector.mult(p[i], 1-lambda),
            PVector.mult(p[i+1], lambda)
            );
        }
        // update dist between target and end effector
        diff = PVector.sub(p[p.length-1], t).mag();
      }
    }
  }



  void Translate(PVector x) {
    for (var pos : p)
      pos.add(x);
  }

  void Display() {
    fill(255);
    stroke(255);
    for (int i = 0; i < p.length; i++) {
      circle(p[i].x, p[i].y, 10);
      if (i == 0) continue;
      line(p[i].x, p[i].y, p[i-1].x, p[i-1].y);
    }
  }
}
