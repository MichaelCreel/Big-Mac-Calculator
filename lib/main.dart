import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  String _output = '0';
  String _memory = '';

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '';
      } else if (buttonText == '=') {
        //CALCULATOR HERE
      } else if (buttonText == 'DEL') {
        if (_output != '') {
          _output = _output.substring(0, _output.length - 1);
        }
      } else if (buttonText == 'M+') {
        _memory = _output;
      } else if (buttonText == 'MP') {
        _output += _memory;
      } else {
        _output += buttonText;
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
          child: Text(_output,
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
              ],)
            ],
          ),
        ),
      ],
    );
  }
}
