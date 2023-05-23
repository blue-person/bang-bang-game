class Colision {
  // Constructor
  Colision() {}

  // Metodos
  boolean circulo_con_circulo(float pos_x_1, float pos_y_1, float radio_1, float pos_x_2, float pos_y_2, float radio_2) {
    // Obtener distancias
    float distancia_x = pos_x_2 - pos_x_1;
    float distancia_y = pos_y_2 - pos_y_1;
    float radio_colision = (radio_1 + radio_2) / 2;
    
    // Verificar colision
    return pow(distancia_x, 2) + pow(distancia_y, 2) < pow(radio_colision, 2);
  }
  
  boolean circulo_con_punto(float pos_x_punto, float pos_y_punto, float pos_x_circulo, float pos_y_circulo, float radio_circulo ) {
    // Obtener distancias
    float distancia_x = pos_x_punto - pos_x_circulo;
    float distancia_y = pos_y_punto - pos_y_circulo;
    float distancia_total = sqrt(pow(distancia_x, 2) + pow(distancia_y, 2));
    
    // Verificar colision
    return distancia_total <= radio_circulo;
  }
  
  boolean circulo_con_linea(float pos_x_linea_1, float pos_y_linea_1, float pos_x_linea_2, float pos_y_linea_2, float pos_x_circulo, float pos_y_circulo, float radio_circulo) {
    // Verificar si el circulo esta dentro de la linea
    boolean colision_linea_1 = circulo_con_punto(pos_x_linea_1, pos_y_linea_1, pos_x_circulo, pos_y_circulo, radio_circulo);
    boolean colision_linea_2 = circulo_con_punto(pos_x_linea_2, pos_y_linea_2, pos_x_circulo, pos_y_circulo, radio_circulo);
    if (colision_linea_1 || colision_linea_2) {
      return true;
    }
    
    // Obtener longitud de la linea
    float distancia_x = pos_x_linea_1 - pos_x_linea_2;
    float distancia_y = pos_y_linea_1 - pos_y_linea_2;
    float longitud_linea = sqrt(pow(distancia_x, 2) + pow(distancia_y, 2));
    
    // Obtener el producto punto de la linea y el circulo
    float numerador = ((pos_x_circulo - pos_x_linea_1) * (pos_x_linea_2 - pos_x_linea_1)) + ((pos_y_circulo - pos_y_linea_1) * (pos_y_linea_2 - pos_y_linea_1));
    float denominador = pow(longitud_linea, 2);
    float producto_punto = numerador / denominador;
    
    // Obtener el punto mas cercano con la linea
    float pos_x_cercana = pos_x_linea_1 + (producto_punto * (pos_x_linea_2 - pos_x_linea_1));
    float pos_y_cercana = pos_y_linea_1 + (producto_punto * (pos_y_linea_2 - pos_y_linea_1));
    
    // Verificar si el punto NO esta en la linea
    boolean circulo_en_segmento = linea_con_punto(pos_x_linea_1, pos_y_linea_1, pos_x_linea_2, pos_y_linea_2, pos_x_cercana, pos_y_cercana);
    if (!circulo_en_segmento) {
      return false;
    }
    
    // Obtener la distancia al punto mas cercano
    distancia_x = pos_x_cercana - pos_x_circulo;
    distancia_y = pos_y_cercana - pos_y_circulo;
    float distancia_punto_cercano = sqrt(pow(distancia_x, 2) + pow(distancia_y, 2));
    
    // Verficiar colision
    return distancia_punto_cercano <= radio_circulo;
  }
  
  boolean linea_con_punto(float pos_x_linea_1, float pos_y_linea_1, float pos_x_linea_2, float pos_y_linea_2, float pos_x_punto, float pos_y_punto) {
    // Obtener distancia del punto a la linea
    float distancia_inicio_linea = dist(pos_x_punto, pos_y_punto, pos_x_linea_1, pos_y_linea_1);
    float distancia_final_linea = dist(pos_x_punto, pos_y_punto, pos_x_linea_2, pos_y_linea_2);
    float distancia_linea = distancia_inicio_linea + distancia_final_linea;
    
    // Obtener longitud de la linea
    float longitud_linea = dist(pos_x_linea_1, pos_y_linea_1, pos_x_linea_2, pos_y_linea_2);
    
    // Agregar un valor de error
    float error = 0.1;
    
    // Verificar colision
    boolean primera_verificacion = distancia_linea >= (longitud_linea - error);
    boolean segunda_verificacion = distancia_linea <= (longitud_linea + error);
    return primera_verificacion && segunda_verificacion;
  }
  
  boolean circulo_con_poligono(float pos_x_circulo, float pos_y_circulo, float radio_circulo, PVector[] vertices_poligono) {
    int siguiente_vertice = 0;
    for (int vertice_actual = 0; vertice_actual < vertices_poligono.length; vertice_actual++) {
      // Verificar si se llego al ultimo vertice
      siguiente_vertice = vertice_actual + 1;
      if (siguiente_vertice ==  vertices_poligono.length) {
        siguiente_vertice = 0;
      }
      
      // Saber que vertices estan en la posicion del circulo
      PVector vertice_cercano_actual = vertices_poligono[vertice_actual];
      float pos_x_vertice_actual = vertice_cercano_actual.x;
      float pos_y_vertice_actual = vertice_cercano_actual.y;
      
      PVector vertice_cercano_siguiente = vertices_poligono[siguiente_vertice];
      float pos_x_vertice_siguiente = vertice_cercano_siguiente.x;
      float pos_y_vertice_siguiente = vertice_cercano_siguiente.y;
      
      // Verificar la colision
      boolean colision_con_linea = circulo_con_linea(pos_x_vertice_actual, pos_y_vertice_actual, pos_x_vertice_siguiente, pos_y_vertice_siguiente, pos_x_circulo, pos_y_circulo, radio_circulo);
      if (colision_con_linea) {
        return true;
      }
    }
    return false;
  }
}
