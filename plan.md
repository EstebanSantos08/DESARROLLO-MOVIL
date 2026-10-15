markdown
# Plan: App Flutter para Prueba 2, Grupo 2 (ejercicios 7, 8 y 9)

## Contexto
Prueba 2 de Resolución de Problemas. Soy Esteban David Santos Moreno (L00429400, grupo 2). Hay que desarrollar UNA aplicación en Flutter y Dart que resuelva los ejercicios 7, 8 y 9 del Grupo 2. Cada ejercicio pide ingresar un número entero positivo y mostrar un resultado.

Trabaja en español (comentarios, textos de la UI y mensajes de error).

Asumo que la app debe tener menú principal con navegación por rutas nombradas, igual que la tarea anterior. Si el enunciado no lo pide, sigue siendo válido, pero la estructura se puede simplificar.

## Enunciados
- **Ejercicio 7. Divisores de un número:** ingresar un número entero positivo, mostrar todos sus divisores e indicar cuántos divisores tiene.
- **Ejercicio 8. Inversión de un número:** ingresar un número entero positivo, invertir el orden de sus dígitos y mostrar el resultado.
- **Ejercicio 9. Suma de dígitos:** ingresar un número entero positivo, calcular la suma de sus dígitos e indicar si el resultado es par o impar.

## Convenciones de código (seguir el estilo de mis archivos existentes)
- La lógica va en clases de Dart puro dentro de `logica/`, sin depender de Flutter. Ejemplo de referencia: `CalculadoraLogica`.
- Las pantallas son `StatefulWidget` con `TextEditingController` para cada campo, con `dispose()`, y un método por acción que lee los campos, llama a la lógica y hace `setState`. Ejemplo de referencia: `CalculadoraPantalla`.
- Comentarios `// LOGICA` y `// Diseño` dentro de las pantallas.
- AppBar con `backgroundColor: Colors.blue`, campos con `OutlineInputBorder`, y `SingleChildScrollView` + `Column` con `CrossAxisAlignment.stretch`.
- Clases de pantalla terminan en `Pantalla` y de lógica en `Logica`.
- Usar `FilteringTextInputFormatter.digitsOnly` en los campos numéricos enteros.

## Estructura de carpetas

lib/
├── main.dart # MyApp: MaterialApp con routes y home = MenuPrincipal
├── rutas.dart # final rutas = { ‘/ej07’: (_) => ..., ‘/ej08’: ..., ‘/ej09’: ... }
├── menu/
│ └── menu_principal.dart # Tres cards (7, 8, 9) que navegan con pushNamed
├── logica/
│ ├── divisores_logica.dart # ej. 7
│ ├── inversion_logica.dart # ej. 8
│ └── suma_digitos_logica.dart # ej. 9
└── Pantallas/ # Usar el mismo nombre de carpeta en todo el proyecto
├── divisores_pantalla.dart
├── inversion_pantalla.dart
└── suma_digitos_pantalla.dart
test/
└── logica_test.dart

Nota: en la tarea anterior hubo inconsistencia entre `logica/` (minúscula) y `Pantallas/` (mayúscula). Decide un nombre y aplícalo en todo el proyecto, incluidos los imports.

## Menú y rutas
- `main.dart`: `MaterialApp(debugShowCheckedModeBanner: false, title: 'Prueba 2 - Grupo 2', theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)), home: const MenuPrincipal(), routes: rutas)`.
- `rutas.dart`: `Map<String, WidgetBuilder>` con `/ej07`, `/ej08` y `/ej09`.
- `menu_principal.dart`: AppBar "Prueba 2 - Grupo 2" y una card por ejercicio con número, título y descripción corta. Al tocar, `Navigator.pushNamed(context, ruta)`.
- Cada pantalla regresa al menú con el botón atrás del AppBar.

## Validación común (para los tres ejercicios)
- Campo vacío: mostrar "Ingresa un número".
- Número igual a 0 o negativo: mostrar "Debe ser un entero positivo".
- Límite de longitud: máximo 15 dígitos (`maxLength: 15`), para evitar desbordamiento de `int`.
- La validación se hace en la lógica con un método `validar(String texto)` que devuelve el entero o lanza una excepción con el mensaje, y la pantalla muestra el mensaje en lugar del resultado.

## Ejercicio 7: divisores
- **Lógica (`DivisoresLogica`):**
  - `List<int> divisores(int n)`: devuelve todos los divisores de `n`, incluyendo 1 y `n`, en orden ascendente. Puede recorrer de 1 a `n`, o de 1 a `√n` para mayor eficiencia, sumando el divisor complementario.
  - `int cantidad(int n)`: longitud de la lista.
- **Ejemplos:**
  - 1 → [1], cantidad 1.
  - 12 → [1, 2, 3, 4, 6, 12], cantidad 6.
  - 28 → [1, 2, 4, 7, 14, 28], cantidad 6.
- **Pantalla:** campo numérico, botón "Calcular". Muestra "Divisores:" con la lista separada por comas y "Cantidad de divisores: X". Si la lista es muy larga (más de 200 elementos), mostrar en un `Wrap` o `ListView` con scroll.

## Ejercicio 8: inversión de dígitos
- **Lógica (`InversionLogica`):** `int invertir(int n)` con aritmética, sin convertir a texto:

inv = 0
mientras n > 0:
inv = inv * 10 + n % 10
n = n ~/ 10

- **Caso especial:** los ceros finales desaparecen. 1200 → 21. Mostrar una nota en la UI: "Los ceros a la izquierda del resultado se eliminan".
- **Ejemplos:** 1234 → 4321, 1200 → 21, 7 → 7, 1001 → 1001.
- **Pantalla:** campo numérico, botón "Invertir". Muestra "Número invertido: X" y la nota del caso especial cuando el número termina en 0.

## Ejercicio 9: suma de dígitos
- **Lógica (`SumaDigitosLogica`):**
  - `int sumaDigitos(int n)`: suma de los dígitos de `n` con `n % 10` y `n ~/ 10`.
  - `bool esPar(int x)`: `x % 2 == 0`.
  - Clase de resultado `ResultadoSumaDigitos` con `suma` y `esPar`, o un par de valores.
- **Ejemplos:** 1234 → suma 10, par. 999 → suma 27, impar. 5 → suma 5, impar.
- **Pantalla:** campo numérico, botón "Calcular". Muestra "Suma de dígitos: X" y "El resultado es PAR" o "El resultado es IMPAR". Usar color verde para par y naranja para impar.

## Pruebas (`test/logica_test.dart`)
Probar solo la lógica, sin UI. Ejecutar con `flutter test`.
- Ej. 7:
  - `divisores(1)` es `[1]`.
  - `divisores(28)` es `[1, 2, 4, 7, 14, 28]`.
  - `cantidad(12)` es 6.
  - `cantidad(7)` es 2 (número primo).
- Ej. 8:
  - `invertir(1234)` es 4321.
  - `invertir(1200)` es 21.
  - `invertir(7)` es 7.
- Ej. 9:
  - `sumaDigitos(1234)` es 10 y es par.
  - `sumaDigitos(999)` es 27 y es impar.
  - `sumaDigitos(5)` es 5 y es impar.
- Validación: `validar("")`, `validar("0")`, `validar("-5")` y `validar("1234567890123456")` lanzan excepción.

## Orden de trabajo
1. Crear carpetas, `main.dart`, `rutas.dart` y `menu_principal.dart` con las tres rutas. Cada pantalla muestra "Pendiente". Verificar la navegación ida y vuelta.
2. Ejercicio 8, que es el más sencillo: lógica, pruebas y pantalla.
3. Ejercicio 9: lógica, pruebas y pantalla.
4. Ejercicio 7: lógica, pruebas y pantalla, con la lista de divisores en scroll.
5. Validación común en los tres ejercicios.
6. Verificar que la app compila con `flutter analyze` sin errores y probar los tres ejercicios en emulador o dispositivo.
7. Al final, resumir archivos creados y supuestos tomados (por ejemplo, incluir el 1 y el propio número como divisores).

## Entregables fuera de la app
- Capturas del menú y de cada ejercicio.
- Diagramas de flujo o pseudocódigo, solo si el docente los pide para esta prueba. El enunciado no lo indica.

## Criterios de aceptación
- La app compila y se ejecuta sin errores.
- El menú navega a los tres ejercicios y regresa.
- Cada ejercicio cumple su enunciado y valida la entrada.
- La lógica está separada de las pantallas y tiene pruebas que pasan.
- El código sigue el estilo de los archivos existentes.