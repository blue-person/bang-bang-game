class Control {
  // Variables
  String texto_puerto_serial = "0,-45,0";
  float angulo_seleccionado, velocidad_seleccionada;

  // Constructor
  Control() {}
  
  // Metodos
  void establecer_texto_serial(String texto_obtenido) {
    texto_puerto_serial = texto_obtenido;
  }
  
  boolean boton_inicio_presionado() {
   boolean boton_presionado = (keyPressed) && (key == ENTER); 
   return boton_presionado;
  }
  
  boolean boton_principal_presionado() {
    boolean boton_presionado = false;
    if (texto_puerto_serial.equals("0,-45,0")) {
      boton_presionado = (keyPressed) && (key == ENTER);
    } else {
      String[] valores_puerto_serial = texto_puerto_serial.split(",");
      boton_presionado = int(valores_puerto_serial[0]) == 1;
    }
    return boton_presionado;
  }
 
 float obtener_valor_angulo() {
    if (texto_puerto_serial.equals("0,-45,0")) {
      if (keyPressed && keyCode == DOWN) {
        angulo_seleccionado -= 2.5;
        if (angulo_seleccionado < -45) {
          angulo_seleccionado = -45;
        }
      } else if (keyPressed && keyCode == UP) {
        angulo_seleccionado += 2.5;
        if (angulo_seleccionado > 50) {
          angulo_seleccionado = 50;
        }
      }
    } else {
      String[] valores_puerto_serial = texto_puerto_serial.split(",");
      angulo_seleccionado = Float.parseFloat(valores_puerto_serial[1]);
    }
    return angulo_seleccionado;
  }
  
  float obtener_valor_velocidad() {
    if (texto_puerto_serial.equals("0,-45,0")) {
      if (keyPressed && keyCode == LEFT) {
        velocidad_seleccionada -= 2.5;
        if (velocidad_seleccionada < 0) {
          velocidad_seleccionada = 0;
        }
      } else if (keyPressed && keyCode == RIGHT) {
        velocidad_seleccionada += 2.5;
        if (velocidad_seleccionada > 150) {
          velocidad_seleccionada = 150;
        }
      }
    } else {
      String[] valores_puerto_serial = texto_puerto_serial.split(",");
      velocidad_seleccionada = float(valores_puerto_serial[2]);
    }
    return velocidad_seleccionada;
  }
}
