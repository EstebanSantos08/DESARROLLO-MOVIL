import 'package:flutter/material.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba 2 - Grupo 2'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Seleccione un ejercicio:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _crearCardEjercicio(
              context: context,
              numero: '7',
              titulo: 'Divisores de un número',
              descripcion:
                  'Ingresa un número entero positivo para mostrar todos sus divisores y cuántos tiene.',
              icono: Icons.pie_chart_outline,
              ruta: '/ej07',
            ),
            const SizedBox(height: 12),
            _crearCardEjercicio(
              context: context,
              numero: '8',
              titulo: 'Inversión de un número',
              descripcion:
                  'Ingresa un número entero positivo para invertir el orden de sus dígitos.',
              icono: Icons.swap_horiz,
              ruta: '/ej08',
            ),
            const SizedBox(height: 12),
            _crearCardEjercicio(
              context: context,
              numero: '9',
              titulo: 'Suma de dígitos',
              descripcion:
                  'Ingresa un número entero positivo para calcular la suma de sus dígitos e indicar si es par o impar.',
              icono: Icons.calculate_outlined,
              ruta: '/ej09',
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearCardEjercicio({
    required BuildContext context,
    required String numero,
    required String titulo,
    required String descripcion,
    required IconData icono,
    required String ruta,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.pushNamed(context, ruta);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                foregroundColor: Colors.blue.shade800,
                radius: 24,
                child: Text(
                  numero,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      descripcion,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
