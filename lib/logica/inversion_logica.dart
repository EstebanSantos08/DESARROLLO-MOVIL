// Lógica para la inversión de dígitos de un número entero positivo

class InversionLogica {
  /// Invierte el orden de los dígitos de [n] utilizando operaciones aritméticas.
  /// No convierte el número a cadena de texto.
  int invertir(int n) {
    int inv = 0;
    int numero = n;
    while (numero > 0) {
      inv = inv * 10 + (numero % 10);
      numero = numero ~/ 10;
    }
    return inv;
  }
}
