import 'package:flutter/material.dart';
import 'package:expression_language/expression_language.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[900],
    scaffoldBackgroundColor: Colors.grey[900]
  );

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.grey[50],
    scaffoldBackgroundColor: Colors.grey[50]
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Big Mac Calculator'),
        ),
        body: Calculator(),
      )
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  String equation = '';
  String memory = '';
  String unit = '';

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '';
      } else if (buttonText == '=') {
        equation = Solve(equation);
      } else if (buttonText == 'DEL') {
        if (equation != '') {
          equation = equation.substring(0, equation.length - 1);
        }
      } else if (buttonText == 'M+') {
        memory = equation;
      } else if (buttonText == 'MP') {
        equation += memory;
      } else if (buttonText == 'm\u2192d') {
        equation = Solve(equation);
        equation = Solve("$equation/0.09525");
      } else if (buttonText == 'm\u00B3\u2192V') {
        equation = Solve(equation);
        equation = Solve("$equation/0.00041");
      } else if (buttonText == 'kg\u2192W') {
        equation = Solve(equation);
        equation = Solve("$equation/0.215");
      } else {
        equation += buttonText;
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(buttonText, style: TextStyle(fontSize: 24.0),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          alignment: Alignment.centerRight,
          child: Text(equation,
            style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),),
        ),
        Divider(),
        Expanded(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              Row(children: <Widget>[
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-'),
              ],),
              Row(children: <Widget>[
                _buildButton('DEL'),
                _buildButton('0'),
                _buildButton('.'),
                _buildButton('+'),
              ],),
              Row(children: <Widget>[
                _buildButton('C'),
                _buildButton('M+'),
                _buildButton('MP'),
                _buildButton('='),
              ],),
              Row(children: <Widget>[
                _buildButton('m\u2192d'),
                _buildButton('m\u00B3\u2192V'),
                _buildButton('kg\u2192W')
              ],)
            ],
          ),
        ),
      ],
    );
  }

  String Solve(String input) {
    var context = <String, ExpressionProviderElement>{};
    var expressionParser = ExpressionParser(context);
    var parsedExpression = expressionParser.parse(input);
    var evaluator = parsedExpression.evaluate();
    return evaluator.toString();
  }
}
