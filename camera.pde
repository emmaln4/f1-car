//void Camera() {
//  PVector avanti = new PVector(sin(angoloMacchina), 0, cos(angoloMacchina));
//  PVector desiredCamPos = PVector.add(posizioneMacchina, new PVector(0, 500, 0).sub(avanti.mult(300))); // dietro e in alto
//  PVector desiredTarget = PVector.add(posizioneMacchina, avanti.mult(0)); 

//  // Interpolazione fluida verso la posizione desiderata
//  //posizioneCamera.lerp(desiredCamPos, 0.1);
//  //targetCamera.lerp(desiredTarget, 0.1);

//  camera(posizioneCamera.x, posizioneCamera.y, posizioneCamera.z,
//    targetCamera.x, targetCamera.y, targetCamera.z,
//    0, 1, 0);
//}

void Camera() {
  PVector avanti = new PVector(sin(angoloMacchina), 0, cos(angoloMacchina));
  
  float altezzaCamera = 10;      // più alto della macchina
  float distanzaDietro = 25;     // dietro la macchina

  PVector camPos = PVector.add(posizioneMacchina, new PVector(0, altezzaCamera, 0).sub(avanti.mult(distanzaDietro)));
  PVector camTarget = PVector.add(posizioneMacchina, avanti.mult(10));

  camera(camPos.x, camPos.y, camPos.z,
         camTarget.x, camTarget.y, camTarget.z,
         0, 1, 0);
}
