import 'package:flutter/material.dart';

class Ej15Screen extends StatefulWidget {
  const Ej15Screen({super.key});

  @override
  State<Ej15Screen> createState() => _Ej15ScreenState();
}

class _Ej15ScreenState extends State<Ej15Screen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _lastWeightController = TextEditingController();
  final List<TextEditingController> _scaleControllers = List.generate(
    10,
    (_) => TextEditingController(),
  );

  final List<String> _results = List.filled(5, 'Sin datos');
  int _selectedMember = 1;

  @override
  void dispose() {
    _lastWeightController.dispose();
    for (final c in _scaleControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _calculateForMember() {
    // Validar formulario
    if (!_formKey.currentState!.validate()) return;

    final lastWeight = double.parse(_lastWeightController.text.replaceAll(',', '.'));
    final List<double> readings = _scaleControllers
        .map((c) => double.parse(c.text.replaceAll(',', '.')))
        .toList();

    final avg = readings.reduce((a, b) => a + b) / readings.length;
    final diff = double.parse((avg - lastWeight).toStringAsFixed(2));

    final status = diff > 0
        ? 'SUBIO'
        : diff < 0
        ? 'BAJO'
        : 'NO CAMBIO';
    final amount = diff.abs().toStringAsFixed(2);

    final result = status == 'NO CAMBIO'
        ? 'NO CAMBIO (0.00 kg)'
        : '$status: $amount kg';

    setState(() {
      _results[_selectedMember - 1] = result;
    });
  }

  // _showSnack was removed: prefer Form validators and inline messages for feedback.

  void _autoFillTestValues() {
    setState(() {
      _lastWeightController.text = '70';
      for (int i = 0; i < 10; i++) {
        _scaleControllers[i].text = (70 + (i % 3) - 1).toString();
      }
    });
  }

  String? _weightValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Ingresa un valor';
    final v = double.tryParse(value.replaceAll(',', '.'));
    if (v == null) return 'Número no válido';
    if (v <= 0) return 'Debe ser mayor que 0';
    if (v > 500) return 'Valor demasiado grande';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 15 - Pesajes')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFC0C9EE),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.fitness_center, size: 48, color: Color(0xFF898AC4)),
              ),

              const SizedBox(height: 16),
              const Text(
                'Ritual de pesaje',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF898AC4)),
              ),
              const SizedBox(height: 8),
              const Text('Ingresa el peso anterior y las 10 lecturas para cada miembro (1-5).'),

              const SizedBox(height: 12),
              const Text('Selecciona miembro (1-5):'),
              DropdownButton<int>(
                value: _selectedMember,
                items: List.generate(
                  5,
                  (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text('Miembro ${i + 1}'),
                  ),
                ),
                onChanged: (v) => setState(() => _selectedMember = v ?? 1),
              ),

              const SizedBox(height: 12),
              TextFormField(
                controller: _lastWeightController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Peso anterior (kg)',
                  border: OutlineInputBorder(),
                ),
                validator: _weightValidator,
              ),

              const SizedBox(height: 12),
              const Text('Ingrese las 10 lecturas de las básculas (kg):'),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 5,
                ),
                itemCount: 10,
                itemBuilder: (_, idx) => TextFormField(
                  controller: _scaleControllers[idx],
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Báscula ${idx + 1}',
                    border: const OutlineInputBorder(),
                  ),
                  validator: _weightValidator,
                ),
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton(onPressed: _calculateForMember, child: const Text('Calcular')),
                  const SizedBox(width: 12),
                  ElevatedButton(onPressed: _autoFillTestValues, child: const Text('Auto-fill')),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Clear inputs
                      setState(() {
                        _lastWeightController.clear();
                        for (final c in _scaleControllers) {
                          c.clear();
                        }
                      });
                    },
                    child: const Text('Limpiar'),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Text('Resultados (por miembro):', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...List.generate(
                5,
                (i) => ListTile(
                  leading: CircleAvatar(child: Text('${i + 1}')),
                  title: Text(_results[i]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
