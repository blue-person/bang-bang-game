abstract class Entidad {
  // Clases
  Colision gestor_colisiones = new Colision();

  // Variables
  float pos_x, pos_y, pos_x_actual, pos_y_actual, mascara_colision;
  String estado_actual = "normal";

  // Constructor
  Entidad(float pos_x, float pos_y, float mascara_colision) {
    this.pos_x = pos_x;
    this.pos_y = pos_y;
    this.mascara_colision = mascara_colision;
  }

  // Metodos
  boolean verificar_colision_con_entidad(Entidad entidad) {
    return gestor_colisiones.circulo_con_circulo(this.pos_x, this.pos_y, this.mascara_colision, entidad.pos_x, entidad.pos_y, entidad.mascara_colision);
  }
  
  boolean verificar_colision_con_muralla(float pos_x_rectangulo, float pos_y_rectangulo, float ancho_rectangulo, float altura_rectangulo) {
    return gestor_colisiones.circulo_con_rectangulo(this.pos_x, this.pos_y, this.mascara_colision, pos_x_rectangulo, pos_y_rectangulo, ancho_rectangulo, altura_rectangulo);
  }
}
