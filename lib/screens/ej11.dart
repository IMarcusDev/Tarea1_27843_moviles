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

    return getTotal();
  }

  @override
  Widget build(BuildContext context) {
    double spaceSize = 12;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ejercicio 11'),
        backgroundColor: Color.fromARGB(255, 137, 138, 196),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            Text('Ingrese el precio del nuevo producto: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),

            SizedBox(height: spaceSize,),

            TextField(
              controller: preciosCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Precio'
              ),
            ),

            SizedBox(height: spaceSize,),

            ElevatedButton(
              onPressed: () => {
                addProduct(double.tryParse(preciosCtrl.text) ?? 0)
              }, 
              child: Text('Añadir Producto')
            ),

            SizedBox(height: spaceSize,),

            Text('Total: \$${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
          ],
        )
      ),
    );
  }

}
