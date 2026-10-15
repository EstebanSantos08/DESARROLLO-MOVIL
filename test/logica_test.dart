import 'package:flutter_test/flutter_test.dart';
import 'package:santos_esteban_prueba1_grupo2/logica/divisores_logica.dart';
import 'package:santos_esteban_prueba1_grupo2/logica/inversion_logica.dart';
import 'package:santos_esteban_prueba1_grupo2/logica/suma_digitos_logica.dart';
import 'package:santos_esteban_prueba1_grupo2/logica/validador.dart';

void main() {
  group('Validación Común', () {
    test('Acepta enteros positivos válidos', () {
      expect(Validador.validar('1'), equals(1));
      expect(Validador.validar('1234'), equals(1234));
    });

    test('Lanza excepción en campo vacío', () {
      expect(() => Validador.validar(''), throwsA(isA<FormatException>()));
      expect(() => Validador.validar('   '), throwsA(isA<FormatException>()));
    });

    test('Lanza excepción si es 0 o negativo', () {
      expect(() => Validador.validar('0'), throwsA(isA<FormatException>()));
      expect(() => Validador.validar('-5'), throwsA(isA<FormatException>()));
    });

    test('Lanza excepción si supera 15 dígitos', () {
      expect(() => Validador.validar('1234567890123456'),
          throwsA(isA<FormatException>()));
    });
  });

  group('Ejercicio 7 - Divisores de un Número', () {
    final logica = DivisoresLogica();

    test('divisores(1) es [1]', () {
      expect(logica.divisores(1), equals([1]));
    });

    test('divisores(28) es [1, 2, 4, 7, 14, 28]', () {
      expect(logica.divisores(28), equals([1, 2, 4, 7, 14, 28]));
    });

    test('cantidad(12) es 6', () {
      expect(logica.cantidad(12), equals(6));
    });

    test('cantidad(7) es 2 (número primo)', () {
      expect(logica.cantidad(7), equals(2));
    });
  });

  group('Ejercicio 8 - Inversión de Dígitos', () {
    final logica = InversionLogica();

    test('invertir(1234) debe ser 4321', () {
      expect(logica.invertir(1234), equals(4321));
    });

    test('invertir(1200) debe ser 21 (elimina ceros finales)', () {
      expect(logica.invertir(1200), equals(21));
    });

    test('invertir(7) debe ser 7', () {
      expect(logica.invertir(7), equals(7));
    });

    test('invertir(1001) debe ser 1001', () {
      expect(logica.invertir(1001), equals(1001));
    });
  });

  group('Ejercicio 9 - Suma de Dígitos', () {
    final logica = SumaDigitosLogica();

    test('sumaDigitos(1234) es 10 y es par', () {
      final resultado = logica.procesar(1234);
      expect(resultado.suma, equals(10));
      expect(resultado.esPar, isTrue);
    });

    test('sumaDigitos(999) es 27 y es impar', () {
      final resultado = logica.procesar(999);
      expect(resultado.suma, equals(27));
      expect(resultado.esPar, isFalse);
    });

    test('sumaDigitos(5) es 5 y es impar', () {
      final resultado = logica.procesar(5);
      expect(resultado.suma, equals(5));
      expect(resultado.esPar, isFalse);
    });
  });
}
