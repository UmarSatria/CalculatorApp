import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayInput = "";
  String displayOutput = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "c") {
        displayInput = "";
        displayOutput = "";
      } else if (buttonText == "=") {
        try {
          final input = displayInput.replaceAll('X', '*');
          final parser = Parser();
          final expression = parser.parse(input);
          final contextModel = ContextModel();
          final result = expression.evaluate(EvaluationType.REAL, contextModel);
          displayOutput = result.toString();
        } catch (e) {
          displayOutput = "Error";
        }
      } else {
        displayInput += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> buttons = [
      "7", "8", "9", "/",
      "4", "5", "6", "X",
      "1", "2", "3", "-",
      "c", "0", "=", "+"
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    displayInput,
                    style: const TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  Text(
                    displayOutput,
                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 40),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.2,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                Color textColor = Colors.white;
                if (buttons[index] == "-" || buttons[index] == "X" || buttons[index] == "+" || buttons[index] == "/" || buttons[index] == "=") {
                  textColor = Colors.green;
                }
                if (buttons[index] == "c") {
                  textColor = Colors.red;
                }
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.grey.withOpacity(0.2),
                    child: Text(
                      buttons[index],
                      style: TextStyle(color: textColor, fontSize: 24),
                    ),
                    onPressed: () {
                      buttonPressed(buttons[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
