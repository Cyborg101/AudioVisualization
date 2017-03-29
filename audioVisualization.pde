import ddf.minim.*;
import ddf.minim.analysis.*;
Rectangle[] kick = new Rectangle[4];
Rectangle[] snare = new Rectangle[4];
Rectangle[] hihat = new Rectangle[4];
Particle[] p = new Particle[12];
color kick_c = color(220, 102, 23);
color snare_c = color(120, 202, 123);
color hihat_c = color(110, 82, 223);

float angle = 0;


PVector gravity = new PVector(0, 0.1);
float kick_w = 40f;
float kick_h = 10f;
float snare_w = 40f;
float snare_h = 10f;
color background = 51;

int len = 10;


Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;

float kickSize, snareSize, hatSize;

void setup()
{
  size(512, 200);

  minim = new Minim(this);

  song = minim.loadFile("Comfort_Fit_-_03_-_Sorry.mp3", 1024);
  song.play();
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  beat.setSensitivity(300);  
  kickSize = snareSize = hatSize = 16;
  bl = new BeatListener(beat, song);

  for (int i = 0; i < kick.length; i++) {
    float x = (float) (width / (float) kick.length) * i;
    kick[i] = new Rectangle(new PVector(x, 0), kick_w, kick_h);
    kick[i].setColore(kick_c);
  }

  for (int i = 0; i < snare.length; i++) {
    float x = (float) (width / (float) kick.length) * i;
    snare[i] = new Rectangle(new PVector(x + kick_w, 0), snare_w, snare_h);
    snare[i].setColore(snare_c);
  }

  for (int i = 0; i < snare.length; i++) {
    float x = (float) (width / (float) kick.length) * i;
    hihat[i] = new Rectangle(new PVector(x + kick_w + snare_w, 0), snare_w, snare_h);
    hihat[i].setColore(hihat_c);
  }

  for (int i = 0; i < p.length; i++) {
    p[i] = new Particle(new PVector(width / 2 + random(-200, 200), height - 10), 1);
    if (i < 4 ) {
      p[i].setColore(kick_c);
    } else if (i < 8) {
      p[i].setColore(snare_c);
    }
  }
}

void draw()
{

  background(background);

  for (int i = 0; i < kick.length; i++) {
    kick[i].show();
    snare[i].show();
    hihat[i].show();
  }


  if ( beat.isKick() ) {  // true when a kick (cassa) is detected
    for (int i = 0; i < kick.length; i++) {
      kick[i].setH(50 + random(60));
      p[i].applyForce(new PVector(random(-0.4, 0.1), -1.1));
    }

  }
  if ( beat.isSnare() ) { // true when a snare (rullante) is detected

    // do something else
    for (int i = 0; i < kick.length; i++) {
      snare[i].setH(80 + random(60));
      p[i+4].applyForce(new PVector(random(-0.1, 0.4), -1.6));
    }
    background = color(random(70));

  }
  if ( beat.isHat() ) { // true when a hat (piatto) is detected
    // do something else
    for (int i = 0; i < kick.length; i++) {
      hihat[i].setH(40 + random(60));
      hihat[i].show();
    }
    for (int i = 8; i < p.length; i++) {
      p[i].applyForce(new PVector(random(-2, 2), -1.0));
    }
    

  }

  for (int i = 0; i < p.length; i++) {
    p[i].applyForce(gravity); 
    for (int j=i+1; j<p.length; j++) {
      if (p[i].CheckCollision(p[j])) {
        PVector force = PVector.sub( p[i].position, p[j].position); // vettore da particella j a i
        force.normalize(); // direzione da j a i normalizzata
        force.mult(2.0);  
        p[i].applyForce( force );
        p[j].applyForce( force.mult(-1.0) ); // alla particella j applico la forza contraria
      }
    }

    p[i].CheckBorders();
    p[i].Update();
    p[i].Display();
  }
}