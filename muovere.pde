void muovere() {
  if (wkey) {
    posizioneMacchina.x += sin(angoloMacchina) * 7;
    posizioneMacchina.z += cos(angoloMacchina) * 7;
  }
  if (skey) {
    posizioneMacchina.x -= sin(angoloMacchina) * 7;
    posizioneMacchina.z -= cos(angoloMacchina) * 7;
  }
  if (akey) {
    angoloMacchina += 0.03;
  }
  if (dkey) {
    angoloMacchina -= 0.03;
  }
}
