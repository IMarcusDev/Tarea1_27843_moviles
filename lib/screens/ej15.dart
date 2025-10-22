import 'package:flutter/material.dart';

class Ej15Screen extends StatefulWidget {
  const Ej15Screen({super.key});

  @override
  State<Ej15Screen> createState() => _Ej15ScreenState();
}

class _Ej15ScreenState extends State<Ej15Screen> {
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
    final lastText = _lastWeightController.text.trim();
    if (lastText.isEmpty) {
      _showSnack('Ingresa el peso anterior');
      return;
    }

    final lastWeight = double.tryParse(lastText.replaceAll(',', '.'));
    if (lastWeight == null) {
      _showSnack('Peso anterior no es un número válido');
      return;
    }

    final List<double> readings = [];
    for (final c in _scaleControllers) {
      final t = c.text.trim();
      if (t.isEmpty) {
        _showSnack('Completa las 10 básculas');
        return;
      }
      final v = double.tryParse(t.replaceAll(',', '.'));
      if (v == null) {
        _showSnack('Entrada no numérica en las básculas');
        return;
      }
      readings.add(v);
    }

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

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _autoFillTestValues() {
    _lastWeightController.text = '70';
    for (int i = 0; i < 10; i++) {
      _scaleControllers[i].text = (70 + (i % 3) - 1).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 15 - Pesajes')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            TextField(
              controller: _lastWeightController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Peso anterior (kg)',
                border: OutlineInputBorder(),
              ),
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
              itemBuilder: (_, idx) => TextField(
                controller: _scaleControllers[idx],
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Báscula ${idx + 1}',
                  border: const OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _calculateForMember,
                  child: const Text('Calcular'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _autoFillTestValues,
                  child: const Text('Auto-fill'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    // Clear inputs
                    _lastWeightController.clear();
                    for (final c in _scaleControllers) {
                      c.clear();
                    }
                  },
                  child: const Text('Limpiar'),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              'Resultados (por miembro):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
    );
  }
}
