class Control {
  // Variables
  String texto_puerto_serial = "0,-45,0";

  // Constructor
  Control() {}
  
  // Metodos
  void establecer_texto_serial(String texto_obtenido) {
    texto_puerto_serial = texto_obtenido;
  }
  
  boolean boton_presionado() {
    /*
    String[] valores_puerto_serial = texto_puerto_serial.split(",");
    boolean boton_presionado = int(valores_puerto_serial[0]) == 1;
    */
    boolean boton_presionado = (keyPressed) && (key == ENTER);
    return boton_presionado;
  }

  float obtener_valor_angulo() {
    String[] valores_puerto_serial = texto_puerto_serial.split(",");
    float angulo_seleccionado = float(valores_puerto_serial[1]);
    //return angulo_seleccionado;
    return 42;
  }
  
  float obtener_valor_velocidad() {
    String[] valores_puerto_serial = texto_puerto_serial.split(",");
    float velocidad_seleccionada = float(valores_puerto_serial[2]);
    //return velocidad_seleccionada;
    return 100; 
  }
}
