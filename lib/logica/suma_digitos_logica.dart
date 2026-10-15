// Lógica para la suma de dígitos y determinación de paridad

class ResultadoSumaDigitos {
  final int suma;
  final bool esPar;

  const ResultadoSumaDigitos({
    required this.suma,
    required this.esPar,
  });
}

class SumaDigitosLogica {
  /// Calcula la suma de los dígitos de [n] utilizando operaciones aritméticas (% y ~/).
  int sumaDigitos(int n) {
    int suma = 0;
    int numero = n;
    while (numero > 0) {
      suma += numero % 10;
      numero = numero ~/ 10;
    }
    return suma;
  }

  /// Determina si [x] es par.
  bool esPar(int x) {
    return x % 2 == 0;
  }

  /// Procesa el número calculando la suma y verificando su paridad.
  ResultadoSumaDigitos procesar(int n) {
    final suma = sumaDigitos(n);
    final par = esPar(suma);
    return ResultadoSumaDigitos(suma: suma, esPar: par);
  }
}
