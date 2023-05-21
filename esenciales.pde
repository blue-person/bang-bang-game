// Constantes
final float MASCARA_COLISION_PROYECTIL = 15;
final float MASCARA_COLISION_BANDERA = 20;
final float MASCARA_COLISION_CANON = 45;
final float RESISTENCIA_BANDERAS = 15;

final int COLOR_NEGRO = #323957;
final int COLOR_GRIS = #7A9BA4;
final int COLOR_BLANCO = #F1F1F1;

final String TITULO_JUEGO = "Bang! Bang!";
final String JUGADOR_A = "jugador_a";
final String JUGADOR_B = "jugador_b";

final int DERECHA = 1;
final int IZQUIERDA = -1;

// Variables
int tecla_presionada = 0;
boolean permitir_espera_presentacion = true;
boolean permitir_transicion_juego = false;
String estado_actual_juego = "presentacion";
String jugador_actual;
String ganador;

float factor_aumento = 1.0;
float velocidad_pulso = 0.08;
float escala_maxima = 0.50;
float escala_minima = 0.45;

// Objetos
FadeIn mostrar_logo, mostrar_inicio, ocultar_inicio;
FadeOut ocultar_logo, iniciar_partida, acabar_partida;
Proyectil proyectil_a, proyectil_b;
Bandera bandera_a, bandera_b;
Canon canon_a, canon_b;

// Clases
Audio gestor_audio = new Audio();
Imagen gestor_imagenes = new Imagen();
Efecto gestor_efectos = new Efecto();

// Funciones
void iniciar_efectos() {
  // Logo
  mostrar_logo = new FadeIn("imagen", COLOR_BLANCO, 3.5);
  ocultar_logo = new FadeOut("imagen", COLOR_BLANCO, 4.5);

  // Pantalla de inicio
  mostrar_inicio = new FadeIn("imagen", COLOR_BLANCO, 5);
  ocultar_inicio = new FadeIn("figura", COLOR_NEGRO, 5);

  // Partida
  iniciar_partida = new FadeOut("figura", COLOR_NEGRO, 5);
  acabar_partida = new FadeOut("figura", 0, 2.5);
}

void iniciar_entidades() {
  // Variables
  ganador = null;
  jugador_actual = JUGADOR_A;

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
