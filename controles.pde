float angulo_seleccionado = 0;

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
