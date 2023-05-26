// Variables globales
HashMap < String, PImage > imagenes = new HashMap < String, PImage > ();

// Clase
class Imagen {
  // Constructor
  Imagen() {}

  // Metodos
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
    cargar_sprites("fuego", 22);
    cargar_sprites("explosion_suave", 16);
    cargar_sprites("explosion_normal", 40);
    cargar_sprites("explosion_intensa", 29);
    cargar_sprites("logo_universidad", 1);
    cargar_sprites("logo_juego", 1);
    cargar_sprites("monte_a", 1);
    cargar_sprites("monte_b", 1);
    cargar_sprites("monte_c", 1);
    cargar_sprites("nubes", 1);
    cargar_sprites("fondo_cuadros", 1);
  }
}
