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

// Efecto de fade-in
class FadeIn {
  // Variables
  String tipo_elemento;
  int color_transicion;
  float velocidad;
  float opacidad = 0;

  // Constructor
  FadeIn(String tipo_elemento, int color_transicion, float velocidad) {
    this.tipo_elemento = tipo_elemento;
    this.color_transicion = color_transicion;
    this.velocidad = velocidad;
  }

  // Metodos
  void mostrar() {
    // Cambiar opacidad
    if (opacidad < 255) {
      opacidad += velocidad;
    }

    // Determinar elemento
    switch (tipo_elemento) {
    case "imagen":
      tint(color_transicion, opacidad);
      break;
    case "figura":
      fill(color_transicion, opacidad);
      break;
    }
  }

  boolean efecto_terminado() {
    return (opacidad >= 255);
  }

  float obtener_opacidad() {
    return this.opacidad;
  }
}

// Efecto de fade-out
class FadeOut {
  // Variables
  String tipo_elemento;
  int color_transicion;
  float velocidad;
  float opacidad = 255;

  // Constructor
  FadeOut(String tipo_elemento, int color_transicion, float velocidad) {
    this.tipo_elemento = tipo_elemento;
    this.color_transicion = color_transicion;
    this.velocidad = velocidad;
  }

  // Metodos
  void mostrar() {
    // Cambiar opacidad
    if (opacidad > 0) {
      opacidad -= velocidad;
    }

    // Determinar elemento
    switch (tipo_elemento) {
    case "imagen":
      tint(color_transicion, opacidad);
      break;
    case "figura":
      fill(color_transicion, opacidad);
      break;
    }
  }

  boolean efecto_terminado() {
    return (opacidad <= 0);
  }

  float obtener_opacidad() {
    return this.opacidad;
  }
}
