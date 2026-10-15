import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../logica/divisores_logica.dart';
import '../logica/validador.dart';

class DivisoresPantalla extends StatefulWidget {
  const DivisoresPantalla({super.key});

  @override
  State<DivisoresPantalla> createState() => _DivisoresPantallaState();
}

class _DivisoresPantallaState extends State<DivisoresPantalla> {
  // LOGICA
  final TextEditingController _numeroController = TextEditingController();
  final DivisoresLogica _logica = DivisoresLogica();

  List<int>? _divisores;
  int? _cantidad;
  String? _mensajeError;

  @override
  void dispose() {
    _numeroController.dispose();
    super.dispose();
  }

  void _calcularDivisores() {
    setState(() {
      _mensajeError = null;
      _divisores = null;
      _cantidad = null;

      try {
        final numero = Validador.validar(_numeroController.text);
        final lista = _logica.divisores(numero);
        _divisores = lista;
        _cantidad = lista.length;
      } catch (e) {
        if (e is FormatException) {
          _mensajeError = e.message;
        } else {
          _mensajeError = 'Ocurrió un error inesperado';
        }
      }
    });
  }

  void _limpiar() {
    setState(() {
      _numeroController.clear();
      _divisores = null;
      _cantidad = null;
      _mensajeError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Diseño
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 7: Divisores'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Calcular divisores de un número',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ingresa un número entero positivo para conocer todos sus divisores y la cantidad total de los mismos.',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _numeroController,
              keyboardType: TextInputType.number,
              maxLength: 15,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: 'Número entero positivo',
                hintText: 'Ej. 28',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.pie_chart_outline),
                counterText: '',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _calcularDivisores,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Calcular'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: _limpiar,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Limpiar'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_mensajeError != null)
              Card(
                color: Colors.red.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.red.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _mensajeError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (_divisores != null && _cantidad != null)
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Resultado:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Cantidad de divisores: $_cantidad',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Divisores:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        constraints: const BoxConstraints(maxHeight: 250),
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: SingleChildScrollView(
                          child: SelectableText(
                            _divisores!.join(', '),
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.5,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
