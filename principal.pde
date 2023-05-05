// Librerias
import ddf.minim.*;

// Constantes
final float MASCARA_COLISION_PROYECTIL = 15;

// Variables
String estado_actual_juego = "presentacion";
int tecla_presionada = 0;

// Objetos
Proyectil proyectil_a, proyectil_b;
Bandera bandera_a, bandera_b;

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
  bandera_a = new Bandera(width / 4, height / 2, 10, 30);
  bandera_b = new Bandera(width / 1.5, height / 2, 10, 30);
  proyectil_a = new Proyectil(width / 2, height / 2, 1, 60, 35, MASCARA_COLISION_PROYECTIL);
  proyectil_b = new Proyectil(width / 2, height / 2, -1, 60, 65, MASCARA_COLISION_PROYECTIL);
}

void draw() {
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
      
      if (tecla_presionada == ENTER) {
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
      
      if (tecla_presionada == UP) {
        proyectil_a = new Proyectil(width / 2, height / 2, 1, 60, 35, MASCARA_COLISION_PROYECTIL);
        proyectil_b = new Proyectil(width / 2, height / 2, -1, 60, 65, MASCARA_COLISION_PROYECTIL);
      }
      
      // Bandera A
      if (bandera_a != null) {
        String estado_bandera = bandera_a.obtener_estado();
        if (estado_bandera == "destruido") {
          bandera_a = null;
        } else {
          bandera_a.actualizar_estado();
        }
      }
      
      // Bandera B
      if (bandera_b != null) {
        String estado_bandera = bandera_b.obtener_estado();
        if (estado_bandera == "destruido") {
          bandera_b = null;
        } else {
          bandera_b.actualizar_estado();
        }
      }
      
      // Proyectil A
      if (proyectil_a != null) {
        String estado_proyectil = proyectil_a.obtener_estado();
        if (estado_proyectil == "destruido") {
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
        if (estado_proyectil == "destruido") {
          proyectil_b = null;
        } else {
          if (bandera_a != null) {
            determinar_impacto_proyectil(proyectil_b, bandera_a);
          }
          proyectil_b.actualizar_estado();
        }
      }
      break;
  }
}

void keyPressed() {
  tecla_presionada = keyCode;
}
