// Librerias
import ddf.minim.*;

// Constantes
final float MASCARA_COLISION_PROYECTIL = 15;
final float MASCARA_COLISION_BANDERA = 20;
final float MASCARA_COLISION_CANON = 45;
final float RESISTENCIA_BANDERAS = 100;

final int COLOR_NEGRO = #323957;
final int COLOR_BLANCO = #F1F1F1;

final String JUGADOR_A = "jugador_a";
final String JUGADOR_B = "jugador_b";

final int DERECHA = 1;
final int IZQUIERDA = -1;

// Variables
int tecla_presionada = 0;
String estado_actual_juego = "presentacion";
String jugador_actual = JUGADOR_A;
String ganador;

// Objetos
Minim minim;
Proyectil proyectil_a, proyectil_b;
Bandera bandera_a, bandera_b;
Canon canon_a, canon_b;

// Funciones
void setup() {
  // Configuracion de la ventana
  surface.setTitle("Bang! Bang!");
  size(640, 480);
  
  // Configuracion del proyecto
  frameRate(60);
  smooth();
  
  // Pre-cargar elementos
  cargar_audios();
  cargar_imagenes();
}

void iniciar_entidades() {
  ganador = null;
  bandera_a = new Bandera(width / 4, height / 2, RESISTENCIA_BANDERAS, MASCARA_COLISION_BANDERA, "bandera_a");
  bandera_b = new Bandera(width / 1.5, height / 2, RESISTENCIA_BANDERAS, MASCARA_COLISION_BANDERA, "bandera_b");
  canon_a = new Canon(width / 4, height / 2.5, MASCARA_COLISION_CANON, IZQUIERDA, "canon_a");
  canon_b = new Canon(width / 1.5, height / 2.5, MASCARA_COLISION_CANON, DERECHA, "canon_b");
}

void draw() {
  switch(estado_actual_juego) {
    case "presentacion":
      background(COLOR_NEGRO);
  
      boolean pantalla_despejada = aclarar_pantalla(5);
      if (pantalla_despejada) {
        estado_actual_juego = "menu";
      }
      break;
    case "menu":
      background(COLOR_BLANCO);
      
      // Efectos especiales
      reproducir_cancion("menu_inicio");
      mostrar_mensaje_inicio();
      
      if (boton_presionado()) {
        // Determinar estado de los audios
        detener_audio("menu_inicio");
        reproducir_audio("confirmar_opcion");
        
        // Iniciar los elemtnos interactuables
        iniciar_entidades();
        
        // Cambiar el estado del juego
        estado_actual_juego = "juego";
        delay(100);
      }
      break;
    case "juego":
      background(COLOR_BLANCO);
      float angulo_seleccionado = obtener_valor_angulo();
      float velocidad_seleccionada = obtener_valor_velocidad();
      
      if (ganador != null) {
        proyectil_a = null;
        proyectil_b = null;
        
        boolean pantalla_oscurecida = oscurecer_pantalla(2.5);
        if (pantalla_oscurecida) {
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
            FloatDict ubicacion_punta_canon = canon_a.determinar_ubicacion_punta();
            float pos_x = ubicacion_punta_canon.get("pos_x");
            float pos_y = ubicacion_punta_canon.get("pos_y");

            proyectil_a = new Proyectil(pos_x, pos_y, DERECHA, angulo_seleccionado, velocidad_seleccionada, MASCARA_COLISION_PROYECTIL);
          }
        } else if (turno_jugador_b) {
          if (existe_proyectil_b && proyectil_b.obtener_estado().equals("explotando")) {
            jugador_actual = JUGADOR_A;
          } else if (!existe_proyectil_b && bandera_a_no_explotando && bandera_b_no_explotando && boton_presionado()) {
            FloatDict ubicacion_punta_canon = canon_b.determinar_ubicacion_punta();
            float pos_x = ubicacion_punta_canon.get("pos_x");
            float pos_y = ubicacion_punta_canon.get("pos_y");
        
            proyectil_b = new Proyectil(pos_x, pos_y, IZQUIERDA, angulo_seleccionado, velocidad_seleccionada, MASCARA_COLISION_PROYECTIL);
          }
        }

        // Bandera A
        if (bandera_a != null) {
          String estado_bandera = bandera_a.obtener_estado();
          if (estado_bandera.equals("destruido"))  {
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
              determinar_impacto_proyectil(proyectil_a, bandera_b);
            }
            proyectil_a.actualizar_estado();
          }
        }
        
        // Proyectil B
        if (proyectil_b != null) {
          String estado_proyectil = proyectil_b.obtener_estado();
          if (estado_proyectil.equals("destruido"))  {
            proyectil_b = null;
          } else {
            if (bandera_a != null) {
              determinar_impacto_proyectil(proyectil_b, bandera_a);
            }
            proyectil_b.actualizar_estado();
          }
        }
        
        // Se actualiza el estado de los canones
        canon_a.mostrar(angulo_seleccionado);
        canon_b.mostrar(angulo_seleccionado);
      }
      break;
    case "resultados":
      mostrar_mensaje_resultados(ganador);
      
      if (boton_presionado()) {
        estado_actual_juego = "menu";
      }
  }
}
