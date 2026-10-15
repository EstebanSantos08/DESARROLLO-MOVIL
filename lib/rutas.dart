import 'package:flutter/material.dart';
import 'pantallas/divisores_pantalla.dart';
import 'pantallas/inversion_pantalla.dart';
import 'pantallas/suma_digitos_pantalla.dart';

final Map<String, WidgetBuilder> rutas = {
  '/ej07': (context) => const DivisoresPantalla(),
  '/ej08': (context) => const InversionPantalla(),
  '/ej09': (context) => const SumaDigitosPantalla(),
};
