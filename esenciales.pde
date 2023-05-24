// Constantes
final float MASCARA_COLISION_PROYECTIL = 15;
final float MASCARA_COLISION_BANDERA = 20;
final float MASCARA_COLISION_CANON = 45;
final float RESISTENCIA_BANDERAS = 15;

final int COLOR_NEGRO = #323957;
final int COLOR_BLANCO = #F1F1F1;
final int COLOR_AZUL_CLARO = #6fd3ff;
final int COLOR_AZUL_OSCURO = #5185d3;

final String JUGADOR_A = "jugador_rojo";
final String JUGADOR_B = "jugador_azul";

final int DERECHA = 1;
final int IZQUIERDA = -1;

// Variables
int tecla_presionada = 0;
boolean permitir_espera_presentacion = true;
boolean permitir_transicion_juego = false;
String estado_actual_juego = "presentacion";

String ganador;
String jugador_actual;

float angulo_a;
float angulo_b;
float velocidad_a;
float velocidad_b;

float factor_aumento = 1.0;
float velocidad_pulso = 0.08;
float escala_maxima = 0.50;
float escala_minima = 0.45;

// Objetos
FadeOut mostrar_logo, mostrar_inicio, iniciar_partida, mostrar_resultados;
FadeIn ocultar_logo, ocultar_inicio, acabar_partida, ocultar_resultados;
Proyectil proyectil_a, proyectil_b;
Bandera bandera_a, bandera_b;
Canon canon_a, canon_b;
Serial puerto_serial;

// Clases
Audio gestor_audio = new Audio();
Imagen gestor_imagenes = new Imagen();
Efecto gestor_efectos = new Efecto();
Control gestor_controles = new Control();

// Funciones
void inicializar_efectos() {
  // Logo
  mostrar_logo = new FadeOut(COLOR_BLANCO, 3.5);
  ocultar_logo = new FadeIn(COLOR_BLANCO, 4.5);

  // Pantalla de inicio
  mostrar_inicio = new FadeOut(COLOR_BLANCO, 5);
  ocultar_inicio = new FadeIn(COLOR_NEGRO, 5);

  // Partida
  iniciar_partida = new FadeOut(COLOR_NEGRO, 5);
  acabar_partida = new FadeIn(COLOR_NEGRO, 2.5);
  
  // Resultados
  mostrar_resultados = new FadeOut(COLOR_NEGRO, 5);
  ocultar_resultados = new FadeIn(COLOR_BLANCO, 8.5);
}

void inicializar_elementos() {
  // Variables generales
  ganador = null;
  jugador_actual = JUGADOR_A;

  // Angulo
  angulo_a = -45;
  angulo_b = -45;
  
  // Velocidad
  velocidad_a = 0;
  velocidad_b = 0;

  // Banderas
  bandera_a = new Bandera(width / 4, height / 2, RESISTENCIA_BANDERAS, MASCARA_COLISION_BANDERA, "bandera_a");
  bandera_b = new Bandera(width / 1.5, height / 2, RESISTENCIA_BANDERAS, MASCARA_COLISION_BANDERA, "bandera_b");

  // Canones
  canon_a = new Canon(width / 4, height / 2.5, MASCARA_COLISION_CANON, IZQUIERDA, "canon_a");
  canon_b = new Canon(width / 1.5, height / 2.5, MASCARA_COLISION_CANON, DERECHA, "canon_b");

  // Proyectiles
  proyectil_a = null;
  proyectil_b = null;
}

void inicializar_conexion_serial() {  
  try {
    puerto_serial = new Serial(this, Serial.list()[0], 9600);  
    puerto_serial.bufferUntil('\n');
  } catch (ArrayIndexOutOfBoundsException error) {
    println("No se ha encontrado ninguna conexion serial activa.");
  } catch (Exception error) {
    println("Se ha encontrado un error en la conexion con el puerto serial: " + error);
  }
}

void serialEvent(Serial puerto_serial) {
  String texto_serial = puerto_serial.readStringUntil('\n');
  gestor_controles.establecer_texto_serial(texto_serial);
  puerto_serial.clear();
}
