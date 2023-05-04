// Variables
int transparencia = 255;

// Funciones
Boolean aclarar_pantalla(int color_hexadecimal, float velocidad) {
  if (transparencia <= 255) {
    transparencia -= (1 * velocidad);
  }
  
  fill(color_hexadecimal, transparencia);
  rect(0, 0, width, height);
  return (transparencia <= 0);
}

Boolean oscurecer_pantalla(int color_hexadecimal, float velocidad) {
  if (transparencia >= 0) {
    transparencia += (1 * velocidad);
  }
  
  fill(color_hexadecimal, transparencia);
  rect(0, 0, width, height);
  return (transparencia == 255);
}

void mostrar_mensaje_inicio() {
  fill(COLOR_NEGRO);
  textAlign(CENTER);
  text("Presiona Enter para continuar", width / 2, height / 2);
}
