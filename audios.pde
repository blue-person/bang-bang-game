// Librerias
import ddf.minim.*;

// Clases globales
Minim minim = new Minim(this);

// Clase
class Audio {
  // Constantes
  final int BUFFER_EFECTOS_SONIDO = 512;
  final int BUFFER_CANCIONES = 1024;
  
  // Variables
  HashMap < String, AudioPlayer > efectos = new HashMap < String, AudioPlayer > ();
  HashMap < String, AudioPlayer > canciones = new HashMap < String, AudioPlayer > ();
  
  // Constructor
  Audio() {}

  // Metodos
  AudioPlayer obtener_cancion(String nombre_elemento) {
    return canciones.get(nombre_elemento);
  }
  
  AudioPlayer obtener_efecto(String nombre_elemento) {
    return efectos.get(nombre_elemento);
  }
  
  void cargar_efectos() {
    efectos.put("disparo", minim.loadFile("media/audio/efectos/juego/disparo.wav", BUFFER_EFECTOS_SONIDO));
    efectos.put("confirmar_opcion", minim.loadFile("media/audio/efectos/menu/confirmar_opcion.wav", BUFFER_EFECTOS_SONIDO));
    efectos.put("explosion_normal", minim.loadFile("media/audio/efectos/juego/explosion_normal.wav", BUFFER_EFECTOS_SONIDO));
    efectos.put("explosion_intensa", minim.loadFile("media/audio/efectos/juego/explosion_intensa.wav", BUFFER_EFECTOS_SONIDO));
    efectos.put("anunciador_bien", minim.loadFile("media/audio/efectos/anunciador/bien.wav", BUFFER_EFECTOS_SONIDO));
    efectos.put("anunciador_muy_bien", minim.loadFile("media/audio/efectos/anunciador/muy_bien.wav", BUFFER_EFECTOS_SONIDO));
    efectos.put("anunciador_genial", minim.loadFile("media/audio/efectos/anunciador/genial.wav", BUFFER_EFECTOS_SONIDO));
    efectos.put("anunciador_alucinante", minim.loadFile("media/audio/efectos/anunciador/alucinante.wav", BUFFER_EFECTOS_SONIDO));
    efectos.put("anunciador_sorprendente", minim.loadFile("media/audio/efectos/anunciador/sorprendente.wav", BUFFER_EFECTOS_SONIDO));
  }

  void cargar_canciones() {
    canciones.put("menu_inicio", minim.loadFile("media/audio/canciones/menu_inicio.wav", BUFFER_CANCIONES));
    canciones.put("batalla_normal", minim.loadFile("media/audio/canciones/batalla_normal.wav", BUFFER_CANCIONES));
    canciones.put("batalla_acelerada", minim.loadFile("media/audio/canciones/batalla_acelerada.wav", BUFFER_CANCIONES));
    canciones.put("batalla_intensa", minim.loadFile("media/audio/canciones/batalla_intensa.wav", BUFFER_CANCIONES));
    canciones.put("presentacion_resultados", minim.loadFile("media/audio/canciones/presentacion_resultados.wav", BUFFER_CANCIONES));
  }

  void reproducir_efecto_sonido(String nombre_elemento) {
    AudioPlayer archivo_audio = obtener_efecto(nombre_elemento);

    if (!archivo_audio.isPlaying()) {
      archivo_audio.rewind();
      archivo_audio.play();
    }
  }

  void detener_efecto_sonido(String nombre_elemento) {
    AudioPlayer archivo_audio = obtener_cancion(nombre_elemento);

    if (archivo_audio.isPlaying()) {
      archivo_audio.pause();
    }
  }
  
  void reproducion_solitaria_cancion(String nombre_elemento) {
    AudioPlayer archivo_audio = obtener_cancion(nombre_elemento);
    
    for (String nombre_cancion : canciones.keySet()) {
      AudioPlayer cancion_actual = obtener_cancion(nombre_cancion);
      
      boolean cancion_distinta = cancion_actual != archivo_audio;
      boolean cancion_reproduciendose = cancion_actual.isPlaying();
      if (cancion_distinta && cancion_reproduciendose) {
        cancion_actual.pause();
      }
    }

    if (!archivo_audio.isPlaying()) {
      archivo_audio.rewind();
      archivo_audio.loop();
    }
  }
  
  void reproducir_cancion(String nombre_elemento) {
    AudioPlayer archivo_audio = obtener_cancion(nombre_elemento);

    if (!archivo_audio.isPlaying()) {
      archivo_audio.rewind();
      archivo_audio.loop();
    }
  }

  void detener_cancion(String nombre_elemento) {
    AudioPlayer archivo_audio = obtener_cancion(nombre_elemento);

    if (archivo_audio.isPlaying()) {
      archivo_audio.pause();
    }
  }
  
  void detener_canciones() {
    for (String nombre_cancion : canciones.keySet()) {
      AudioPlayer cancion_actual = obtener_cancion(nombre_cancion);
      boolean cancion_reproduciendose = cancion_actual.isPlaying();
      if (cancion_reproduciendose) {
        cancion_actual.pause();
      }
    }
  }
}
