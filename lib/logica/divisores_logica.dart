import 'dart:math';

// Lógica para obtener los divisores de un número entero positivo

class DivisoresLogica {
  /// Devuelve la lista de todos los divisores de [n] en orden ascendente,
  /// incluyendo el 1 y el propio número.
  List<int> divisores(int n) {
    if (n <= 0) return [];

    final List<int> lista = [];
    final int limite = sqrt(n).toInt();

    for (int i = 1; i <= limite; i++) {
      if (n % i == 0) {
        lista.add(i);
        final int complemento = n ~/ i;
        if (complemento != i) {
          lista.add(complemento);
        }
      }
    }

    lista.sort();
    return lista;
  }

  /// Devuelve la cantidad total de divisores de [n].
  int cantidad(int n) {
    return divisores(n).length;
  }
}
