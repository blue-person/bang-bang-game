// Librerias
import ddf.minim.*;

// Constantes
final float MASCARA_COLISION_PROYECTIL = 15;
final float RESISTENCIA_BANDERAS = 5;

final int COLOR_NEGRO = #323957;
final int COLOR_BLANCO = #F1F1F1;

final String JUGADOR_A = "jugador_a";
final String JUGADOR_B = "jugador_b";

final int DERECHA = 1;
final int IZQUIERDA = -1;

// Variables
boolean permitir_disparo;
int tecla_presionada = 0;
int angulo_seleccionado = 0;
int velocidad_seleccionada = 0;
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
  surface.setTitle("Bang! Bang! Destroy the Flag!");
  
  // Configuracion del proyecto
  size(640, 480);
  frameRate(60);
  smooth();
  
  // Pre-cargar elementos
  cargar_audios();
  cargar_imagenes();
}

void iniciar_objetos() {
  ganador = null;
  bandera_a = new Bandera(width / 4, height / 2, RESISTENCIA_BANDERAS, 30, "bandera_a");
  bandera_b = new Bandera(width / 1.5, height / 2, RESISTENCIA_BANDERAS, 30, "bandera_b");
  canon_a = new Canon(width / 4, height / 2.5, 30, IZQUIERDA, "canon_a");
  canon_b = new Canon(width / 1.5, height / 2.5, 30, DERECHA, "canon_b");
}

void draw() {
  background(COLOR_NEGRO);
  
  switch(estado_actual_juego) {
    case "presentacion":
      background(COLOR_BLANCO);
      
      boolean pantalla_despejada = aclarar_pantalla(COLOR_NEGRO, 5);
      if (pantalla_despejada) {
        estado_actual_juego = "menu";
      }
      break;
    case "menu":
      background(COLOR_BLANCO);
      
      // Efectos especiales
      reproducir_cancion("menu_inicio");
      mostrar_mensaje_inicio();
      
      if ((keyPressed) && (key == ENTER)) {
        // Determinar estado de los audios
        detener_audio("menu_inicio");
        reproducir_audio("confirmar_opcion");
        
        // Iniciar los elemtnos interactuables
        iniciar_objetos();
        
        // Cambiar el estado del juego
        estado_actual_juego = "juego";
      }
      break;
    case "juego":
      background(COLOR_BLANCO);
      permitir_disparo = (keyPressed) && (key == TAB);

      if (angulo_seleccionado > 50) {
        angulo_seleccionado = -45;
      } else {
        angulo_seleccionado++;
      }
      canon_a.mostrar(angulo_seleccionado);
      canon_b.mostrar(angulo_seleccionado);
      
      if (ganador != null) {
        proyectil_a = null;
        proyectil_b = null;
        
        boolean pantalla_oscurecida = oscurecer_pantalla(COLOR_NEGRO, 2.5);
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
          } else if (!existe_proyectil_a && bandera_a_no_explotando && bandera_b_no_explotando && permitir_disparo) {
            FloatDict ubicacion_punta_canon = canon_a.determinar_ubicacion_punta();
            float pos_x = ubicacion_punta_canon.get("pos_x");
            float pos_y = ubicacion_punta_canon.get("pos_y");
            float angulo = angulo_seleccionado;
            float velocidad = 56;
            
            proyectil_a = new Proyectil(pos_x, pos_y, DERECHA, angulo, velocidad, MASCARA_COLISION_PROYECTIL);
          }
        } else if (turno_jugador_b) {
          if (existe_proyectil_b && proyectil_b.obtener_estado().equals("explotando")) {
            jugador_actual = JUGADOR_A;
          } else if (!existe_proyectil_b && bandera_a_no_explotando && bandera_b_no_explotando && permitir_disparo) {
            FloatDict ubicacion_punta_canon = canon_b.determinar_ubicacion_punta();
            float pos_x = ubicacion_punta_canon.get("pos_x");
            float pos_y = ubicacion_punta_canon.get("pos_y");
            float angulo = angulo_seleccionado;
            float velocidad = 45;
        
            proyectil_b = new Proyectil(pos_x, pos_y, IZQUIERDA, angulo, velocidad, MASCARA_COLISION_PROYECTIL);
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
      }
      break;
    case "resultados":
      mostrar_mensaje_resultados(ganador);
      
      if ((keyPressed) && (key == ENTER)) {
        estado_actual_juego = "menu";
      }
  }
}

void keyPressed() {
  tecla_presionada = keyCode;
}
