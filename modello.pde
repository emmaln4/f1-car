//emma adkins
//giugno 2, 2025

PShape modello;
float roty, rotx;

boolean wkey, akey, skey, dkey;

PVector posizioneMacchina = new PVector(3258, -100, 117);
float angoloMacchina = PI;

PVector posizioneCamera;
PVector targetCamera;

float angoloCamera = 180;     // angolo orizzontale della camera
float inclinazioneCamera = radians(10); // verticale (non troppo alto)
float distanzaCamera = 225;  // distanza dietro la macchina

float velocita;
float accelerazione = 0.2;
float frenata = 0.5;
float maxVelocita = 60; // ≈ 300 km/h

PImage hud;

PVector Velocita;
ArrayList<PVector> muri = new ArrayList<PVector>();

PShape partenza;

int giroCorrente = 0;
boolean sulSettoreFinale = false;

void setup() {
  size(800, 600, P3D);
  for (float ang = 0; ang < TWO_PI; ang += 0.1) {
    float muroRaggio = 3500; // un po' fuori dalla pista
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

  posizioneCamera = new PVector(100, -40, 1);
  targetCamera = new PVector(0, 0, 0);

  hud = loadImage("hud.tiff");
}

void draw() {
  background(#CCF1FC);
  Camera();

  lights();
  pista();
  terra();
  macchina();
  tribunaTuttoAttorno(3600, -100, 8, 600);
  torreCentroPista(0, 0, 0);
  controllaGiro();
  muovere();
  fill(0, 255, 0);
  println(frameRate);

  pushMatrix();
  hint(DISABLE_DEPTH_TEST);
  
  camera();
  noLights();
  fill(255);
  textSize(15);
  hud.resize(300, 200);
  image(hud, 0, 0);
  int marcia = calcolaMarcia(velocita);
  text(nf(velocita * 3.6, 1, 1), 85, 125);
  textSize(40);
  text(marcia, 140, 115);

  hint(ENABLE_DEPTH_TEST);
  popMatrix();
}

int calcolaMarcia(float v) {
  
  float vKmh = v * 3.6;
  
  if (vKmh < 10) return 1;
  if (vKmh < 30) return 2;
  if (vKmh < 60) return 3;
  if (vKmh < 90) return 4;
  if (vKmh < 140) return 5;
  if (vKmh < 190) return 6;
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

void controllaGiro() {
  // Calcola l'angolo attuale sul piano XZ (da -PI a PI)
  float angolo = atan2(posizioneMacchina.z, posizioneMacchina.x);

  // Se ti trovi vicino alla linea di partenza (angolo ≈ 0)
  if (abs(angolo) < radians(5)) {
    // e stavi nel settore finale, significa che hai completato un giro
    if (sulSettoreFinale) {
      giroCorrente++;
      sulSettoreFinale = false;
    }
  } else {
    // non sei più vicino alla linea, puoi conteggiare un nuovo giro
    sulSettoreFinale = true;
  }
}
