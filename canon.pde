class Canon extends Entidad {
  // Variables
  float longitud, angulo_radianes;
  int direccion;
  
  // Animaciones
  Animacion animacion_base = new Animacion("base_canon", 1);
  Animacion animacion_canon;
  
  // Constructor
  Canon(float pos_x, float pos_y, float mascara_colision, int direccion, String animacion_canon) {
    super(pos_x, pos_y, mascara_colision);
    this.longitud = mascara_colision / 2;
    this.direccion = direccion;
    this.animacion_canon = new Animacion(animacion_canon, 1);
  }
  
  // Metodos
  void mostrar(float angulo) {
    // Variables
    angulo_radianes = direccion * radians(angulo);
    
    // Mostrar el canon
    pushMatrix();
    translate(pos_x + (direccion * 4), pos_y - 1);
    rotate(angulo_radianes);
    animacion_canon.mostrar(0, 0, direccion); 
    popMatrix();
    
    // Mostrar la base
    animacion_base.mostrar(pos_x + (direccion * 8), pos_y + 12);
  }
  
  FloatDict determinar_ubicacion_punta() {
    FloatDict ubicacion_punta = new FloatDict();
    ubicacion_punta.set("pos_x", pos_x + (-direccion * cos(angulo_radianes)) * longitud);
    ubicacion_punta.set("pos_y", pos_y + (-direccion * sin(angulo_radianes)) * longitud);
    return ubicacion_punta;
  }
}