class Bandera extends Entidad {
  // Variables
  float resistencia_actual;
  float resistencia_total;

  // Animaciones
  Animacion animacion_fuego = new Animacion("fuego", 22);
  Animacion animacion_explosion = new Animacion("explosion_intensa", 29);
  Animacion animacion_bandera;

  // Constructor
  Bandera(float pos_x, float pos_y, float resistencia, float mascara_colision, String animacion_bandera) {
    super(pos_x, pos_y, mascara_colision);
    this.resistencia_actual = resistencia;
    this.resistencia_total = resistencia;
    this.animacion_bandera = new Animacion(animacion_bandera, 18);
  }

  // Metodos
  void mostrar() {
    switch (estado_actual) {
    case "normal":
      animacion_bandera.mostrar(pos_x - 15, pos_y + 15, IZQUIERDA);
      break;
    case "impactado":
      animacion_bandera.mostrar(pos_x - 15, pos_y + 15, IZQUIERDA);
      animacion_fuego.mostrar(pos_x - 8, pos_y - 30);
      break;
    case "explotando":
      gestor_audio.reproducir_efecto_sonido("explosion_intensa");
      animacion_explosion.mostrar(pos_x, pos_y);
      break;
    }
  }

  void actualizar_estado() {
    // Determinar si aun le queda resistencia
    if (resistencia_actual <= 0) {
      destruir();
    }

    // Mostrar la entidad
    mostrar();
  }

  void destruir() {
    if (animacion_explosion.animacion_termino()) {
      estado_actual = "destruido";
    } else {
      estado_actual = "explotando";
    }
  }

  void reducir_resistencia(float fuerza_impacto) {
    if (resistencia_actual > 0) {
      estado_actual = "impactado";
      resistencia_actual -= fuerza_impacto;
    } else {
      destruir();
    }
  }

  String obtener_estado() {
    return estado_actual;
  }

  float obtener_resistencia() {
    return resistencia_actual;
  }

  String obtener_intensidad_batalla() {
    float porcentaje = resistencia_actual / resistencia_total;

    if (porcentaje >= 0.8 && porcentaje <= 1.0) {
      return "normal";
    } else if (porcentaje >= 0.5 && porcentaje < 0.8) {
      return "inestable";
    } else if (porcentaje < 0.5) {
      return "critico";
    } else {
      return "desconocido";
    }
  }
}
