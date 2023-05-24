class Proyectil extends Entidad {
  // Constantes
  final float MASA = 0.85;
  final float GRAVEDAD = 9.81;

  // Variables
  float pos_x_inicial, pos_y_inicial, pos_x_posterior, pos_y_posterior;
  float direccion, velocidad, angulo, velocidad_horizontal, velocidad_vertical, tiempo_aire;

  // Animaciones
  Animacion animacion_normal = new Animacion("proyectil", 1);
  Animacion animacion_explosion = new Animacion("explosion_normal", 40);

  // Constructor
  Proyectil(float pos_x, float pos_y, float direccion, float angulo, float velocidad, float mascara_colision) {
    super(pos_x, pos_y, mascara_colision);
    this.direccion = direccion;
    this.velocidad = velocidad;
    this.angulo = radians(angulo);
    this.pos_x_inicial = pos_x;
    this.pos_y_inicial = pos_y;
    this.pos_x_posterior = 0;
    this.pos_y_posterior = 0;
  }

  // Metodos
  void mostrar() {
    switch (estado_actual) {
    case "normal":
      animacion_normal.mostrar(pos_x, pos_y);
      break;
    case "moviendose":
      animacion_normal.mostrar(pos_x, pos_y);
      break;
    case "explotando":
      gestor_audio.reproducir_efecto_sonido("explosion_normal");
      animacion_explosion.mostrar(pos_x, pos_y);
      break;
    }
  }

  void mover() {
    // Calcular la velocidad
    velocidad_horizontal = velocidad * cos(angulo);
    velocidad_vertical = velocidad * sin(angulo);

    // Calcular la nueva posicion
    pos_x_posterior = velocidad_horizontal * tiempo_aire;
    pos_y_posterior = -((velocidad_vertical * tiempo_aire) - (GRAVEDAD / 2 * sq(tiempo_aire)));
    tiempo_aire += (1 / frameRate) * 5;

    // Reajustar la posicion
    pos_x = pos_x_inicial + (direccion * pos_x_posterior);
    pos_y = pos_y_inicial + pos_y_posterior;
    
    // Determinar si esta fuera de los limites
    boolean proyectil_fuera_limite_horizontal = (pos_x < -50) || (pos_x > width + 50);
    boolean proyectil_fuera_limite_vertical = (pos_y < -50) || (pos_y > height);
    
    // Reajustar el estado
    if (proyectil_fuera_limite_horizontal || proyectil_fuera_limite_vertical) {
      destruir();
    } else {
      estado_actual = "moviendose";
    }
  }

  void actualizar_estado() {
    // Variables
    boolean proyectil_explotando = estado_actual.equals("explotando");
    boolean proyectil_destruido = estado_actual.equals("destruido");

    // Comprobacion de estados
    if (!proyectil_explotando && !proyectil_destruido) {
      mover();
    } else if (proyectil_explotando) {
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

  void determinar_impacto(Bandera bandera) {
    // Variables
    String estado_actual = obtener_estado();
    boolean proyectil_moviendose = estado_actual.equals("moviendose");
    boolean proyectil_colisiono = verificar_colision(bandera);
    
    if (proyectil_moviendose && proyectil_colisiono) {
      // Gestionar el impacto a la bandera
      float fuerza_impacto = determinar_fuerza_impacto();
      bandera.reducir_resistencia(fuerza_impacto);

      // Destruir el proyectil
      destruir();
    }
  }

  String obtener_estado() {
    return estado_actual;
  }

  float determinar_fuerza_impacto() {
    float aceleracion_vertical = velocidad_vertical / tiempo_aire;
    return MASA * aceleracion_vertical;
  }
}
