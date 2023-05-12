// Colecciones
HashMap<String, AudioPlayer> audios = new HashMap<String, AudioPlayer>();
HashMap<String, PImage> imagenes = new HashMap<String, PImage>();

// Funciones
void cargar_audios() {
  // Inicializar el objeto
  minim = new Minim(this);
  
  // Efectos de sonido
  audios.put("confirmar_opcion", minim.loadFile("media/audio/efectos/confirmar_opcion.wav", 1024));
  
  // Canciones
  audios.put("menu_inicio", minim.loadFile("media/audio/canciones/menu_inicio.wav", 1024));
  audios.put("batalla_normal", minim.loadFile("media/audio/canciones/batalla_normal.wav", 1024));
  audios.put("batalla_acelerada", minim.loadFile("media/audio/canciones/batalla_acelerada.wav", 1024));
  audios.put("batalla_intensa", minim.loadFile("media/audio/canciones/batalla_intensa.wav", 1024));
  
  // Voces
  audios.put("anunciador_bien", minim.loadFile("media/audio/voces/anunciador_bien.wav", 1024));
  audios.put("anunciador_muy_bien", minim.loadFile("media/audio/voces/anunciador_muy_bien.wav", 1024));
  audios.put("anunciador_genial", minim.loadFile("media/audio/voces/anunciador_genial.wav", 1024));
  audios.put("anunciador_alucinante", minim.loadFile("media/audio/voces/anunciador_alucinante.wav", 1024));
  audios.put("anunciador_sorprendente", minim.loadFile("media/audio/voces/anunciador_sorprendente.wav", 1024));
}

void cargar_sprites(String nombre_sprite, int cantidad_sprites) {
  for (int i = 0; i < cantidad_sprites; i++) {
    String identificador_imagen = nombre_sprite + "_" + str(i);
    String ubicacion_imagen = "media/sprites/" + nombre_sprite + "/" + str(i) + ".png";
    imagenes.put(identificador_imagen, loadImage(ubicacion_imagen));
  }
}

void cargar_imagenes() {
  cargar_sprites("proyectil", 1);
  cargar_sprites("bandera_a", 6);
  cargar_sprites("bandera_b", 6);
  cargar_sprites("base_canon", 1);
  cargar_sprites("canon_a", 1);
  cargar_sprites("canon_b", 1);
  cargar_sprites("fuego", 10);
  cargar_sprites("explosion_suave", 12);
  cargar_sprites("explosion_normal", 40);
  cargar_sprites("explosion_intensa", 29);
}
