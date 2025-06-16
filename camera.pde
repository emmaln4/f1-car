
void Camera() {
  PVector avanti = new PVector(sin(angoloMacchina), 0, cos(angoloMacchina));

  // Calcola la posizione dietro e in alto rispetto alla macchina
  float camX = posizioneMacchina.x - avanti.x * distanzaCamera;
  float camY = posizioneMacchina.y + sin(inclinazioneCamera) * distanzaCamera;
  float camZ = posizioneMacchina.z - avanti.z * distanzaCamera;

  camera(camX, camY, camZ,
         posizioneMacchina.x, posizioneMacchina.y, posizioneMacchina.z,
         0, 1, 0);
}
