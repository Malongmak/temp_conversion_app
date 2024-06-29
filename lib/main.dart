import 'package:flutter/material.dart';

void main() {
  runApp(const TempConversionApp());
}

class TempConversionApp extends StatelessWidget {
  const TempConversionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TempConversionHomePage(),
    );
  }
}

class TempConversionHomePage extends StatefulWidget {
  const TempConversionHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TempConversionHomePageState createState() => _TempConversionHomePageState();
}

class _TempConversionHomePageState extends State<TempConversionHomePage> {
  bool isFahrenheitToCelsius = true;
  TextEditingController inputController = TextEditingController();
  String result = '';
  List<String> history = [];

  void convertTemperature() {
    double input = double.tryParse(inputController.text) ?? 0.0;
    double output;
    String conversion;

    if (isFahrenheitToCelsius) {
      output = (input - 32) * 5 / 9;
      conversion = 'F to C: $input => ${output.toStringAsFixed(2)}';
    } else {
      output = (input * 9 / 5) + 32;
      conversion = 'C to F: $input => ${output.toStringAsFixed(2)}';
    }

    setState(() {
      result = output.toStringAsFixed(2);
      history.insert(0, conversion);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Conversion'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio<bool>(
                      value: true,
                      groupValue: isFahrenheitToCelsius,
                      onChanged: (value) {
                        setState(() {
                          isFahrenheitToCelsius = value!;
                        });
                      },
                    ),
                    const Text('Fahrenheit to Celsius'),
                    Radio<bool>(
                      value: false,
                      groupValue: isFahrenheitToCelsius,
                      onChanged: (value) {
                        setState(() {
                          isFahrenheitToCelsius = value!;
                        });
                      },
                    ),
                    const Text('Celsius to Fahrenheit'),
                  ],
                ),
                TextField(
                  controller: inputController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter temperature',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: convertTemperature,
                  child: const Text('Convert'),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Result: $result',
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          history[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
