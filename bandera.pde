class Bandera extends Entidad {
  // Variables
  float resistencia;
  
  // Animaciones
  Animacion animacion_explosion = new Animacion("explosion_intensa", 30);
  
   // Constructor
  Bandera(float pos_x, float pos_y, float resistencia, float mascara_colision) {
    super(pos_x, pos_y, mascara_colision);
    this.resistencia = resistencia;
  }
  
  // Metodos
  void mostrar() {
    imageMode(CENTER);
    switch(estado_actual) {
      case "normal":
        circle(pos_x, pos_y, mascara_colision);
        break;
      case "impactado":
        circle(pos_x, pos_y, mascara_colision);
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
