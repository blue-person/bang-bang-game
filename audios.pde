// Librerias
import ddf.minim.*;

// Clases globales
Minim minim = new Minim(this);

// Variables globales
HashMap < String, AudioPlayer > efectos_sonido = new HashMap < String, AudioPlayer > ();
HashMap < String, AudioPlayer > canciones = new HashMap < String, AudioPlayer > ();

// Clase
class Audio {
  // Constantes
  final int BUFFER_EFECTOS_SONIDO = 512;
  final int BUFFER_CANCIONES = 1024;

  // Constructor
  Audio() {}

  // Metodos
  void cargar_efectos_sonido() {
    efectos_sonido.put("disparo", minim.loadFile("media/audio/efectos/juego/disparo.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("confirmar_opcion", minim.loadFile("media/audio/efectos/menu/confirmar_opcion.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("explosion_normal", minim.loadFile("media/audio/efectos/juego/explosion_normal.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("explosion_intensa", minim.loadFile("media/audio/efectos/juego/explosion_intensa.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("anunciador_bien", minim.loadFile("media/audio/efectos/anunciador/bien.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("anunciador_muy_bien", minim.loadFile("media/audio/efectos/anunciador/muy_bien.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("anunciador_genial", minim.loadFile("media/audio/efectos/anunciador/genial.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("anunciador_alucinante", minim.loadFile("media/audio/efectos/anunciador/alucinante.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("anunciador_sorprendente", minim.loadFile("media/audio/efectos/anunciador/sorprendente.wav", BUFFER_EFECTOS_SONIDO));
  }

  void cargar_canciones() {
    canciones.put("menu_inicio", minim.loadFile("media/audio/canciones/menu_inicio.wav", BUFFER_CANCIONES));
    canciones.put("batalla_normal", minim.loadFile("media/audio/canciones/batalla_normal.wav", BUFFER_CANCIONES));
    canciones.put("batalla_acelerada", minim.loadFile("media/audio/canciones/batalla_acelerada.wav", BUFFER_CANCIONES));
    canciones.put("batalla_intensa", minim.loadFile("media/audio/canciones/batalla_intensa.wav", BUFFER_CANCIONES));
    canciones.put("presentacion_resultados", minim.loadFile("media/audio/canciones/presentacion_resultados.wav", BUFFER_CANCIONES));
  }

  void reproducir_efecto_sonido(String nombre_elemento) {
    AudioPlayer archivo_audio = efectos_sonido.get(nombre_elemento);

    if (!archivo_audio.isPlaying()) {
      archivo_audio.rewind();
      archivo_audio.play();
    }
  }

  void detener_efecto_sonido(String nombre_elemento) {
    AudioPlayer archivo_audio = canciones.get(nombre_elemento);

    if (archivo_audio.isPlaying()) {
      archivo_audio.pause();
    }
  }
  
  void reproducion_solitaria_cancion(String nombre_elemento) {
    AudioPlayer archivo_audio = canciones.get(nombre_elemento);
    
    for (String nombre_cancion : canciones.keySet()) {
      AudioPlayer cancion_actual = canciones.get(nombre_cancion);
      
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
    AudioPlayer archivo_audio = canciones.get(nombre_elemento);

    if (!archivo_audio.isPlaying()) {
      archivo_audio.rewind();
      archivo_audio.loop();
    }
  }

  void detener_cancion(String nombre_elemento) {
    AudioPlayer archivo_audio = canciones.get(nombre_elemento);

    if (archivo_audio.isPlaying()) {
      archivo_audio.pause();
    }
  }
}
