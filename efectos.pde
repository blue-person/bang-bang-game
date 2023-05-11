// Variables
int transparencia = 255;

// Funciones
boolean aclarar_pantalla(int color_hexadecimal, float velocidad) {
  if (transparencia <= 255) {
    transparencia -= (1 * velocidad);
  }
  
  fill(color_hexadecimal, transparencia);
  rect(0, 0, width, height);
  return (transparencia <= 0);
}

boolean oscurecer_pantalla(int color_hexadecimal, float velocidad) {
  if (transparencia >= 0) {
    transparencia += (1 * velocidad);
  }
  
  fill(color_hexadecimal, transparencia);
  rect(0, 0, width, height);
  return (transparencia >= 255);
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
