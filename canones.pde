class Canon extends Entidad {
  // Variables
  float longitud, angulo_radianes, pos_x_punta, pos_y_punta;
  int direccion;

  // Animaciones
  Animacion animacion_base = new Animacion("base_canon", 1);
  Animacion animacion_explosion = new Animacion("explosion_suave", 12);
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
    pos_x_punta = pos_x + (-direccion * cos(angulo_radianes)) * longitud;
    pos_y_punta = pos_y + (-direccion * sin(angulo_radianes)) * longitud;

    // Mostrar el canon
    pushMatrix();
    translate(pos_x + (direccion * 4), pos_y - 1);
    rotate(angulo_radianes);
    animacion_canon.mostrar(0, 0, direccion);
    popMatrix();

    // Mostrar la base
    animacion_base.mostrar(pos_x + (direccion * 8), pos_y + 12);

    if (estado_actual.equals("disparando")) {
      animacion_explosion.mostrar(pos_x_punta, pos_y_punta);
      gestor_audio.reproducir_efecto_sonido("disparo");
    }

    if (animacion_explosion.animacion_termino()) {
      estado_actual = "normal";
    }
  }

  FloatDict obtener_ubicacion_punta() {
    // Variables
    FloatDict ubicacion_punta = new FloatDict();

    // Guardar posiciones
    ubicacion_punta.set("pos_x", pos_x_punta);
    ubicacion_punta.set("pos_y", pos_y_punta);

    estado_actual = "disparando";

    return ubicacion_punta;
  }
}
