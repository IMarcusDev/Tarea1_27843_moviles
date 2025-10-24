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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pesaje - Ejercicio 15'),
        backgroundColor: const Color(0xFF898AC4),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC0C9EE),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(Icons.fitness_center, size: 48, color: Color(0xFF898AC4)),
                ),

                const SizedBox(height: 24),
                const Text(
                  'Ritual de pesaje',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF898AC4)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Cada miembro se pesa en 10 básculas; se calcula el promedio y se compara con el peso anterior.',
                  style: TextStyle(color: Color(0xFFA2AADB)),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),
                const Text('Selecciona miembro:'),
                DropdownButton<int>(
                  value: _selectedMember,
                  isExpanded: true,
                  items: List.generate(
                    5,
                    (i) => DropdownMenuItem(value: i + 1, child: Text('Miembro ${i + 1}')),
                  ),
                  onChanged: (v) => setState(() => _selectedMember = v ?? 1),
                ),

                const SizedBox(height: 12),
                TextFormField(
                  controller: _lastWeightController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF898AC4)),
                  decoration: InputDecoration(
                    hintText: 'Ej: 70.5',
                    hintStyle: const TextStyle(color: Color(0xFFA2AADB)),
                    filled: true,
                    fillColor: const Color(0xFFFFF2E0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFC0C9EE), width: 2)),
                  ),
                  validator: _weightValidator,
                ),

                const SizedBox(height: 16),
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
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF898AC4)),
                    decoration: InputDecoration(
                      hintText: 'kg',
                      hintStyle: const TextStyle(color: Color(0xFFA2AADB)),
                      filled: true,
                      fillColor: const Color(0xFFFFF2E0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFC0C9EE), width: 2)),
                    ),
                    validator: _weightValidator,
                  ),
                ),

                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFFA2AADB), Color(0xFF898AC4)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ElevatedButton(
                    onPressed: _calculateForMember,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    child: const Text('Calcular', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),

                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(onPressed: _autoFillTestValues, child: const Text('Auto-fill')),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _lastWeightController.clear();
                            for (final c in _scaleControllers) c.clear();
                            _results.fillRange(0, _results.length, 'Sin datos');
                          });
                        },
                        child: const Text('Limpiar'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFC0C9EE), width: 2)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: const [
                      Icon(Icons.check_circle_outline, color: Color(0xFF898AC4)),
                      SizedBox(width: 12),
                      Expanded(child: Text('Resultados (por miembro):', style: TextStyle(fontSize: 18, color: Color(0xFF898AC4), fontWeight: FontWeight.bold))),
                    ]),
                    const SizedBox(height: 12),
                    ...List.generate(5, (i) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(children: [CircleAvatar(radius: 14, child: Text('${i + 1}')), const SizedBox(width: 12), Expanded(child: Text(_results[i], style: const TextStyle(fontSize: 16)))]))),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
