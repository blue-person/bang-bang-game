// Efectos de textos
class Efecto {
  // Constructor
  Efecto() {}
  
  // Metodos
  void imagen_pulsante(PImage imagen, float pos_x, float pos_y, float escala_minima, float escala_maxima) {
    float pulso = sin(frameCount * velocidad_pulso);
    factor_aumento = map(pulso, -1, 1, escala_minima, escala_maxima);
    float escala_vertical = (1 - factor_aumento) * 0.5 * pos_y;
    pushMatrix();
    translate(pos_x, pos_y + escala_vertical);
    scale(factor_aumento);
    image(imagen, 0, 0);
    popMatrix(); 
  }
  
  void fondo_degradado(int color_a, int color_b) {
    push();
    for (int pos_y = 0; pos_y < height; pos_y++) {
      float interseccion = map(pos_y, 0, height, 1, 0);
      color color_degradado = lerpColor(color_a, color_b, interseccion);
      stroke(color_degradado);
      line(0, pos_y, width, pos_y);
    }
    pop();
  }
  
  void imagen_infinita(PImage imagen, float pos_y, float velocidad) {
    int desplazamiento = int(frameCount * velocidad) % imagen.width;
    for (int pos_x = -desplazamiento; pos_x < width; pos_x += imagen.width) {
      image(imagen, pos_x, pos_y);
    }
  }
}

// Efecto de fade-in
class FadeIn {
  // Variables
  int color_transicion;
  float velocidad;
  float opacidad = 0;

  // Constructor
  FadeIn(int color_transicion, float velocidad) {
    this.color_transicion = color_transicion;
    this.velocidad = velocidad;
  }

  // Metodos
  void mostrar() {
    // Cambiar opacidad
    if (opacidad < 255) {
      opacidad += velocidad;
    }
    
    // Mostrar efecto
    push();
    rectMode(CORNER);
    fill(color_transicion, opacidad);
    rect(0, 0, width, height);
    pop();
  }
  
  void mostrar(PImage imagen, float pos_x, float pos_y, int escala_horizontal) {
    // Cambiar opacidad
    if (opacidad < 255) {
      opacidad += velocidad;
    }
    
    // Mostrar efecto
    push();
    imageMode(CENTER);
    tint(255, opacidad);
    imagen.resize(escala_horizontal, 0);
    image(imagen, pos_x, pos_y);
    pop();
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
  int color_transicion;
  float velocidad;
  float opacidad = 255;

  // Constructor
  FadeOut(int color_transicion, float velocidad) {
    this.color_transicion = color_transicion;
    this.velocidad = velocidad;
  }

  // Metodos
  void mostrar() {
    // Cambiar opacidad
    if (opacidad > 0) {
      opacidad -= velocidad;
    }

    // Mostrar efecto
    push();
    rectMode(CORNER);
    fill(color_transicion, opacidad);
    rect(0, 0, width, height);
    pop();
  }
  
  void mostrar(PImage imagen, float pos_x, float pos_y, int escala_horizontal) {
    // Cambiar opacidad
    if (opacidad > 0) {
      opacidad -= velocidad;
    }
    
    // Mostrar efecto
    push();
    imageMode(CENTER);
    tint(255, opacidad);
    imagen.resize(escala_horizontal, 0);
    image(imagen, pos_x, pos_y);
    pop();
  }

  boolean efecto_terminado() {
    return (opacidad <= 0);
  }

  float obtener_opacidad() {
    return this.opacidad;
  }
}
