void muovere() {
  PVector avanti = new PVector(sin(angoloMacchina), 0, cos(angoloMacchina));

  if (wkey) {
    velocita += accelerazione;
    if (velocita > maxVelocita) velocita = maxVelocita;
  } else if (skey) {
    velocita -= frenata * 2;
    if (velocita < -maxVelocita / 2) velocita = -maxVelocita / 2;
  } else {
    if (velocita > 0) {
      velocita -= frenata;
      if (velocita < 0) velocita = 0;
    } else if (velocita < 0) {
      velocita += frenata;
      if (velocita > 0) velocita = 0;
    }
  }

  PVector nuovaPosizione = posizioneMacchina.copy().add(avanti.copy().mult(velocita));

  // COLLISIONE SEMPLICE: se dentro i limiti della pista
  float distanzaDalCentro = dist(0, 0, nuovaPosizione.x, nuovaPosizione.z);
  if (distanzaDalCentro > 3025 && distanzaDalCentro < 3470) {
    posizioneMacchina.set(nuovaPosizione);
  } else {
    velocita = 0;
  }

  if (akey) angoloMacchina += 0.03;
  if (dkey) angoloMacchina -= 0.03;
}
