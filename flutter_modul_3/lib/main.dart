import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _kelvin = 0;
  double _reamur = 0;

  final TextEditingController _etInput = TextEditingController();

  void _konversiSuhu() {
    setState(() {
      // Ambil nilai dari input, kalau kosong anggap 0
      double celcius = double.tryParse(_etInput.text) ?? 0;

      // Rumus konversi
      _kelvin = celcius + 273.15;
      _reamur = celcius * (4 / 5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Konverter Suhu")),
        body: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              TextFormField(
                controller: _etInput,
                decoration: InputDecoration(
                  hintText: "Masukkan Suhu Dalam Celcius",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Kelvin"
                         ,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),

                      Text(
                        _kelvin.toStringAsFixed(2), 
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Reamur"
                        , style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),

                      Text(
                        _reamur.toStringAsFixed(2),
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ]
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _konversiSuhu,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Konversi Suhu"),
                ),
              ),

            ],
          ),
        ), 
      ),
    );
  }
}