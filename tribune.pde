void tribunaTuttoAttorno(float raggioBase, float altezzaBase, int strati, int postiPerStrato) {
  float spacingRadiale = 25;
  float angoloInizio = 0;
  float angoloFine = TWO_PI;

  for (int i = 0; i < strati; i++) {
    float r = raggioBase + i * spacingRadiale;
    for (int j = 0; j < postiPerStrato; j++) {
      float t = map(j, 0, postiPerStrato - 1, angoloInizio, angoloFine);
      float x = cos(t) * r;
      float z = sin(t) * r;
      float y = altezzaBase - i * 15;

      // orientato verso il centro (0, 0)
      float angoloVersoCentro = atan2(-z, -x);

      int[] colori = {
        color(255, 0, 0), color(0, 0, 255), color(0, 200, 0),
        color(255, 255, 0), color(255, 100, 0), color(255)
      };
      fill(colori[int(random(colori.length))]);
      noStroke();
      pushMatrix();
      translate(x, y, z);
      rotateY(angoloVersoCentro);
      box(10, 10, 10);
      popMatrix();
    }
  }
}
