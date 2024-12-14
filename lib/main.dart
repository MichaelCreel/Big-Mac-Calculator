import 'package:flutter/material.dart';
import 'package:expression_language/expression_language.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(700, 566),
    minimumSize: Size(375, 566),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(
    windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
  }
  );
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
  String history2 = '';
  String history1 = '';
  String equation = '';
  String memory = '';
  String unit = '';

  void buttonPressed(String buttonText) {
    setState(() {
      unit = '';
      if (buttonText == 'C') {
        if (equation != '') {
          equation = '';
        } else {
          history1 = '';
          history2 = '';
        }
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
        history1 += 'm\u2192d';
        unit = 'Big Mac Diameters';
      } else if (buttonText == 'm\u00B3\u2192V') {
        equation = Solve(equation);
        equation = Solve("$equation/0.00041");
        history1 += 'm\u00B3\u2192V';
        unit = 'Big Macs';
      } else if (buttonText == 'kg\u2192W') {
        equation = Solve(equation);
        equation = Solve("$equation/0.215");
        history1 += 'kg\u2192W';
        unit = 'Big Macs';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(history2, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),),
              Text(history1, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),),
              Text(equation, style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),),
              Text(unit, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal,)),
            ],
          )),
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
    if (input != '') {
      history2 = history1;
      history1 = equation;
      var context = <String, ExpressionProviderElement>{};
      var expressionParser = ExpressionParser(context);
      var parsedExpression = expressionParser.parse(input);
      var evaluator = parsedExpression.evaluate();
      return evaluator.toString();
    }
    return '';
  }
}
