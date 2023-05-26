class Imagen {
  // Variables
  HashMap < String, PImage > sprites = new HashMap < String, PImage > ();
  HashMap < String, PImage > imagenes = new HashMap < String, PImage > ();

  // Constructor
  Imagen() {}

  // Metodos  
  PImage obtener_imagen(String nombre_elemento) {
    return imagenes.get(nombre_elemento);
  }
  
  PImage obtener_sprite(String nombre_elemento) {
    return sprites.get(nombre_elemento);
  }
  
  void cargar_tileset(String nombre_tileset, int cantidad_sprites) {
    for (int i = 0; i < cantidad_sprites; i++) {
      String identificador_sprite = nombre_tileset + "_" + str(i);
      String ubicacion_sprite = "media/sprites/" + nombre_tileset + "/" + str(i) + ".png";
      sprites.put(identificador_sprite, loadImage(ubicacion_sprite));
    }
  }

  void cargar_sprites() {
    cargar_tileset("proyectil", 1);
    cargar_tileset("bandera_a", 18);
    cargar_tileset("bandera_b", 18);
    cargar_tileset("base_canon", 1);
    cargar_tileset("canon_a", 1);
    cargar_tileset("canon_b", 1);
    cargar_tileset("fuego", 22);
    cargar_tileset("explosion_suave", 16);
    cargar_tileset("explosion_normal", 40);
    cargar_tileset("explosion_intensa", 29);
    cargar_tileset("muralla_derecha", 12);
    cargar_tileset("muralla_izquierda", 11);
    cargar_tileset("vegetacion", 4);
    cargar_tileset("presiona_boton", 1);
    cargar_tileset("ganador", 3);
  }

  void cargar_imagenes() {
    imagenes.put("logo_universidad", loadImage("media/img/logo_universidad/0.png"));
    imagenes.put("logo_juego", loadImage("media/img/logo_juego/0.png"));
    imagenes.put("monte_a", loadImage("media/img/monte_a/0.png"));
    imagenes.put("monte_b", loadImage("media/img/monte_b/0.png"));
    imagenes.put("monte_c", loadImage("media/img/monte_c/0.png"));
    imagenes.put("nubes", loadImage("media/img/nubes/0.png"));
    imagenes.put("fondo_cuadros", loadImage("media/img/fondo_cuadros/0.png"));
  }
}
