import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../logica/inversion_logica.dart';
import '../logica/validador.dart';

class InversionPantalla extends StatefulWidget {
  const InversionPantalla({super.key});

  @override
  State<InversionPantalla> createState() => _InversionPantallaState();
}

class _InversionPantallaState extends State<InversionPantalla> {
  // LOGICA
  final TextEditingController _numeroController = TextEditingController();
  final InversionLogica _logica = InversionLogica();

  int? _resultado;
  String? _mensajeError;
  bool _terminaEnCero = false;

  @override
  void dispose() {
    _numeroController.dispose();
    super.dispose();
  }

  void _invertirNumero() {
    setState(() {
      _mensajeError = null;
      _resultado = null;
      _terminaEnCero = false;

      try {
        final numero = Validador.validar(_numeroController.text);
        _resultado = _logica.invertir(numero);
        _terminaEnCero = (numero % 10 == 0);
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
      _resultado = null;
      _mensajeError = null;
      _terminaEnCero = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Diseño
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 8: Inversión'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Invertir orden de los dígitos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ingresa un número entero positivo para invertir sus dígitos mediante cálculo aritmético.',
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
                hintText: 'Ej. 1234',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
                counterText: '',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _invertirNumero,
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text('Invertir'),
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
            if (_resultado != null)
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
                      const SizedBox(height: 8),
                      Text(
                        'Número invertido: $_resultado',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      if (_terminaEnCero) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.amber.shade300),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline,
                                  color: Colors.amber.shade900, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Nota: Los ceros a la izquierda del resultado se eliminan.',
                                  style: TextStyle(
                                    color: Colors.amber.shade900,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
