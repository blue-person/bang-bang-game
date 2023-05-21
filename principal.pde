// Funciones
void setup() {
  // Configuracion de la ventana
  surface.setTitle(TITULO_JUEGO);
  size(640, 480);

  // Configuracion del proyecto
  frameRate(60);
  smooth();
  noCursor();

  // Pre-cargar elementos
  gestor_audio.cargar_efectos_sonido();
  gestor_audio.cargar_canciones();
  gestor_imagenes.cargar_imagenes();

  // Cargar objetos
  iniciar_efectos();
}

void draw() {
  // Configuraciones esenciales
  noTint();

  // Determinar estado
  switch (estado_actual_juego) {
  case "presentacion":
    // Aplicar el fondo
    background(COLOR_BLANCO);

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
      mostrar_logo = null;
      ocultar_logo = null;

      delay(250);
      estado_actual_juego = "menu";
    }

    // Mostrar el logo de la universidad
    PImage logo_universidad = imagenes.get("logo_universidad_0");
    logo_universidad.resize(200, 188);
    imageMode(CENTER);
    image(logo_universidad, width / 2, height / 2);

    break;
  case "menu":
    // Aplicar el fondo
    background(COLOR_GRIS);

    // Efecto de fade-in
    mostrar_inicio.mostrar();

    // Gestion del mensaje de inicio
    
    // Mostrar el logo
    PImage logo_juego = imagenes.get("logo_juego_0");
    gestor_efectos.imagen_pulsante(logo_juego, width / 2, height / 4, escala_minima, escala_maxima);

    // Mostrar animacion para continuar
    fill(0, mostrar_inicio.obtener_opacidad());
    textAlign(CENTER);
    text("Presiona el boton para continuar", width / 2, height / 1.5);

    // Determinar estado
    if (mostrar_inicio.efecto_terminado() && boton_presionado()) {
      gestor_audio.reproducir_efecto_sonido("confirmar_opcion");
      permitir_transicion_juego = true;
    }

    // Realizar transicion
    if (permitir_transicion_juego) {
      // Determinar estado de los audios
      gestor_audio.detener_cancion("menu_inicio");

      // Efecto de fade-in
      ocultar_inicio.mostrar();
      rect(0, 0, width, height);

      // Cambiar de estado
      if (ocultar_inicio.efecto_terminado()) {
        delay(100);

        iniciar_entidades();
        permitir_transicion_juego = false;
        estado_actual_juego = "juego";
      }
    } else {
      gestor_audio.reproducir_cancion("menu_inicio");
    }
    break;
  case "juego":
    // Variables
    float angulo_seleccionado = obtener_valor_angulo();
    float velocidad_seleccionada = obtener_valor_velocidad();

    // Aplicar el fondo
    background(COLOR_GRIS);

    // Logica
    if (ganador != null) {
      gestor_audio.detener_cancion("batalla_intensa");

      acabar_partida.mostrar();
      rect(0, 0, width, height);

      if (acabar_partida.efecto_terminado()) {
        estado_actual_juego = "resultados";
      }
    } else {
      boolean turno_jugador_a = jugador_actual.equals(JUGADOR_A);
      boolean turno_jugador_b = jugador_actual.equals(JUGADOR_B);
      boolean existe_proyectil_a = (proyectil_a != null);
      boolean existe_proyectil_b = (proyectil_b != null);
      boolean bandera_a_no_explotando = (bandera_a != null) && !bandera_a.obtener_estado().equals("explotando");
      boolean bandera_b_no_explotando = (bandera_b != null) && !bandera_b.obtener_estado().equals("explotando");

      if (turno_jugador_a) {
        if (existe_proyectil_a && proyectil_a.obtener_estado().equals("explotando")) {
          jugador_actual = JUGADOR_B;
        } else if (!existe_proyectil_a && bandera_a_no_explotando && bandera_b_no_explotando && boton_presionado()) {
          FloatDict ubicacion_punta_canon = canon_a.obtener_ubicacion_punta();
          float pos_x = ubicacion_punta_canon.get("pos_x");
          float pos_y = ubicacion_punta_canon.get("pos_y");

          proyectil_a = new Proyectil(pos_x, pos_y, DERECHA, angulo_seleccionado, velocidad_seleccionada, MASCARA_COLISION_PROYECTIL);
        }
      } else if (turno_jugador_b) {
        if (existe_proyectil_b && proyectil_b.obtener_estado().equals("explotando")) {
          jugador_actual = JUGADOR_A;
        } else if (!existe_proyectil_b && bandera_a_no_explotando && bandera_b_no_explotando && boton_presionado()) {
          FloatDict ubicacion_punta_canon = canon_b.obtener_ubicacion_punta();
          float pos_x = ubicacion_punta_canon.get("pos_x");
          float pos_y = ubicacion_punta_canon.get("pos_y");

          proyectil_b = new Proyectil(pos_x, pos_y, IZQUIERDA, angulo_seleccionado, velocidad_seleccionada, MASCARA_COLISION_PROYECTIL);
        }
      }

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

      // Manejo de la musica
      if (bandera_a != null && bandera_b != null) {
        boolean batalla_normal = bandera_a.obtener_intensidad_batalla() == "normal" || bandera_b.obtener_intensidad_batalla() == "normal";
        boolean batalla_acelerada = bandera_a.obtener_intensidad_batalla() == "inestable" || bandera_b.obtener_intensidad_batalla() == "inestable";
        boolean batalla_intensa = bandera_a.obtener_intensidad_batalla() == "critico" || bandera_b.obtener_intensidad_batalla() == "critico";

        if (batalla_normal) {
          gestor_audio.detener_cancion("batalla_intensa");
          gestor_audio.detener_cancion("batalla_acelerada");
          gestor_audio.reproducir_cancion("batalla_normal");
        } else if (batalla_acelerada) {
          gestor_audio.detener_cancion("batalla_normal");
          gestor_audio.detener_cancion("batalla_intensa");
          gestor_audio.reproducir_cancion("batalla_acelerada");
        } else if (batalla_intensa) {
          gestor_audio.detener_cancion("batalla_normal");
          gestor_audio.detener_cancion("batalla_acelerada");
          gestor_audio.reproducir_cancion("batalla_intensa");
        }
      }

      // Se actualiza el estado de los canones
      canon_a.mostrar(angulo_seleccionado);
      canon_b.mostrar(angulo_seleccionado);

      iniciar_partida.mostrar();
      rect(0, 0, width, height);
    }
    break;
  case "resultados":
    // Aplicar el fondo
    background(COLOR_GRIS);

    // Mostrar ganador
    fill(0, 255);
    textAlign(CENTER);
    text("El ganador fue: " + ganador, width / 2, height / 2);

    // Reiniciar
    if (boton_presionado()) {
      iniciar_efectos();
      gestor_audio.detener_cancion("presentacion_resultados");
      estado_actual_juego = "menu";
    } else {
      gestor_audio.reproducir_cancion("presentacion_resultados");
    }
  }
}
