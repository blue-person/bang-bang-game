class Control {
  // Variables
  float angulo_seleccionado = 0;
  
  // Constructor
  Control() {}
  
  // Metodos
  boolean boton_presionado() {
    return (keyPressed) && (key == ENTER);
  }
  
  float obtener_valor_angulo() {
    if (angulo_seleccionado > 50) {
      angulo_seleccionado = -45;
    } else {
      angulo_seleccionado++;
    }
    return angulo_seleccionado;
  }
  
  float obtener_valor_velocidad() {
    return 45;
  }
}

/*
String texto_puerto_serial = "-45, 45";
String[] valores_puerto_serial = texto_puerto_serial.split(", ");
float angulo_seleccionado = float(valores_puerto_serial[0]);
float velocidad_seleccionada = float(valores_puerto_serial[1]);
*/
