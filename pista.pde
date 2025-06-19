void pista() {
  pushMatrix();
  translate(0, 0, 0);
  fill(60);      // colore della pista
  noStroke();
  beginShape(QUAD_STRIP);
  for (float ang = 0; ang <= TWO_PI + 0.1; ang += 0.1) {
    float r1 = 3000;
    float r2 = 3500;
    float x1 = cos(ang) * r1;
    float z1 = sin(ang) * r1;
    float x2 = cos(ang) * r2;
    float z2 = sin(ang) * r2;
    vertex(x1, 0, z1);
    vertex(x2, 0, z2);
  }
  endShape();
  
    // Muri esterni
  float wallHeight = -100;
  fill(150);  // grigio chiaro muro
  beginShape(QUAD_STRIP);
  for (float ang = 0; ang <= TWO_PI + 0.1; ang += 0.1) {
    float r = 3500; // stesso del bordo esterno
    float x = cos(ang) * r;
    float z = sin(ang) * r;
    vertex(x, 0, z);               // base
    vertex(x, wallHeight, z);     // cima del muro
  }
  endShape();
  float wallHeight2 = -5;
  beginShape(QUAD_STRIP);
  for (float ang = 0; ang <= TWO_PI + 0.1; ang += 0.1) {
    float r = 3000; // stesso del bordo esterno
    float x = cos(ang) * r;
    float z = sin(ang) * r;
    vertex(x, 0, z);               // base
    vertex(x, wallHeight2, z);     // cima del muro
  }
  endShape();
  
  stroke(255);           // bianco
  strokeWeight(20);      // spessore visibile
  float r1 = 3000;
  float r2 = 3500;
  float x1 = cos(0) * r1;
  float z1 = sin(0) * r1;
  float x2 = cos(0) * r2;
  float z2 = sin(0) * r2;
  line(x1, 2, z1, x2, 2, z2);  
  popMatrix();
}

void terra() {
  pushMatrix();
  translate(0, 5, 0); // leggermente sotto la pista
  fill(30, 120, 30);   // verde erba
  noStroke();
  beginShape(QUADS);
  float dim = 10000;
  vertex(-dim, 0, -dim);
  vertex(dim, 0, -dim);
  vertex(dim, 0, dim);
  vertex(-dim, 0, dim);
  endShape();
  popMatrix();
}


void torreCentroPista(float x, float y, float z) {
  float w = 400;
  float h = 2300;
  float d = 400;
  
  pushMatrix();
  translate(x, y - h/2, z); // posiziona la torre centrata in altezza
  fill(60);
  noStroke();
  box(w, h, d);  // torre fisica

  String testo = "GIRO " + giroCorrente;
  textAlign(CENTER, CENTER);
  textSize(100); // più grande per una torre alta
  fill(255);

  float offsetY = -h/2 + 400;  // posizione verticale del testo (più in alto)

  // Lato frontale
  pushMatrix();
  translate(0, offsetY, d/2 + 1);
  rotateY(0);
  text(testo, 0, 0);
  popMatrix();

  // Lato destro
  pushMatrix();
  translate(w/2 + 1, offsetY, 0);
  rotateY(HALF_PI);
  text(testo, 0, 0);
  popMatrix();

  // Lato posteriore
  pushMatrix();
  translate(0, offsetY, -d/2 - 1);
  rotateY(PI);
  text(testo, 0, 0);
  popMatrix();

  // Lato sinistro
  pushMatrix();
  translate(-w/2 - 1, offsetY, 0);
  rotateY(-HALF_PI);
  text(testo, 0, 0);
  popMatrix();

  popMatrix();
}
