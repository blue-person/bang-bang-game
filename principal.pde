// Librerias
import processing.serial.*;

// Funciones
void setup() {
  // Constantes
  final String TITULO_JUEGO = "Bang! Bang!";
  final int CENTRO_HORIZONTAL = (displayWidth / 2) - (width / 2);
  final int CENTRO_VERTICAL = (displayHeight / 2) - (height / 2);

  // Configuracion de la ventana
  surface.setTitle(TITULO_JUEGO);
  surface.setLocation(CENTRO_HORIZONTAL, CENTRO_VERTICAL);
  size(1280, 720);

  // Configuracion del proyecto
  frameRate(60);

  // Pre-cargar elementos
  gestor_audio.cargar_efectos_sonido();
  gestor_audio.cargar_canciones();
  gestor_imagenes.cargar_imagenes();
  
  // Cargar elementos
  inicializar_efectos();
  inicializar_conexion_serial();
}

void draw() {
  // Configuraciones esenciales
  noTint();
  
  // Declaracion de imagenes
  PImage logo_universidad = imagenes.get("logo_universidad_0");
  PImage logo_juego = imagenes.get("logo_juego_0");
  PImage nubes = imagenes.get("nubes_0");
  PImage monte_a = imagenes.get("monte_a_0");
  PImage monte_b = imagenes.get("monte_b_0");
  PImage monte_c = imagenes.get("monte_c_0");

  // Determinar estado
  switch (estado_actual_juego) {
  case "presentacion":
    // Aplicar el fondo
    background(COLOR_BLANCO);
    
    // Mostrar el logo de la universidad
    push();
    imageMode(CENTER);
    logo_universidad.resize(250, 0);
    image(logo_universidad, width / 2, height / 2);
    pop();
    
    // Aparecer gradualmente
    mostrar_logo.mostrar();
    if (mostrar_logo.efecto_terminado()) {
      if (permitir_espera_presentacion) {
        permitir_espera_presentacion = false;
        delay(500);
      }
      ocultar_logo.mostrar();
    }

    // Desvanecer gradualmente
    if (ocultar_logo.efecto_terminado()) {
      delay(250);
      estado_actual_juego = "menu";
    }

    break;
  case "menu":
    // Mostrar el cielo
    gestor_efectos.fondo_degradado(COLOR_AZUL_CLARO, COLOR_AZUL_OSCURO);

    // Mostrar los fondos
    push();
    imageMode(CORNER);
    tint(255, 255);
    gestor_efectos.imagen_infinita(monte_c, height / 1.65, 0.90);
    gestor_efectos.imagen_infinita(monte_b, height / 1.75, 0.75);
    gestor_efectos.imagen_infinita(monte_a, height / 1.50, 0.60);
    tint(255, 135);
    gestor_efectos.imagen_infinita(nubes, 35, 1.25);
    gestor_efectos.imagen_infinita(nubes, 195, 1.50);
    pop();

    // Mostrar un panel semi-transparente
    push();
    fill(COLOR_NEGRO, 135);
    rect(0, 0, width, height);
    pop();

    // Mostrar el logo
    push();
    imageMode(CENTER);
    logo_juego.resize(700, 0);
    gestor_efectos.imagen_pulsante(logo_juego, width / 2, height / 4, escala_minima, escala_maxima);
    pop();

    // Mostrar animacion para continuar
    textAlign(CENTER);
    text("Presiona el boton para continuar", width / 2, height / 1.5);

    // Determinar estado
    if (mostrar_inicio.efecto_terminado() && gestor_controles.boton_presionado()) {
      gestor_audio.reproducir_efecto_sonido("confirmar_opcion");
      permitir_transicion_juego = true;
    }

    // Realizar transicion
    if (permitir_transicion_juego) {
      // Determinar estado de los audios
      gestor_audio.detener_cancion("menu_inicio");

      // Efecto de fade-in
      ocultar_inicio.mostrar();
      if (ocultar_inicio.efecto_terminado()) {
        delay(100);

        inicializar_elementos();
        permitir_transicion_juego = false;
        estado_actual_juego = "juego";
      }
    } else {
      gestor_audio.reproducir_cancion("menu_inicio");
    }

    // Efecto de fade-out al iniciar el estado
    mostrar_inicio.mostrar();

    break;
  case "juego":
    // Mostrar el cielo
    gestor_efectos.fondo_degradado(COLOR_AZUL_CLARO, COLOR_AZUL_OSCURO);
    
    // Mostrar los fondos
    push();
    imageMode(CORNER);
    tint(255, 255);
    gestor_efectos.imagen_infinita(monte_c, height / 1.65, 0);
    gestor_efectos.imagen_infinita(monte_b, height / 1.75, 0);
    gestor_efectos.imagen_infinita(monte_a, height / 1.50, 0);
    tint(255, 135);
    gestor_efectos.imagen_infinita(nubes, 35, 1.25);
    gestor_efectos.imagen_infinita(nubes, 195, 1.50);
    pop();
    
    // Bandera A
    if (bandera_a != null) {
      String estado_bandera = bandera_a.obtener_estado();
      if (estado_bandera.equals("destruido")) {
        bandera_a = null;
      } else {
        bandera_a.actualizar_estado();
      }
    } else {
      ganador = JUGADOR_A;
    }

    // Bandera B
    if (bandera_b != null) {
      String estado_bandera = bandera_b.obtener_estado();
      if (estado_bandera.equals("destruido")) {
        bandera_b = null;
      } else {
        bandera_b.actualizar_estado();
      }
    } else {
      ganador = JUGADOR_B;
    }

    // Proyectil A
    if (proyectil_a != null) {
      String estado_proyectil = proyectil_a.obtener_estado();
      if (estado_proyectil.equals("destruido")) {
        proyectil_a = null;
      } else {
        if (bandera_b != null) {
          proyectil_a.determinar_impacto(bandera_b);
        }
        proyectil_a.actualizar_estado();
      }
    }

    // Proyectil B
    if (proyectil_b != null) {
      String estado_proyectil = proyectil_b.obtener_estado();
      if (estado_proyectil.equals("destruido")) {
        proyectil_b = null;
      } else {
        if (bandera_a != null) {
          proyectil_b.determinar_impacto(bandera_a);
        }
        proyectil_b.actualizar_estado();
      }
    }
    
    // Se actualiza el estado de los canones
    canon_a.mostrar(angulo_a);
    canon_b.mostrar(angulo_b);
    
    // Manejo de la musica mientras las banderas existan
    if (bandera_a != null && bandera_b != null) {
      boolean batalla_normal = bandera_a.obtener_intensidad_batalla() == "normal" || bandera_b.obtener_intensidad_batalla() == "normal";
      boolean batalla_acelerada = bandera_a.obtener_intensidad_batalla() == "inestable" || bandera_b.obtener_intensidad_batalla() == "inestable";
      boolean batalla_intensa = bandera_a.obtener_intensidad_batalla() == "critico" || bandera_b.obtener_intensidad_batalla() == "critico";

      if (batalla_normal) {
        gestor_audio.reproducion_solitaria_cancion("batalla_normal");
      } else if (batalla_acelerada) {
        gestor_audio.reproducion_solitaria_cancion("batalla_acelerada");
      } else if (batalla_intensa) {
        gestor_audio.reproducion_solitaria_cancion("batalla_intensa");
      }
    }
    
    // Logica mientras no haya jugador
    if (ganador == null) {
      boolean turno_jugador_a = jugador_actual.equals(JUGADOR_A);
      boolean turno_jugador_b = jugador_actual.equals(JUGADOR_B);
      boolean existe_proyectil_a = (proyectil_a != null);
      boolean existe_proyectil_b = (proyectil_b != null);
      boolean bandera_a_no_explotando = (bandera_a != null) && !bandera_a.obtener_estado().equals("explotando");
      boolean bandera_b_no_explotando = (bandera_b != null) && !bandera_b.obtener_estado().equals("explotando");
    
      if (turno_jugador_a) {
        if (existe_proyectil_a && proyectil_a.obtener_estado().equals("explotando")) {
          jugador_actual = JUGADOR_B;
        } else if (!existe_proyectil_a && bandera_a_no_explotando && bandera_b_no_explotando) {
          if (gestor_controles.boton_presionado()) {
            FloatDict ubicacion_punta_canon = canon_a.obtener_ubicacion_punta();
            float pos_x = ubicacion_punta_canon.get("pos_x");
            float pos_y = ubicacion_punta_canon.get("pos_y");
      
            proyectil_a = new Proyectil(pos_x, pos_y, DERECHA, angulo_a, velocidad_a, MASCARA_COLISION_PROYECTIL);
          } else {
            angulo_a = gestor_controles.obtener_valor_angulo();
            velocidad_a = gestor_controles.obtener_valor_velocidad();
          }
        }
      } else if (turno_jugador_b) {
        if (existe_proyectil_b && proyectil_b.obtener_estado().equals("explotando")) {
          jugador_actual = JUGADOR_A;
        } else if (!existe_proyectil_b && bandera_a_no_explotando && bandera_b_no_explotando) {
          if (gestor_controles.boton_presionado()) {
            FloatDict ubicacion_punta_canon = canon_b.obtener_ubicacion_punta();
            float pos_x = ubicacion_punta_canon.get("pos_x");
            float pos_y = ubicacion_punta_canon.get("pos_y");
            
            proyectil_b = new Proyectil(pos_x, pos_y, IZQUIERDA, angulo_b, velocidad_b, MASCARA_COLISION_PROYECTIL);
          } else {
            angulo_b = gestor_controles.obtener_valor_angulo();
            velocidad_b = gestor_controles.obtener_valor_velocidad();
          }
        }
      }
    } else {
      // Detener la musica
      gestor_audio.detener_canciones();
      
      // Mostrar el efecto fade-out
      acabar_partida.mostrar();
      if (acabar_partida.efecto_terminado()) {
        estado_actual_juego = "resultados";
      }
    }

    // Mostrar el efecto fade-out
    iniciar_partida.mostrar();

    break;
  case "resultados":
    // Aplicar el fondo
    background(COLOR_AZUL_CLARO);

    // Mostrar ganador
    push();
    fill(0, 255);
    textAlign(CENTER);
    pop();
    text("El ganador fue: " + ganador, width / 2, height / 2);
    
    // Determinar estado
    if (mostrar_resultados.efecto_terminado() && gestor_controles.boton_presionado()) {
      gestor_audio.reproducir_efecto_sonido("confirmar_opcion");
      permitir_transicion_juego = true;
    }

    // Realizar transicion
    if (permitir_transicion_juego) {
      // Determinar estado de los audios
      gestor_audio.detener_cancion("presentacion_resultados");

      // Efecto de fade-in
      ocultar_resultados.mostrar();
      if (ocultar_resultados.efecto_terminado()) {
        delay(100);

        inicializar_efectos();
        permitir_transicion_juego = false;
        estado_actual_juego = "menu";
      }
    } else {
      gestor_audio.reproducir_cancion("presentacion_resultados");
    }
    
    // Efecto de fade-out al iniciar el estado
    mostrar_resultados.mostrar();
  }
}
