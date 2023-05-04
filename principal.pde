Proyectil proyectil_a, proyectil_b;
Bandera bandera_a, bandera_b;

void gestionar_bandera(Bandera bandera, Proyectil proyectil) {
  if (bandera == null) {
    int a = 1;
  } else {
    if (proyectil.verificar_colision(bandera)) {
      float fuerza_impacto = proyectil.determinar_fuerza_impacto();
      bandera.reducir_resistencia(fuerza_impacto);
    } else {
      bandera.dibujar();
    }
  }
}

void setup() {
  size(640, 480);
  frameRate(60);
  
  bandera_a = new Bandera(width / 4, height / 2, 100, 30);
  bandera_b = new Bandera(width / 1.5, height / 2, 100, 30);
  proyectil_a = new Proyectil(width / 2, height / 2, 1, 60, 35, 30);
  proyectil_b = new Proyectil(width / 2, height / 2, -1, 60, 65, 30);
}

void draw() {
  background(153);
  
  gestionar_bandera(bandera_a, proyectil_b);
  gestionar_bandera(bandera_b, proyectil_a);
  
  proyectil_a.dibujar();
  proyectil_a.mover();
}
