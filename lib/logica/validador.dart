// Clase para la validación común de entradas numéricas

class Validador {
  /// Valida una cadena de texto para asegurar que sea un entero positivo.
  /// Lanza una excepción con un mensaje descriptivo si no es válido.
  static int validar(String texto) {
    final limpio = texto.trim();
    if (limpio.isEmpty) {
      throw FormatException('Ingresa un número');
    }

    if (limpio.length > 15) {
      throw FormatException('El número no puede tener más de 15 dígitos');
    }

    final numero = int.tryParse(limpio);
    if (numero == null) {
      throw FormatException('Ingresa un número válido');
    }

    if (numero <= 0) {
      throw FormatException('Debe ser un entero positivo');
    }

    return numero;
  }
}
