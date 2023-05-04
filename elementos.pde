// Colecciones
HashMap<String, SoundFile> efectos_sonido = new HashMap<String, SoundFile>();
HashMap<String, SoundFile> canciones = new HashMap<String, SoundFile>();

// Funciones
void cargar_sonidos() {
  efectos_sonido.put("confirmar_opcion", new SoundFile(this, "audio/efectos/confirmar_opcion.wav"));
}

void cargar_canciones() {
  canciones.put("menu_inicio", new SoundFile(this, "audio/canciones/menu_inicio.wav"));
  canciones.put("batalla_normal", new SoundFile(this, "audio/canciones/batalla_normal.wav"));
  canciones.put("batalla_intensa", new SoundFile(this, "audio/canciones/batalla_intensa.wav"));
}
