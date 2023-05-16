// Variables
int transparencia = 255;

// Funciones
boolean aclarar_pantalla(float velocidad) {
  if (transparencia >= 0) {
    transparencia -= (1 * velocidad);
  }
  
  transparencia = max(0, transparencia);
  
  fill(COLOR_BLANCO, transparencia);
  rect(0, 0, width, height);
  return (transparencia <= 0);
}

boolean oscurecer_pantalla(float velocidad) {
  if (transparencia <= 1) {
    transparencia += (1 * velocidad);
  }
  
  transparencia = min(1, transparencia);
  
  fill(COLOR_NEGRO, transparencia);
  rect(0, 0, width, height);
  return (transparencia >= 1);
}

float opacidad_objeto = 0;
boolean mostrar_gradualmente(float velocidad) {
  if (opacidad_objeto < 255) {
    opacidad_objeto += velocidad;
  }
  tint(255, opacidad_objeto);
  return (opacidad_objeto >= 255);
}

float transparencia_objeto = 255;
boolean ocultar_gradualmente(float velocidad) {
  if (transparencia_objeto > 0) {
    transparencia_objeto -= velocidad;
  }
  tint(255, transparencia_objeto);
  return (transparencia_objeto <= 0);
}

void reproducir_audio(String nombre_elemento) {
  AudioPlayer archivo_sonido = audios.get(nombre_elemento);
  archivo_sonido.play();
}

void reproducir_cancion(String nombre_elemento) {
  AudioPlayer archivo_sonido = audios.get(nombre_elemento);
 
  if (!archivo_sonido.isPlaying()) {
    archivo_sonido.loop();
  }
}

void detener_audio(String nombre_elemento) {
  AudioPlayer archivo_sonido = audios.get(nombre_elemento);
  
  if (archivo_sonido.isPlaying()) {
    archivo_sonido.close();
  }
}

void mostrar_mensaje_inicio() {
  fill(COLOR_NEGRO);
  textAlign(CENTER);
  text("Presiona Enter para continuar", width / 2, height / 2);
}

void mostrar_mensaje_resultados(String ganador) {
  fill(COLOR_NEGRO);
  textAlign(CENTER);
  text("El ganador fue: " + ganador, width / 2, height / 2);
}
