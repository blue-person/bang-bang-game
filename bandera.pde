class Bandera extends Entidad {
  // Variables
  float resistencia;
  
  // Animaciones
  Animacion animacion_fuego = new Animacion("fuego", 10);
  Animacion animacion_explosion = new Animacion("explosion_intensa", 29);
  Animacion animacion_bandera;
  
   // Constructor
  Bandera(float pos_x, float pos_y, float resistencia, float mascara_colision, String animacion_bandera) {
    super(pos_x, pos_y, mascara_colision);
    this.resistencia = resistencia;
    this.animacion_bandera = new Animacion(animacion_bandera, 6);
  }
  
  // Metodos
  void mostrar() {
    circle(pos_x, pos_y, mascara_colision);
    switch(estado_actual) {
      case "normal":
        animacion_bandera.mostrar(pos_x, pos_y);
        break;
      case "impactado":
        animacion_bandera.mostrar(pos_x, pos_y);
        animacion_fuego.mostrar(pos_x - 3, pos_y - 25);
        break;
      case "explotando":
        animacion_explosion.mostrar(pos_x, pos_y);
        break;
    }
  }
  
  void actualizar_estado() {
    // Determinar si aun le queda resistencia
    if (resistencia <= 0) {
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
    if (resistencia > 0) {
      estado_actual = "impactado";
      resistencia -= fuerza_impacto;
    } else {
      destruir();
    }
  }
  
  String obtener_estado() {
    return estado_actual;
  }
  
  float obtener_resistencia() {
    return resistencia;
  }
}
