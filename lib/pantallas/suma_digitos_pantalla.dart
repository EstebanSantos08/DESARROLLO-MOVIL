import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../logica/suma_digitos_logica.dart';
import '../logica/validador.dart';

class SumaDigitosPantalla extends StatefulWidget {
  const SumaDigitosPantalla({super.key});

  @override
  State<SumaDigitosPantalla> createState() => _SumaDigitosPantallaState();
}

class _SumaDigitosPantallaState extends State<SumaDigitosPantalla> {
  // LOGICA
  final TextEditingController _numeroController = TextEditingController();
  final SumaDigitosLogica _logica = SumaDigitosLogica();

  ResultadoSumaDigitos? _resultado;
  String? _mensajeError;

  @override
  void dispose() {
    _numeroController.dispose();
    super.dispose();
  }

  void _calcularSuma() {
    setState(() {
      _mensajeError = null;
      _resultado = null;

      try {
        final numero = Validador.validar(_numeroController.text);
        _resultado = _logica.procesar(numero);
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
    });
  }

  @override
  Widget build(BuildContext context) {
    // Diseño
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 9: Suma de Dígitos'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Calcular suma de dígitos y paridad',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ingresa un número entero positivo para sumar todos sus dígitos e identificar si la suma resultante es par o impar.',
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
                prefixIcon: Icon(Icons.calculate),
                counterText: '',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _calcularSuma,
                    icon: const Icon(Icons.check_circle_outline),
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
                      const SizedBox(height: 10),
                      Text(
                        'Suma de dígitos: ${_resultado!.suma}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: _resultado!.esPar
                              ? Colors.green.shade50
                              : Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _resultado!.esPar
                                ? Colors.green.shade400
                                : Colors.orange.shade400,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _resultado!.esPar
                                  ? Icons.check_circle
                                  : Icons.info,
                              color: _resultado!.esPar
                                  ? Colors.green.shade700
                                  : Colors.orange.shade800,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _resultado!.esPar
                                  ? 'El resultado es PAR'
                                  : 'El resultado es IMPAR',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _resultado!.esPar
                                    ? Colors.green.shade800
                                    : Colors.orange.shade900,
                              ),
                            ),
                          ],
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
