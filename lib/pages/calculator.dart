import 'package:flutter/material.dart';

class CalculatorWidget extends StatefulWidget {
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  Color cardColor = Colors.transparent;
  String result = "";

  void calculateBMI() {
    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);

    // Formula BMI
    double bmi = weight / ((height / 100) * (height / 100));

    // Interpretation of BMI
    String interpretation;
    if (bmi < 18.5) {
      interpretation = "Underweight";
      cardColor = Colors.red;
    } else if (bmi >= 18.5 && bmi < 24.9) {
      interpretation = "Normal weight";
      cardColor = Colors.green;
    } else if (bmi >= 25 && bmi < 29.9) {
      interpretation = "Overweight";
      cardColor = Colors.yellow;
    } else {
      interpretation = "Obesity";
      cardColor = Colors.red;
    }

    setState(() {
      result = "BMI: ${bmi.toStringAsFixed(2)}\n$interpretation";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Height (cm)"),
                    ),
                    TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Weight (kg)"),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        calculateBMI();
                      },
                      child: Text("Calculate"),
                    ),
                  ],
                ),
              ),
              result.isNotEmpty
                  ? Card(
                      margin: EdgeInsets.all(16),
                      color: cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          result,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
