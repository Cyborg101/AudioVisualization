class Particle {

  PVector position;
  PVector velocity = new PVector(-1, 0.0);
  PVector acceleration = new PVector(0.0, 0.0);
  float diameter;
  float mass;
  color colore = color(110, 82, 223);

  Particle (PVector _position, float _mass) {
    position = _position;
    mass = _mass;
    diameter = _mass * 20;
  }

  void Update() {
    velocity.add(acceleration);
    velocity.limit(3);
    velocity.mult(0.99);
    position.add(velocity); 
    acceleration.mult(0);
  }

  void CheckBorders() {
    if (position.x > width) {
      position.x = width;
      velocity.x *= -1;
    } else if (position.x < 0) {
      velocity.x *= -1;
      position.x = 0;
    }

    if (position.y > height) {
      velocity.y *= -1;
      position.y = height;
    } else if ( position.y < 0 ) {
      position.y = 0; 
      velocity.y *= -1;
    }
  }

  void applyForce(PVector force) {
    PVector a = PVector.div(force, mass);
    acceleration.add( a );
  }

  void applyFriction(float c) {
    PVector friction = velocity.normalize().mult(c).mult(-1);
    applyForce(friction);
  }

  void setColore(color c) {
    colore = c;
  }

  boolean CheckCollision( Particle p) {

    if ( dist(position.x, position.y, p.position.x, p.position.y)<=((diameter+p.diameter)/2.0)) {
      return true;
    }
    return false;
  }



  void Display() {
    stroke(1);
    strokeWeight(1);
    fill(colore);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, diameter, diameter);
  }
}