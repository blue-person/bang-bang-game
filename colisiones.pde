class Colision {
  // Constructor
  Colision() {}

  // Metodos
  boolean circulo_con_circulo(float pos_x_1, float pos_y_1, float radio_1, float pos_x_2, float pos_y_2, float radio_2) {
    // Obtener distancias
    float distancia_horizontal = pow(pos_x_2 - pos_x_1, 2);
    float distancia_vertical = pow(pos_y_2 - pos_y_1, 2);
    float radio_colision = (radio_1 + radio_2) / 2;
    
    // Verificar colision
    return (distancia_horizontal + distancia_vertical) < pow(radio_colision, 2);
  }
  
  boolean circulo_con_rectangulo(float pos_x_circulo, float pos_y_circulo, float radio, float pos_x_rectangulo, float pos_y_rectangulo, float ancho_rectangulo, float altura_rectangulo) {
    // Variables temporales para determinar la esquina cercana
    float pos_x_esquina_cercana = pos_x_circulo;
    float pos_y_esquina_cercana = pos_y_circulo;
    
    // Determinar cual es realmente la mas cercana
    if (pos_x_circulo < pos_x_rectangulo) {
      pos_x_esquina_cercana = pos_x_rectangulo;
    } else if (pos_x_circulo > pos_x_rectangulo + ancho_rectangulo) {
      pos_x_esquina_cercana = pos_x_rectangulo + ancho_rectangulo;
    }

    if (pos_y_circulo < pos_y_rectangulo) {
      pos_y_esquina_cercana = pos_y_rectangulo;
    } else if (pos_y_circulo > pos_y_rectangulo + altura_rectangulo) {
      pos_y_esquina_cercana = pos_y_rectangulo + altura_rectangulo;
    }
    
    // Obtener distancias
    float distancia_horizontal = pow(pos_x_circulo - pos_x_esquina_cercana, 2);
    float distancia_vertical = pow(pos_y_circulo - pos_y_esquina_cercana, 2);
 
    // Verificar colision
    return (distancia_horizontal + distancia_vertical) < pow(radio, 2);
  }
}
