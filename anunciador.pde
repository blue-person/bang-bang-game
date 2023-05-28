class Anunciador {
  // Variables
  float pos_x, pos_y, fuerza_impacto;
  PImage mensaje_actual;
  String audio_actual;
  
  String MENSAJE_BIEN = "anunciador_0";
  String MENSAJE_MUY_BIEN = "anunciador_1";
  String MENSAJE_GENIAL = "anunciador_2";
  String MENSAJE_ALUCINANTE = "anunciador_3";
  String MENSAJE_SORPRENDENTE = "anunciador_4";
  
  // Constructor
  Anunciador(float pos_x, float pos_y) {
    this.pos_x = pos_x;
    this.pos_y = pos_y;
  }
  
  // Metodos
  void mostrar_mensaje(float fuerza_impacto) {
    if (fuerza_impacto > 0) {
      if (fuerza_impacto >= 1 && fuerza_impacto < 3) {
        audio_actual = "anunciador_bien";
        mensaje_actual = gestor_imagenes.obtener_sprite(MENSAJE_BIEN);
      } else if (fuerza_impacto >= 3 && fuerza_impacto < 6) {
        audio_actual = "anunciador_genial";
        mensaje_actual = gestor_imagenes.obtener_sprite(MENSAJE_GENIAL);
      } else if (fuerza_impacto <= 6) {
        audio_actual = "anunciador_alucinante";
        mensaje_actual = gestor_imagenes.obtener_sprite(MENSAJE_ALUCINANTE);
      } else {
        audio_actual = "anunciador_sorprendente";
        mensaje_actual = gestor_imagenes.obtener_sprite(MENSAJE_SORPRENDENTE);
      }
      this.fuerza_impacto = fuerza_impacto;
    }
    
    if (audio_actual != null) {
      if (gestor_audio.verificar_reproduccion_efecto(audio_actual)) {
        fade_in_imagenes.mostrar(mensaje_actual, pos_x, pos_y, 200);
      } else if (this.fuerza_impacto != 0) {
        this.fuerza_impacto = 0;
        inicializar_efectos_imagen();
        gestor_audio.reproducir_efecto_sonido(audio_actual);
      } else if (fade_in_imagenes.efecto_terminado()) {
        fade_out_imagenes.mostrar(mensaje_actual, pos_x, pos_y, 200);
      }
    }
  }
}
