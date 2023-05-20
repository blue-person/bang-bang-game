// Librerias
import ddf.minim.*;
import java.util.Map;

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
    efectos_sonido.put("disparo", minim.loadFile("media/audio/efectos/disparo.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("confirmar_opcion", minim.loadFile("media/audio/efectos/confirmar_opcion.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("explosion_normal", minim.loadFile("media/audio/efectos/explosion_normal.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("explosion_intensa", minim.loadFile("media/audio/efectos/explosion_intensa.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("anunciador_bien", minim.loadFile("media/audio/voces/anunciador_bien.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("anunciador_muy_bien", minim.loadFile("media/audio/voces/anunciador_muy_bien.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("anunciador_genial", minim.loadFile("media/audio/voces/anunciador_genial.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("anunciador_alucinante", minim.loadFile("media/audio/voces/anunciador_alucinante.wav", BUFFER_EFECTOS_SONIDO));
    efectos_sonido.put("anunciador_sorprendente", minim.loadFile("media/audio/voces/anunciador_sorprendente.wav", BUFFER_EFECTOS_SONIDO));
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
    }
    archivo_audio.play();
  }

  void detener_efecto_sonido(String nombre_elemento) {
    AudioPlayer archivo_audio = canciones.get(nombre_elemento);

    if (archivo_audio.isPlaying()) {
      archivo_audio.close();
    }
  }

  void reproducir_cancion(String nombre_elemento) {
    AudioPlayer archivo_audio = canciones.get(nombre_elemento);

    if (archivo_audio.isMuted()) {
      archivo_audio.skip(archivo_audio.length());
      archivo_audio.unmute();
    }

    if (!archivo_audio.isLooping()) {
      archivo_audio.loop();
    }
  }

  void detener_cancion(String nombre_elemento) {
    AudioPlayer archivo_audio = canciones.get(nombre_elemento);

    if (archivo_audio.isLooping() && !archivo_audio.isMuted()) {
      archivo_audio.mute();
      archivo_audio.rewind();
    }
  }
}
