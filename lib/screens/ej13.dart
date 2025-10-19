import 'package:flutter/material.dart';

class DeterminarAnioBisiesto extends StatefulWidget {
  @override
  State<DeterminarAnioBisiesto> createState() =>
      _DeterminarAnioBisiestoPageState();
}

class _DeterminarAnioBisiestoPageState extends State<DeterminarAnioBisiesto> {
  final anioCtrl = TextEditingController();

  bool esBisiesto = false;
  String respuesta = "";

  void procesarAnio() {
    final anio = int.tryParse(anioCtrl.text) ?? 0;

    setState(() {
      if (anio % 4 == 0) {
        esBisiesto = true;
        if (anio % 100 == 0 && anio % 400 != 0) {
          esBisiesto = false;
        }
      }

      if (esBisiesto) {
        respuesta = "El año $anio ingresado es un año bisiesto";
      } else {
        respuesta = "El año $anio ingresado no es un año bisiesto";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comprobar año bisiesto'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ingrese el año que desea comprbar si es o no bisiesto',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            TextField(
              controller: anioCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Año',
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(onPressed: procesarAnio, child: Text('Comprobar')),
            SizedBox(height: 12),
            Text(respuesta),
          ],
        ),
      ),
    );
  }
}
