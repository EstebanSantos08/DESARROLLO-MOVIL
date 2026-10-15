import 'package:flutter_test/flutter_test.dart';
import 'package:santos_esteban_prueba1_grupo2/main.dart';

void main() {
  testWidgets('Verifica que la app inicia con el Menú Principal',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Prueba 2 - Grupo 2'), findsOneWidget);
    expect(find.text('Divisores de un número'), findsOneWidget);
    expect(find.text('Inversión de un número'), findsOneWidget);
    expect(find.text('Suma de dígitos'), findsOneWidget);
  });
}
