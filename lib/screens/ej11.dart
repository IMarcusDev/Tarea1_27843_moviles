// En un supermercado, un cajero captura los precios de los artículos que los clientes compran e indica a cada cliente cuál es el monto de lo que deben pagar.
// Al final del día le indica a su supervisor cuánto fue lo que cobró en total a todos los clientes que pasaron por su caja.

import 'package:flutter/material.dart';

class Ejercicio11View extends StatefulWidget {
  const Ejercicio11View({super.key});

  @override
  State<StatefulWidget> createState() => _Ejercicio11State();
}

class _Ejercicio11State extends State<Ejercicio11View> {
  List<double> precios = [];

  double total = 0;

  // Text Controllers
  final preciosCtrl = TextEditingController();

  double getTotal() {
    double total = 0;

    for (double p in precios) {
      total += p;
    }

    setState(() {
      this.total = total;
    });

    return total;
  }

  // Añadir precio
  double addProduct(double price) {
    precios.add(price);
    preciosCtrl.clear();  // Limpiar campo después de añadir
    return getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Caja Supermercado', style: TextStyle(fontSize: 36)),
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
                Icons.shopping_cart_outlined,
                size: 48,
                color: Color(0xFF898AC4),
              ),
            ),

            SizedBox(height: 32),

            Text(
              'Captura de Precios',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF898AC4),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 12),

            Text(
              'Ingresa el precio de cada artículo que el cliente está comprando',
              style: TextStyle(fontSize: 17, color: Color(0xFFA2AADB)),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40),

            TextField(
              controller: preciosCtrl,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF898AC4),
              ),
              decoration: InputDecoration(
                hintText: 'Ej: 12.50',
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
                  addProduct(double.tryParse(preciosCtrl.text) ?? 0);
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
                  'Añadir Producto',
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
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFFC0C9EE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.attach_money,
                      color: Color(0xFF898AC4),
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Total cobrado: \$${total.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF898AC4),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
