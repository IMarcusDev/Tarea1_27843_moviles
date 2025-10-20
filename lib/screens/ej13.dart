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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Año Bisiesto', style: TextStyle(fontSize: 48)),
        backgroundColor: Color(0xFF898AC4),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(32),
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
                Icons.calendar_today_rounded,
                size: 48,
                color: Color(0xFF898AC4),
              ),
            ),

            SizedBox(height: 32),

            Text(
              'Verificar Año Bisiesto',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF898AC4),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 12),

            Text(
              'Ingresa un año para verificar si es bisiesto',
              style: TextStyle(fontSize: 17, color: Color(0xFFA2AADB)),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40),

            TextField(
              controller: anioCtrl,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF898AC4),
              ),
              decoration: InputDecoration(
                hintText: 'Ej: 2024',
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
                onPressed: procesarAnio,
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
                  'Verificar',
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
                      Icons.check_circle_outline,
                      color: Color(0xFF898AC4),
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      respuesta,
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
