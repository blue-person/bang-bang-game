class Canon extends Entidad {
  // Variables
  float angulo;
  
  // Metodos
  Canon(float pos_x, float pos_y, float angulo, float mascara_colision) {
    super(pos_x, pos_y, mascara_colision);
    this.angulo = angulo;
  }
  
  void mostrar() {
    circle(pos_x, pos_y, mascara_colision);
  }
}
