// Efectos de textos
class Efecto {
  // Constructor
  Efecto() {}
  
  // Metodos
  void imagen_pulsante(PImage imagen, float pos_x, float pos_y, float escala_minima, float escala_maxima) {
    float pulso = sin(frameCount * velocidad_pulso);
    factor_aumento = map(pulso, -1, 1, escala_minima, escala_maxima);
    float escala_vertical = (1 - factor_aumento) * 0.5 * pos_y;
    imageMode(CENTER);
    pushMatrix();
    translate(pos_x, pos_y + escala_vertical);
    scale(factor_aumento);
    image(imagen, 0, 0);
    popMatrix();
  }
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
