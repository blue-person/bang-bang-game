class Proyectil extends Entidad {
  float pos_x_inicial, pos_y_inicial, pos_x_posterior, pos_y_posterior;
  float direccion, velocidad, angulo, velocidad_x, velocidad_y, tiempo_aire;
  final float MASA = 0.85;
  final float GRAVEDAD = 9.81;
  
  Proyectil(float pos_x, float pos_y, float direccion, float angulo, float velocidad, float mascara_colision) {
    super(pos_x, pos_y, mascara_colision);
    
    this.direccion = direccion;
    this.pos_x_inicial = pos_x;
    this.pos_y_inicial = pos_y;
    this.pos_x_posterior = 0;
    this.pos_y_posterior = 0;
    this.velocidad = velocidad;
    this.angulo = radians(angulo);
  }
  
  void dibujar() {
    circle(pos_x, pos_y, mascara_colision);
  }
  
  void mover() {
    // Calcular la velocidad
    velocidad_x = velocidad * cos(angulo);
    velocidad_y = velocidad * sin(angulo);
    
    // Calcular la nueva posicion
    pos_x_posterior = velocidad_x * tiempo_aire;
    pos_y_posterior = -((velocidad_y * tiempo_aire) - (GRAVEDAD / 2 * sq(tiempo_aire)));
    tiempo_aire += (1 / frameRate) * 5;
    
    // Reajustar la posicion
    pos_x = pos_x_inicial + (direccion * pos_x_posterior);
    pos_y = pos_y_inicial + pos_y_posterior;
  }
  
  void destruir() {
    rectMode(CENTER);
    rect(pos_x, pos_y, mascara_colision, mascara_colision);
  }
  
  float determinar_fuerza_impacto() {
    float aceleracion_vertical = velocidad_y / tiempo_aire;
    return MASA * aceleracion_vertical;
  }
}
