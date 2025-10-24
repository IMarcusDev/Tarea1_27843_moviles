import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeterminarNumeroPerfecto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeterminarNumeroPerfectoPageState();
}

class _DeterminarNumeroPerfectoPageState
    extends State<DeterminarNumeroPerfecto> {
  final numeroCtrl = TextEditingController();
  bool esPerfecto = false;
  String respuesta = "";
  String divisoresTexto = "";

  void procesarNumero() {
    if (numeroCtrl.text.isEmpty) {
      setState(() {
        respuesta =
            "El campo se encuentra vacio, por favor ingresar un numero mayor a uno";
      });
      return;
    }

    final numero = int.tryParse(numeroCtrl.text) ?? 0;

    if (numero <= 1) {
      setState(() {
        respuesta = "Por favor ingresa un número mayor a uno";
        divisoresTexto = "";
      });
      return;
    }

    if (numero > 1000000) {
      setState(() {
        respuesta = "Por favor ingresa un número menor";
        divisoresTexto = "";
      });
      return;
    }

    int suma = 0;
    List<int> divisores = [];

    setState(() {
      for (int i = 1; i < numero; i++) {
        if (numero % i == 0) {
          suma += i;
          divisores.add(i);
        }
      }

      esPerfecto = (suma == numero);
      divisoresTexto = "Divisores: ${divisores.join(" + ")} = $suma";

      if (esPerfecto) {
        respuesta = "El número $numero es un número perfecto";
      } else {
        respuesta = "El número $numero no es un número perfecto";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Número Perfecto', style: TextStyle(fontSize: 32)),
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
                Icons.calculate_rounded,
                size: 48,
                color: Color(0xFF898AC4),
              ),
            ),

            SizedBox(height: 32),

            Text(
              'Verificar Número Perfecto',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF898AC4),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 12),

            Text(
              'Ingresa un número valido para verificar si es perfecto, sino se tomara como 0',
              style: TextStyle(fontSize: 17, color: Color(0xFFA2AADB)),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40),

            TextField(
              controller: numeroCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF898AC4),
              ),
              decoration: InputDecoration(
                hintText: 'Ej: 28',
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
                onPressed: procesarNumero,
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

            SizedBox(height: 20),

            Text(
              ' $divisoresTexto',
              style: TextStyle(fontSize: 20, color: Color(0xFFA2AADB)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
