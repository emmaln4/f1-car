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

PVector posizioneMacchina = new PVector(3258, -100, 117);
float angoloMacchina = PI;

PVector posizioneCamera;
PVector targetCamera;

float angoloCamera = 180;     // angolo orizzontale della camera
float inclinazioneCamera = radians(10); // verticale (non troppo alto)
float distanzaCamera = 225;  // distanza dietro la macchina

float velocita;
float accelerazione = 0.5;
float frenata = 0.8;
float maxVelocita = 60; // ≈ 300 km/h

PImage hud;

PVector Velocita;
ArrayList<PVector> muri = new ArrayList<PVector>();

void setup() {
  size(800, 600, P3D);
 for (float ang = 0; ang < TWO_PI; ang += 0.1) {
    float muroRaggio = 3700; // un po' fuori dalla pista
    float x = cos(ang) * muroRaggio;
    float z = sin(ang) * muroRaggio;
    muri.add(new PVector(x, 0, z));
  }
  noSmooth();
  hint(DISABLE_OPENGL_ERRORS);
  hint(DISABLE_TEXTURE_MIPMAPS);
  lights();

modello = loadShape("source/fw16.obj");
modello.scale(0.2);  // più piccolo
modello.rotateZ(PI);

posizioneCamera = new PVector(0, 100, 200);
targetCamera = new PVector(0, 0, 0);

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

  posizioneCamera = new PVector(100, -40, 1);
  targetCamera = new PVector(0, 0, 0);
  
  hud = loadImage("hud.tiff");
}

void draw() {
  background(#CCF1FC);
  Camera();
  pista();
  //pista2();
  terra();
  macchina();
  muovere();
  fill(0, 255, 0);
  println(frameRate);
  
  hint(DISABLE_DEPTH_TEST);
  camera();
  noLights();
  fill(255);
  textSize(15);
  //textAlign(LEFT, TOP);
 
  hud.resize(300, 200);
  image(hud, 0, 0);
  int marcia = calcolaMarcia(velocita);
  text(nf(velocita * 3.6, 1, 1) , 75, 130);
  textSize(40);
  text(marcia, 130, 135);
  hint(ENABLE_DEPTH_TEST);
}

int calcolaMarcia(float v) {
  if (v < 15) return 1;
  if (v < 40) return 2;
  if (v < 70) return 3;
  if (v < 100) return 4;
  if (v < 150) return 5;
  if (v < 200) return 6;
  return 7; // marcia finale
}

void disegnaTerra() {
  stroke(255);
  for (float x = -5000; x <= 5000; x = x + 100) {
    line(x, height, -5000, x, height, 5000);
    line(-5000, height, x, 5000, height, x);
  }
}

void mouseDragged() {
  float velocita = 0.01;
  angoloCamera -= (mouseX - pmouseX) * velocita;
  inclinazioneCamera -= (mouseY - pmouseY) * velocita;
  // Limita l'inclinazione tra -PI/2 e PI/2 per evitare giri strani
  inclinazioneCamera = constrain(inclinazioneCamera, -PI/2 + 0.1, PI/2 - 0.1);
}
