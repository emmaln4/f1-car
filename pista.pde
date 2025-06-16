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
  float wallHeight = -200;
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
void pista2() {
  pushMatrix();
  translate(0, 0, 0); // posizione della pista
  float width = 300; // larghezza pista
  float lineWidth = 3; // spessore linee bianche

  float[][] points = {
    {0, 0},
    {2000, -1000},
    {3000, -1100},
    {3500, -2000},
    {2500, -3000},
    {1500, -3250},
    {-1000, -3000},
    {-2000, -2500},
    {-1750, -1500},
    {-1000, -750},
    {0, 0}
  };

  // Disegno pista (asfalto)
  fill(60);
  noStroke();
  beginShape(QUAD_STRIP);
  PVector[] bordiEsterni = new PVector[points.length * 2];
  for (int i = 0; i < points.length; i++) {
    float x = points[i][0];
    float z = points[i][1];

    float nextX = 0;
    float nextZ = 1;
    if (i < points.length - 1) {
      nextX = points[i + 1][0] - x;
      nextZ = points[i + 1][1] - z;
    }

    float norm = sqrt(nextX * nextX + nextZ * nextZ);
    float dx = -nextZ / norm * width;
    float dz = nextX / norm * width;

    // Salvo i bordi per le linee dopo
    bordiEsterni[i * 2] = new PVector(x + dx, z + dz);     // lato destro
    bordiEsterni[i * 2 + 1] = new PVector(x - dx, z - dz); // lato sinistro

    vertex(x + dx, 0, z + dz);
    vertex(x - dx, 0, z - dz);
  }
  endShape();

  //// Disegno track limits (linee bianche)
  //stroke(255);
  //strokeWeight(lineWidth);
  //noFill();
  //beginShape();
  //for (int i = 0; i < bordiEsterni.length - 2; i += 2) {
  //  PVector v1 = bordiEsterni[i];
  //  PVector v2 = bordiEsterni[i + 2];
  //  line(v1.x, 1, v1.z, v2.x, 1, v2.z); // lato destro
  //}
  //for (int i = 1; i < bordiEsterni.length - 2; i += 2) {
  //  PVector v1 = bordiEsterni[i];
  //  PVector v2 = bordiEsterni[i + 2];
  //  line(v1.x, 1, v1.wdz, v2.x, 1, v2.z); // lato sinistro
  //}
  //endShape();

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
