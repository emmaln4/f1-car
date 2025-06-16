void macchina() {
  pushMatrix();
  translate(posizioneMacchina.x, posizioneMacchina.y + 100, posizioneMacchina.z);
  rotateY(angoloMacchina);
  lights();
  shape(modello);
  popMatrix();
  println(posizioneMacchina);
}
