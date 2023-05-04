Boolean colision_circular(float pos_x_1, float pos_y_1, float radio_1, float pos_x_2, float pos_y_2, float radio_2) {
  float distancia_x = pos_x_2 - pos_x_1;
  float distancia_y = pos_y_2 - pos_y_1;
  float radio_colision = (radio_1 + radio_2) / 2;
  
  return pow(distancia_x, 2) + pow(distancia_y, 2) < pow(radio_colision, 2);
}
