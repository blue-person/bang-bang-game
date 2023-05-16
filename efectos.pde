// Variables iniciales
float opacidad_fade_in = 0;
float opacidad_fade_out = 255;

// Funciones
void reiniciar_valores_opacidad() {
  opacidad_fade_in = 0;
  opacidad_fade_out = 255;
}

boolean efecto_fade_in(String tipo_elemento, int color_transicion, float velocidad) {
  // Cambiar opacidad
  if (opacidad_fade_in < 255) {
    opacidad_fade_in += velocidad;
  }
  
  // Determinar elemento
  switch(tipo_elemento) {
    case "imagen":
      tint(color_transicion, opacidad_fade_in);
      break;
    case "figura":
      fill(color_transicion, opacidad_fade_in);
      break;
  }
  
  // Determinar si ya acabo la transicion
  return (opacidad_fade_in >= 255);
}

boolean efecto_fade_out(String tipo_elemento, int color_transicion, float velocidad) {
  // Cambiar opacidad
  if (opacidad_fade_out > 0) {
    opacidad_fade_out -= velocidad;
  }
  
  // Determinar elemento
  switch(tipo_elemento) {
    case "imagen":
      tint(color_transicion, opacidad_fade_out);
      break;
    case "figura":
      fill(color_transicion, opacidad_fade_out);
      break;
  }
  
  // Determinar si ya acabo la transicion
  return (opacidad_fade_out <= 0);
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

void mostrar_mensaje_inicio(float opacidad) {
  fill(COLOR_NEGRO, opacidad);
  textAlign(CENTER);
  text("Presiona Enter para continuar", width / 2, height / 2);
}

void mostrar_mensaje_resultados(String ganador, float opacidad) {
  fill(COLOR_NEGRO, opacidad);
  textAlign(CENTER);
  text("El ganador fue: " + ganador, width / 2, height / 2);
}
