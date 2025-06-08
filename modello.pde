//emma adkins
//giugno 2, 2025
import java.awt.Robot;
Robot rbt;
boolean saltaCornici;

PShape modello;
float roty, rotx;

PShape pista;

boolean wkey, akey, skey, dkey;

int grandezza;

PVector posizioneMacchina = new PVector(0, 5, 0);
float angoloMacchina = 0;

PVector posizioneCamera;
PVector targetCamera;

void setup() {
  size(800, 600, P3D);

  noSmooth();
  hint(DISABLE_OPENGL_ERRORS);
  hint(DISABLE_TEXTURE_MIPMAPS);
  lights();

  pista = loadShape("source1/BahrainFinalLightDef.blend.obj");

  pista.setStroke(false);

  pista.rotateZ(PI);
  pista.scale(0.1);
  modello = loadShape("source/fw16.obj");
  modello.scale(0.01);
  modello.rotateZ(PI);
  wkey = akey = skey = dkey = false;
  noCursor();
  try {
    rbt = new Robot();
  }
  catch (Exception e) {
    e.printStackTrace();
  }
  saltaCornici = false;

  grandezza = 100;

  posizioneCamera = new PVector(0, -40, 1);
  targetCamera = new PVector(0, 0, 0);
}

void draw() {
  background(0);
  Camera();
  pista();
  macchina();
  muovere();
  fill(0, 255, 0);
  println(frameRate);
}

void disegnaTerra() {
  stroke(255);
  for (float x = -5000; x <= 5000; x = x + 100) {
    line(x, height, -5000, x, height, 5000);
    line(-5000, height, x, 5000, height, x);
  }
}
