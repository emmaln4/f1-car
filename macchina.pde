void macchina() {
  pushMatrix();
  translate(posizioneMacchina.x, posizioneMacchina.y, posizioneMacchina.z);
  rotateY(angoloMacchina);
  lights();
  shape(modello);
  popMatrix();
}
