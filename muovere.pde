//void muovere() {

//PVector avanti = new PVector(sin(angoloMacchina), 0, cos(angoloMacchina));

//if (wkey) {
//  velocita += accelerazione;
//  if (velocita > maxVelocita) velocita = maxVelocita;
//} else if (skey) {
//  velocita -= frenata * 2;
//  if (velocita < -maxVelocita / 2) velocita = -maxVelocita / 2;
//} else {
//  // rallentamento naturale
//  if (velocita > 0) {
//    velocita -= frenata;
//    if (velocita < 0) velocita = 0;
//  } else if (velocita < 0) {
//    velocita += frenata;
//    if (velocita > 0) velocita = 0;
//  }
//}



//posizioneMacchina.add(avanti.copy().mult(velocita));

//if (akey) angoloMacchina += 0.03;
//if (dkey) angoloMacchina -= 0.03;

//}

void muovere() {
  PVector avanti = new PVector(sin(angoloMacchina), 0, cos(angoloMacchina));

  // gestione velocità
  if (wkey) {
    velocita += accelerazione;
    if (velocita > maxVelocita) velocita = maxVelocita;
  } else if (skey) {
    velocita -= frenata * 2;
    if (velocita < -maxVelocita / 2) velocita = -maxVelocita / 2;
  } else {
    // rallentamento naturale
    if (velocita > 0) {
      velocita -= frenata;
      if (velocita < 0) velocita = 0;
    } else if (velocita < 0) {
      velocita += frenata;
      if (velocita > 0) velocita = 0;
    }
  }

  // nuova posizione ipotetica
  PVector nuovaPosizione = posizioneMacchina.copy().add(avanti.copy().mult(velocita));

  // controlla se collide con muri
  boolean collisione = false;
  for (PVector muro : muri) {
    if (PVector.dist(nuovaPosizione, muro) < 100) {  // raggio collisione
      collisione = true;
      break;
    }
  }

  if (!collisione) {
    posizioneMacchina.set(nuovaPosizione);
  } else {
    velocita = 0; // si ferma se tocca il muro
  }

  // rotazione
  if (akey) angoloMacchina += 0.03;
  if (dkey) angoloMacchina -= 0.03;
}
