// Disponemos de una máquina que puede dar vuelto con 5 tipos de monedas distintas: $2, $1, $0.50, $0.25, $0.10.
// Realizar el programa que, dados el precio del artículo y la cantidad entregada por el consumidor, nos indique el vuelto a entregar empleando el menor número posible de monedas.

import 'package:flutter/material.dart';

class Ejercicio12View extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Ejercicio12State();
}

class _Ejercicio12State extends State<Ejercicio12View> {
  // { Centavos: Cantidad }
  Map<int, int> vuelto = {
    200: 0,
    100: 0,
    50: 0,
    25: 0,
    10: 0
  };

  // Controlador
  final valueCtrl = TextEditingController();

  void clearVuelto() {
    setState(() {
      for (int cents in vuelto.keys) {
        vuelto[cents] = 0;
      }
    });
  }

  void setVueltoCants(double value) {
    int precioCents = (value * 100).round();

    clearVuelto();

    setState(() {
      if (precioCents % 5 == 0 && precioCents % 10 != 0) {  // Por si termina en 5
        vuelto[25] = (vuelto[25] ?? 0) + 1;
        precioCents -= 25;
      }

      for (int cents in [200, 100, 50, 10]) {
        vuelto[cents] = (vuelto[cents] ?? 0) + precioCents ~/ cents;
        precioCents %= cents;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Vuelto Óptimo', style: TextStyle(fontSize: 36)),
        backgroundColor: Color(0xFF898AC4),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFC0C9EE),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.monetization_on_outlined,
                size: 48,
                color: Color(0xFF898AC4),
              ),
            ),

            SizedBox(height: 32),

            Text(
              'Calculadora de Vuelto',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF898AC4),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 12),

            Text(
              'Ingresa el monto del vuelto a entregar: ',
              style: TextStyle(fontSize: 17, color: Color(0xFFA2AADB)),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40),

            TextField(
              controller: valueCtrl,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF898AC4),
              ),
              decoration: InputDecoration(
                hintText: '\$3.85',
                hintStyle: TextStyle(color: Color(0xFFA2AADB)),
                filled: true,
                fillColor: Color(0xFFFFF2E0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFC0C9EE), width: 2),
                ),
              ),
            ),

            SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFA2AADB), Color(0xFF898AC4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ElevatedButton(
                onPressed: () {
                  setVueltoCants(double.tryParse(valueCtrl.text) ?? 0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Calcular',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24),

            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFFC0C9EE), width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Distribución de monedas:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF898AC4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  buildMonedaRow("\$2.00", vuelto[200]),
                  buildMonedaRow("\$1.00", vuelto[100]),
                  buildMonedaRow("\$0.50", vuelto[50]),
                  buildMonedaRow("\$0.25", vuelto[25]),
                  buildMonedaRow("\$0.10", vuelto[10]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMonedaRow(String label, int? cantidad) {
    return Row(
      children: [
        Icon(Icons.circle, color: Color(0xFF898AC4), size: 10),
        SizedBox(width: 8),
        Text(
          'Monedas de $label: $cantidad',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF898AC4),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
