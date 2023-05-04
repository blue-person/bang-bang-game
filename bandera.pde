class Bandera extends Entidad {
  // Variables
  float resistencia;
  
  // Metodos
  Bandera(float pos_x, float pos_y, float resistencia, float mascara_colision) {
    super(pos_x, pos_y, mascara_colision);
    this.resistencia = resistencia;
  }
  
  void dibujar() {
    circle(pos_x, pos_y, mascara_colision);
  }
  
  void destruir() {
    rectMode(CENTER);
    rect(pos_x, pos_y, mascara_colision, mascara_colision);
  }
  
  void reducir_resistencia(float fuerza_impacto) {
    if (resistencia > 0) {
      resistencia -= fuerza_impacto;
    } else {
      this.destruir();
    }
  }
}
