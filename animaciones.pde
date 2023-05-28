class Animacion {
  // Variables
  PImage[] lista_imagenes;
  int cantidad_imagenes;
  int indice_actual;

  // Constructor
  Animacion(String nombre_elemento, int cantidad_imagenes) {
    this.cantidad_imagenes = cantidad_imagenes;
    lista_imagenes = new PImage[cantidad_imagenes];

    for (int i = 0; i < cantidad_imagenes; i++) {
      String nombre_archivo = nombre_elemento + "_" + str(i);
      lista_imagenes[i] = gestor_imagenes.obtener_sprite(nombre_archivo);
    }
  }

  // Metodos
  void mostrar(float pos_x, float pos_y) {
    indice_actual = (indice_actual + 1) % cantidad_imagenes;
    
    push();
    imageMode(CENTER);
    image(lista_imagenes[indice_actual], pos_x, pos_y);
    pop();
  }

  void mostrar(float pos_x, float pos_y, int direccion) {
    indice_actual = (indice_actual + 1) % cantidad_imagenes;
    
    push();
    imageMode(CENTER);
    pushMatrix();
    scale(direccion, 1);
    image(lista_imagenes[indice_actual], direccion * pos_x, pos_y);
    popMatrix();
    pop();
  }

  boolean animacion_termino() {
    int indice_maximo = cantidad_imagenes - 1;
    return (indice_actual == indice_maximo);
  }
}
