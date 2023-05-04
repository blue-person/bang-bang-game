// Librerias
import processing.sound.*;

// Variables
String estado_actual_juego = "presentacion";
int tecla_presionada = 0;

Proyectil proyectil_a, proyectil_b;
Bandera bandera_a, bandera_b;

void setup() {
  // Configuracion de la ventana
  surface.setTitle("Bang! Bang!");
  
  // Configuracion del proyecto
  size(640, 480);
  frameRate(60);
  smooth();
  
  // Pre-cargar elementos
  cargar_sonidos();
  cargar_canciones();
  
  // Declarar objetos
  bandera_a = new Bandera(width / 4, height / 2, 100, 30);
  bandera_b = new Bandera(width / 1.5, height / 2, 100, 30);
  proyectil_a = new Proyectil(width / 2, height / 2, 1, 60, 35, 30);
  proyectil_b = new Proyectil(width / 2, height / 2, -1, 60, 65, 30);
  
  // Esperar un tiempo
  delay(1000);
}

void draw() {
  switch(estado_actual_juego) {
    case "presentacion":
      background(COLOR_BLANCO);
      Boolean pantalla_despejada = aclarar_pantalla(COLOR_NEGRO, 5);
      
      if (pantalla_despejada) {
        estado_actual_juego = "menu";
      }
      break;
    case "menu":
      background(COLOR_BLANCO);
      reproducir_cancion("menu_inicio");
      mostrar_mensaje_inicio();
      
      if (tecla_presionada == ENTER) {
        reproducir_sonido("confirmar_opcion");
        estado_actual_juego = "juego";
      }
      break;
    case "juego":
      background(COLOR_BLANCO);
      
      bandera_a.dibujar();
      bandera_b.dibujar();
      
      if (proyectil_a != null) {
        String estado_proyectil = proyectil_a.obtener_estado();
        if (estado_proyectil == "destruido") {
          proyectil_a = null;
        } else {
          proyectil_a.dibujar();
          proyectil_a.mover();
          
          if (proyectil_a.verificar_colision(bandera_b)) {
            float fuerza_impacto = proyectil_a.determinar_fuerza_impacto();
            bandera_b.reducir_resistencia(fuerza_impacto);
            
            proyectil_a.destruir();
          }
        }
      }
      break;
  }
}

void keyPressed() {
  tecla_presionada = keyCode;
}
